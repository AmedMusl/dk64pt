ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/hints_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/map_mapping.lua")
ScriptHost:LoadScript("scripts/dropsanity.lua")

-- ===== GLOBAL VARIABLES =====
CUR_INDEX = -1
SLOT_DATA = nil
LEVEL_POSITIONS = {}
VISITED_LOBBIES = {}
SAVED_LOBBIES_BY_SLOT = SAVED_LOBBIES_BY_SLOT or {}

-- Slot data features
SWITCHSANITY = nil
BLOCKER_VALUES = nil
JUNK_LOCATIONS = nil
ENEMY_DATA = nil

-- Current item mapping (version-dependent)
CURRENT_ITEM_MAPPING = ITEM_MAPPING

-- ===== UTILITY FUNCTIONS =====

-- Function to check if version is >= 1.1.0
function isVersion110OrHigher(version)
    if not version then
        return true -- Default to true for new versions if no version specified
    end
    
    local major, minor, patch = version:match("(%d+)%.(%d+)%.(%d+)")
    if major and minor and patch then
        major, minor, patch = tonumber(major), tonumber(minor), tonumber(patch)
        return major > 1 or (major == 1 and minor > 1) or (major == 1 and minor == 1 and patch >= 0)
    end
    
    return false
end

-- Function to set up version-appropriate item mapping
function setupItemMappingForVersion(version)
    -- Start with a fresh copy of the standard mappings
    CURRENT_ITEM_MAPPING = {}
    for k, v in pairs(ITEM_MAPPING) do
        CURRENT_ITEM_MAPPING[k] = v
    end
    
    -- If version < 1.1.0, replace with legacy mappings
    if not isVersion110OrHigher(version) then
        -- Remove the new item mappings
        local newMappings = {14041270, 14041271, 14041273, 14041272, 14041167, 14041269, 14041169}
        for _, id in ipairs(newMappings) do
            CURRENT_ITEM_MAPPING[id] = nil
        end
        
        -- Add legacy mappings
        for k, v in pairs(LEGACY_ITEM_MAPPING) do
            CURRENT_ITEM_MAPPING[k] = v
        end
        
        -- print("Using legacy item mappings for version " .. (version or "unknown"))
    -- else
    --     print("Using current item mappings for version " .. (version or "latest"))
    end
end

-- ===== BLOCKER AND LEVEL MANAGEMENT =====
function updateBLockerTrackerItems()
    if not BLOCKER_VALUES or type(BLOCKER_VALUES) ~= "string" then
        return
    end
    
    -- Map level names to blocker tracker codes
    local level_to_blocker = {
        ["Japes"] = "blocker1",
        ["Aztec"] = "blocker2", 
        ["Factory"] = "blocker3",
        ["Galleon"] = "blocker4",
        ["Forest"] = "blocker5",
        ["Caves"] = "blocker6",
        ["Castle"] = "blocker7",
        ["Helm"] = "blocker8"
    }
    
    -- Parse the BLockerValues string and update tracker item counts
    for level_name, blocker_code in pairs(level_to_blocker) do
        local pattern = level_name .. ":%s*(%d+)%s+([^,]+)"
        local count, item_type = BLOCKER_VALUES:match(pattern)
        
        if count then
            local obj = Tracker:FindObjectForCode(blocker_code)
            if obj then
                local count_num = tonumber(count) or 0
                -- Only update the count, don't affect item collection state
                if obj.AcquiredCount ~= nil then
                    obj.AcquiredCount = count_num
                elseif obj.CurrentStage ~= nil then
                    obj.CurrentStage = count_num
                end
                -- print("Set " .. blocker_code .. " requirement to " .. count_num .. " (from " .. level_name .. ")")
            end
        end
    end
end

-- Function to clear blocker tracker items when no BLockerValues
function clearBLockerTrackerItems()
    for i = 1, 8 do
        local obj = Tracker:FindObjectForCode("blocker" .. i)
        if obj then
            -- Only clear the count, don't affect collection state
            if obj.AcquiredCount ~= nil then
                obj.AcquiredCount = 0
            elseif obj.CurrentStage ~= nil then
                obj.CurrentStage = 0
            end
        end
    end
end

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then return 1 end
    end
    return 0
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

local function activate_object(obj, code)
    if obj.Active ~= nil then
        obj.Active = true
    elseif obj.CurrentStage ~= nil then
        obj.CurrentStage = obj.CurrentStage + 1
        obj.Active = true
    elseif obj.AcquiredCount ~= nil then
        obj.AcquiredCount = obj.AcquiredCount + 1
    else
        print(string.format("Warning: Object %s does not have a recognized type for activation", code))
    end
end


local function process_removed_barriers(barriers)
    for barrier, code in pairs(barriers) do
        code = code:match("^%s*(.-)%s*$")
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            activate_object(obj, code)
        end
    end
end

local function process_level_order(level_order)
    
    level_order = level_order:gsub(",$", "")
    local level_mapping = {
        ["JungleJapes"] = 1,
        ["AngryAztec"] = 2,
        ["FranticFactory"] = 3,
        ["GloomyGalleon"] = 4,
        ["FungiForest"] = 5,
        ["CrystalCaves"] = 6,
        ["CreepyCastle"] = 7,
    }
    
    -- Split the string by commas and process each level
    LEVEL_POSITIONS = {}
    local level_number = 1
    
    for level_name in string.gmatch(level_order, "([^,]+)") do
        -- Trim whitespace
        level_name = level_name:match("^%s*(.-)%s*$")
        
        -- Skip Hideout Helm as it's always static at level8
        if level_name == "HideoutHelm" then
            goto continue
        end
        
        -- Check if this is a valid level name
        local tracker_stage = level_mapping[level_name]
        if tracker_stage then
            -- Store which level ID (1-7) should be set to this tracker_stage
            LEVEL_POSITIONS[level_number] = tracker_stage
            level_number = level_number + 1
        end
        
        ::continue::
    end

    -- After setting up LEVEL_POSITIONS, call update_level_display to show the accessible levels
    update_level_display()
end

function update_level_display()
    if next(LEVEL_POSITIONS) == nil then
        return
    end
    
    for i = 1, 7 do
        local obj = Tracker:FindObjectForCode("level" .. i)
        if obj then
            local current_stage = obj.CurrentStage
            
            local level_id = LEVEL_POSITIONS[i]
            if level_id then
                for level_name, id in pairs({
                    ["JungleJapes"] = 1,
                    ["AngryAztec"] = 2,
                    ["FranticFactory"] = 3,
                    ["GloomyGalleon"] = 4,
                    ["FungiForest"] = 5,
                    ["CrystalCaves"] = 6,
                    ["CreepyCastle"] = 7
                }) do
                    if id == level_id and VISITED_LOBBIES[level_name] then
                        obj.CurrentStage = level_id
                        break
                    end
                end
                if obj.CurrentStage == 0 and current_stage > 0 then
                    obj.CurrentStage = current_stage
                end
            else
                if current_stage > 0 then
                    obj.CurrentStage = current_stage
                end
            end
        end
    end
    save_visited_lobbies()
end

function save_visited_lobbies()
    if not SLOT_DATA or not PLAYER_ID or PLAYER_ID < 0 then
        return
    end
    
    local slot_key = PLAYER_ID .. "_" .. (TEAM_NUMBER or 0)
    
    if not SAVED_LOBBIES_BY_SLOT[slot_key] then
        SAVED_LOBBIES_BY_SLOT[slot_key] = {
            level_order = SLOT_DATA['LevelOrder'],
            lobbies = {}
        }
    end
    
    SAVED_LOBBIES_BY_SLOT[slot_key].lobbies = {}
    
    for lobby_name, visited in pairs(VISITED_LOBBIES) do
        if visited then
            SAVED_LOBBIES_BY_SLOT[slot_key].lobbies[lobby_name] = true
        end
    end
end

function load_visited_lobbies()
    if not SLOT_DATA or not PLAYER_ID or PLAYER_ID < 0 then
        return
    end
    
    local slot_key = PLAYER_ID .. "_" .. (TEAM_NUMBER or 0)
    
    if SAVED_LOBBIES_BY_SLOT[slot_key] then
        if SLOT_DATA['LevelOrder'] and SAVED_LOBBIES_BY_SLOT[slot_key].level_order 
           and SLOT_DATA['LevelOrder'] ~= SAVED_LOBBIES_BY_SLOT[slot_key].level_order then
            return false
        end
        
        for lobby_name, visited in pairs(SAVED_LOBBIES_BY_SLOT[slot_key].lobbies or {}) do
            if visited then
                VISITED_LOBBIES[lobby_name] = true
            end
        end
        
        if next(LEVEL_POSITIONS) ~= nil then
            update_level_display()
        end
        
        return true
    end
    
    return false
end

-- ===== SLOT DATA PROCESSING =====
function processVersionGatedFeatures(slot_data)
    local version = slot_data['Version'] or "0.0.0"
    local isNewVersion = isVersion110OrHigher(version)
    
    -- Dropsanity (version >= 1.1.0 only)
    if slot_data['Dropsanity'] and isNewVersion then
        local obj = Tracker:FindObjectForCode("dropsanity")
        obj.Active = slot_data['Dropsanity']
    end
    
    -- BouldersInPool (version >= 1.1.0 only)
    if slot_data['BouldersInPool'] and isNewVersion then
        local obj = Tracker:FindObjectForCode("bouldersanity")
        obj.Active = slot_data['BouldersInPool']
    end
    
    -- HardShooting (version < 1.1.0 only)
    if slot_data['HardShooting'] and not isNewVersion then
        local obj = Tracker:FindObjectForCode("hard_shooting")
        obj.Active = slot_data['HardShooting']
    end

    if slot_data['Shopkeepers'] then
        local obj = Tracker:FindObjectForCode("shopowners")
        obj.Active = slot_data['Shopkeepers']
    end
    
    -- Handle GlitchesSelected and TricksSelected
    if slot_data['GlitchesSelected'] then
        for glitch in string.gmatch(slot_data['GlitchesSelected'], "[^,%s]+") do
            -- Skip advanced_platforming in versions >= 1.1.0 since it moved to TricksSelected
            if isNewVersion and glitch == "advanced_platforming" then
                goto continue
            end
            
            -- Handle advanced_platforming name change in versions >= 1.1.0
            local tracker_code = glitch
            if not isNewVersion and glitch == "monkey_maneuvers" then
                tracker_code = "advanced_platforming"
            elseif isNewVersion and glitch == "advanced_platforming" then
                tracker_code = "monkey_maneuvers"
            end
            
            local obj = Tracker:FindObjectForCode(tracker_code)
            if obj then
                obj.Active = true
            end
            
            ::continue::
        end
    end
    
    -- TricksSelected (version >= 1.1.0 only)
    if slot_data["TricksSelected"] and isNewVersion then
        for tricks in string.gmatch(slot_data['TricksSelected'], "[^,%s]+") do
            -- Handle monkey_maneuvers name change - map to advanced_platforming for tracker
            local tracker_code = tricks
            if tricks == "monkey_maneuvers" then
                tracker_code = "advanced_platforming"
            end
            
            local obj = Tracker:FindObjectForCode(tracker_code)
            if obj then
                obj.Active = true
            end
        end
    end
end

function onClear(slot_data)
    -- print(dump_table(slot_data))
    SLOT_DATA = slot_data
    CUR_INDEX = -1

    -- Set up version-appropriate item mapping before processing items
    if slot_data and slot_data['Version'] then
        setupItemMappingForVersion(slot_data['Version'])
    else
        setupItemMappingForVersion(nil) -- Use default mappings
    end

    -- reset locations
    for _, v in pairs(LOCATION_MAPPING) do
        if v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    if obj.ChestCount ~= nil then
                        obj.AvailableChestCount = obj.ChestCount
                    else
                        print(string.format("Warning: Object %s does not have a ChestCount property", v[1]))
                    end
                else
                    obj.Active = false
                end
            end
        end
    end

    -- reset items
    for _, v in pairs(CURRENT_ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end

    -- Always clear visited lobbies when connecting to a new slot
    VISITED_LOBBIES = {} 

    if slot_data == nil then
        print("welp")
        return
    end

    PLAYER_ID = Archipelago.PlayerNumber or -1
    TEAM_NUMBER = Archipelago.TeamNumber or 0

    -- Handle RemovedBarriers
    if type(slot_data['RemovedBarriers']) == "string" then
        local barriers = {}
        for barrier in string.gmatch(tostring(slot_data['RemovedBarriers']), "[^,]+") do
            barriers[barrier] = barrier
        end
        slot_data['RemovedBarriers'] = barriers
    end

    if type(slot_data['RemovedBarriers']) == "table" then
        process_removed_barriers(slot_data['RemovedBarriers'])
    else
        print("Error: RemovedBarriers is not a table. Found type: " .. type(slot_data['RemovedBarriers']))
    end

    if slot_data['GalleonWater'] then
        local obj = Tracker:FindObjectForCode("water")
        local stage = slot_data['GalleonWater']
        if stage == "raised" then
            obj.CurrentStage = 1
        elseif stage == "lowered" then
            obj.CurrentStage = 0
        end
    end

    if slot_data['ForestTime'] then
        local obj = Tracker:FindObjectForCode("time")
        local stage = slot_data['ForestTime']
        if stage == "day" then
            obj.CurrentStage = 0
        elseif stage == "night" then
            obj.CurrentStage = 1
        elseif stage == "dusk" then
            obj.CurrentStage = 2
        end
    end

    if slot_data['MedalCBRequirement'] then
        local obj = Tracker:FindObjectForCode("medalamount")
        obj.AcquiredCount = (slot_data['MedalCBRequirement'])
    end

    if slot_data['StartingKongs'] then
        for kong in string.gmatch(slot_data['StartingKongs'], "[^,%s]+") do
            local obj = Tracker:FindObjectForCode(kong)
            if obj then
                obj.Active = true
            end
        end
    end

    if slot_data['FairyRequirement'] then
        local obj = Tracker:FindObjectForCode("bfiReq")
        obj.AcquiredCount = (slot_data['FairyRequirement'])
    end

    if slot_data['JetpacReq'] then
        local obj = Tracker:FindObjectForCode("JetpacReq")
        obj.AcquiredCount = (slot_data["JetpacReq"])
    end

    if slot_data['SwitchSanity'] then
        SWITCHSANITY = slot_data['SwitchSanity']
        -- print("Received SwitchSanity data:")
        -- print(dump_table(SWITCHSANITY))
    else
        SWITCHSANITY = nil
    end

    if slot_data['EnemyData'] then
        ENEMY_DATA = slot_data['EnemyData']
    else
        ENEMY_DATA = nil
    end

    if slot_data['BLockerValues'] then
        BLOCKER_VALUES = slot_data['BLockerValues']
        -- print("Received BLockerValues:", BLOCKER_VALUES)
        
        -- Update blocker tracker items with the actual requirements
        updateBLockerTrackerItems()
    else
        BLOCKER_VALUES = nil
        -- Clear blocker tracker items when no BLockerValues
        clearBLockerTrackerItems()
    end

    -- Process version-gated features
    processVersionGatedFeatures(slot_data)

    if slot_data['Junk'] then
        JUNK_LOCATIONS = slot_data['Junk']
    else
        JUNK_LOCATIONS = nil
    end

    if slot_data['BossBananas'] then
        local banana_values = {}
        for value in string.gmatch(slot_data['BossBananas'], "([^,]+)") do
            table.insert(banana_values, tonumber(value:match("^%s*(.-)%s*$")))
        end
        
        -- Set banana requirements for portals 1-7
        for i = 1, math.min(7, #banana_values) do
            if banana_values[i] then
                local obj = Tracker:FindObjectForCode("tnsportal" .. i)
                if obj then 
                    obj.AcquiredCount = banana_values[i] 
                end
            end
        end
    end

    if slot_data['BossMaps'] then
        local boss_maps = {}
        for map in string.gmatch(slot_data['BossMaps'], "([^,]+)") do
            table.insert(boss_maps, map:match("^%s*(.-)%s*$"))
        end
        
        -- Map boss name to stage number
        local boss_map_stages = {
            ["JapesBoss"] = 1,
            ["AztecBoss"] = 2,
            ["FactoryBoss"] = 3,
            ["GalleonBoss"] = 4,
            ["FungiBoss"] = 5,
            ["CavesBoss"] = 6,
            ["CastleBoss"] = 7,
            ["KroolDonkeyPhase"] = 8,
            ["KroolDiddyPhase"] = 9,
            ["KroolLankyPhase"] = 10,
            ["KroolTinyPhase"] = 11,
            ["KroolChunkyPhase"] = 12
        }
        for i = 1, math.min(7, #boss_maps) do
            local boss_map = boss_maps[i]
            local stage = boss_map_stages[boss_map]
            if stage then
                local obj = Tracker:FindObjectForCode("tns" .. i)
                if obj then
                    obj.CurrentStage = stage
                end
            end
        end
    end

    if slot_data['BossKongs'] then
        local boss_kongs = {}
        for kong in string.gmatch(slot_data['BossKongs'], "([^,]+)") do
            table.insert(boss_kongs, kong:match("^%s*(.-)%s*$"))
        end
        
        -- Map kong name to stage number
        local kong_stages = {
            ["donkey"] = 1,
            ["diddy"] = 2,
            ["lanky"] = 3,
            ["tiny"] = 4,
            ["chunky"] = 5
        }
        
        -- Set the stages for the bosskong objects
        for i = 1, math.min(7, #boss_kongs) do
            local kong = boss_kongs[i]
            local stage = kong_stages[kong]
            if stage then
                local obj = Tracker:FindObjectForCode("bosskong" .. i)
                if obj then
                    obj.CurrentStage = stage
                end
            end
        end
    end
    
    -- Process HelmOrder slot data
    if slot_data['HelmOrder'] then
        -- Map of numeric values to Kong names (0=DK, 1=Chunky, 2=Tiny, 3=Lanky, 4=Diddy)
        local kongMap = {
            [0] = "donkey",
            [1] = "chunky",
            [2] = "tiny", 
            [3] = "lanky",
            [4] = "diddy"
        }
        
        local kongStageMap = {
            donkey = 1,
            chunky = 5,
            tiny = 4,
            lanky = 3, 
            diddy = 2
        }
        
        local helmSequence = {}
        for value in string.gmatch(slot_data['HelmOrder'], "%d+") do
            table.insert(helmSequence, tonumber(value))
        end
        
        for i, kongValue in ipairs(helmSequence) do
            if i > 5 then break end
            
            local helmObject = Tracker:FindObjectForCode("bom" .. i)
            if helmObject then
                local kong = kongMap[kongValue]
                if kong and kongStageMap[kong] then
                    helmObject.CurrentStage = kongStageMap[kong]
                    helmObject.Active = true
                end
            end
        end
        
        -- Mark remaining helm stages as inactive if the sequence is shorter than 5
        for i = #helmSequence + 1, 5 do
            local helmObject = Tracker:FindObjectForCode("bom" .. i)
            if helmObject then
                helmObject.Active = false
            end
        end
    end

    if slot_data['LankyFreeingKong'] ~= nil then
        local kongMap = {
            [0] = "donkey",
            [1] = "diddy",
            [2] = "lanky",
            [3] = "tiny",
            [4] = "chunky"
        }
        
        local kongValue = tonumber(slot_data['LankyFreeingKong'])
        if kongValue ~= nil and kongMap[kongValue] then
            LANKY_FREEING_KONG = kongMap[kongValue]     
        end
    end

    if slot_data['MermaidPearls'] then
        local obj = Tracker:FindObjectForCode("mermaid")
        obj.AcquiredCount = (slot_data['MermaidPearls'])
    end

    if slot_data["HintsInPool"] then
        local obj = Tracker:FindObjectForCode("hintsinpool")
        obj.Active = (slot_data['HintsInPool'])
    end

    if slot_data['OpenLobbies'] then
        local obj = Tracker:FindObjectForCode("openlobbies")
        obj.Active = (slot_data['OpenLobbies'])
    end

    if slot_data['LevelOrder'] then
        process_level_order(slot_data['LevelOrder'])
    end

    load_visited_lobbies()

    if PLAYER_ID > -1 then
    
        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({HINTS_ID})

        map_id = "DK64Rando_"..TEAM_NUMBER.."_"..PLAYER_ID.."_map"
        Archipelago:SetNotify({map_id})
        Archipelago:Get({map_id})
    end
end

-- ===== ARCHIPELAGO EVENT HANDLERS =====

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    CUR_INDEX = index;
    local v = CURRENT_ITEM_MAPPING[item_id]
    if not v or not v[1] then
        print(string.format("Could not find item mapping for id %s", tostring(item_id)))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
            if v[1] == "k1" or v[1] == "k2" or v[1] == "k4" or v[1] == "k5" or v[1] == "dive" then
                update_level_display()
            end
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    else
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
end

function onLocation(location_id, location_name)
    local loc_list = LOCATION_MAPPING[location_id]
    
    -- Handle case where loc_list might be a string instead of a table
    if type(loc_list) == "string" then
        loc_list = {loc_list}
    elseif type(loc_list) ~= "table" then
        return
    end

    for i, loc in ipairs(loc_list) do
        if not loc then
            return
        end
        print(loc)
        local obj = Tracker:FindObjectForCode(loc)
        if obj then
            if loc:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        end
    end
end

function onNotify(key, value, old_value)

    if value ~= old_value and key == HINTS_ID then
        for _, hint in ipairs(value) do
            if not hint.found and hint.finding_player == Archipelago.PlayerNumber then
                updateHints(hint.location)
            end
        end
    end
end

function onNotifyLaunch(key, value)
    Tracker.BulkUpdate = false
    if key == HINTS_ID then
        for _, hint in ipairs(value) do
            if not hint.found and hint.finding_player == Archipelago.PlayerNumber then
                updateHints(hint.location)
            end
        end
    end
end

function updateHints(locationID)
    local item_codes = HINTS_MAPPING[locationID]

    for _, item_code in ipairs(item_codes) do
        local obj = Tracker:FindObjectForCode(item_code)
        if obj then
            obj.Active = true
        end
    end
end

function onMapChange(id, value, old)
    -- print("got  " .. id .. " = " .. tostring(value) .. " (was " .. tostring(old) .. ")")
    -- print(dump_table(MAP_MAPPING[tostring(value)]))
    -- if has("automap_on") then
    local map_id = tostring(value)
    tabs = MAP_MAPPING[map_id]
    
    local updated = false
    
    if map_id == "169" and not VISITED_LOBBIES["JungleJapes"] then -- Japes Lobby
        VISITED_LOBBIES["JungleJapes"] = true
        updated = true
    elseif map_id == "173" and not VISITED_LOBBIES["AngryAztec"] then -- Aztec Lobby
        VISITED_LOBBIES["AngryAztec"] = true
        updated = true
    elseif map_id == "175" and not VISITED_LOBBIES["FranticFactory"] then -- Factory Lobby
        VISITED_LOBBIES["FranticFactory"] = true
        updated = true
    elseif map_id == "174" and not VISITED_LOBBIES["GloomyGalleon"] then -- Galleon Lobby
        VISITED_LOBBIES["GloomyGalleon"] = true
        updated = true
    elseif map_id == "178" and not VISITED_LOBBIES["FungiForest"] then -- Forest Lobby
        VISITED_LOBBIES["FungiForest"] = true
        updated = true
    elseif map_id == "194" and not VISITED_LOBBIES["CrystalCaves"] then -- Caves Lobby
        VISITED_LOBBIES["CrystalCaves"] = true
        updated = true
    elseif map_id == "193" and not VISITED_LOBBIES["CreepyCastle"] then -- Castle Lobby
        VISITED_LOBBIES["CreepyCastle"] = true
        updated = true
    end
    
    -- If we've discovered a new lobby, update the level display
    if updated then
        update_level_display()
    end
    
    for i, tab in ipairs(tabs) do
        Tracker:UiHint("ActivateTab", tab)
    end
end

-- ===== HANDLER REGISTRATION =====
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
Archipelago:AddSetReplyHandler("map_id", onMapChange)
Archipelago:AddRetrievedHandler("map_id", onMapChange)