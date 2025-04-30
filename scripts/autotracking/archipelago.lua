ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/hints_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/map_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
-- Store the level positions globally so they can be accessed by the update function
LEVEL_POSITIONS = {}

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

local function process_blocker_values(blocker_values)
    for blocker, value in pairs(blocker_values) do
        local obj = Tracker:FindObjectForCode("blocker" .. blocker)
        if obj then
            obj.AcquiredCount = value
        end
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
    if type(level_order) ~= "string" then
        print("Error: LevelOrder is not a string. Found type: " .. type(level_order))
        return
    end
    
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
    
    print("Updating level display with current key status:")
    
    -- Get current key status
    local has_k1 = Tracker:FindObjectForCode("k1") and Tracker:FindObjectForCode("k1").Active
    local has_k2 = Tracker:FindObjectForCode("k2") and Tracker:FindObjectForCode("k2").Active
    local has_k4 = Tracker:FindObjectForCode("k4") and Tracker:FindObjectForCode("k4").Active
    local has_k5 = Tracker:FindObjectForCode("k5") and Tracker:FindObjectForCode("k5").Active
    local has_dive = Tracker:FindObjectForCode("dive") and Tracker:FindObjectForCode("dive").Active
    -- Update level1 (always visible)
    local obj = Tracker:FindObjectForCode("level1")
    if obj and LEVEL_POSITIONS[1] then
        local old_stage = obj.CurrentStage
        obj.CurrentStage = LEVEL_POSITIONS[1]
    end
    
    -- Update level2 (needs key1)
    obj = Tracker:FindObjectForCode("level2")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k1 and LEVEL_POSITIONS[2] then
            obj.CurrentStage = LEVEL_POSITIONS[2]
        else
            obj.CurrentStage = 0 -- Reset to unknown if we don't have the key
        end
    end
    
    -- Update level3 (needs key2)
    obj = Tracker:FindObjectForCode("level3")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k2 and LEVEL_POSITIONS[3] then
            obj.CurrentStage = LEVEL_POSITIONS[3]
        else
            obj.CurrentStage = 0
        end
    end
    
    -- Update level4 (needs key2 and dive)
    obj = Tracker:FindObjectForCode("level4")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k2 and has_dive and LEVEL_POSITIONS[4] then
            obj.CurrentStage = LEVEL_POSITIONS[4]
        else
            obj.CurrentStage = 0
        end
    end
    
    -- Update level5 (needs key4)
    obj = Tracker:FindObjectForCode("level5")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k4 and LEVEL_POSITIONS[5] then
            obj.CurrentStage = LEVEL_POSITIONS[5]
        else
            obj.CurrentStage = 0
        end
    end
    
    -- Update level6 and level7 (need key5)
    obj = Tracker:FindObjectForCode("level6")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k5 and LEVEL_POSITIONS[6] then
            obj.CurrentStage = LEVEL_POSITIONS[6]
        else
            obj.CurrentStage = 0
        end
    end
    
    obj = Tracker:FindObjectForCode("level7")
    if obj then
        local old_stage = obj.CurrentStage
        if has_k5 and LEVEL_POSITIONS[7] then
            obj.CurrentStage = LEVEL_POSITIONS[7]
        else
            obj.CurrentStage = 0
        end
    end
end

function onClear(slot_data)
    print(dump_table(slot_data))
    SLOT_DATA = slot_data
    CUR_INDEX = -1

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
    for _, v in pairs(ITEM_MAPPING) do
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

    if slot_data['BLockerValues'] then
        process_blocker_values(slot_data['BLockerValues'])
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
            else
                -- print(string.format("Warning: Could not find object for StartingKong %s", kong))
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

    if slot_data['MermaidPearls'] then
        local obj = Tracker:FindObjectForCode("mermaid")
        obj.AcquiredCount = (slot_data['MermaidPearls'])
    end

    if slot_data['LevelOrder'] then
        process_level_order(slot_data['LevelOrder'])
    end

    if PLAYER_ID > -1 then
    
        HINTS_ID = "_read_hints_"..TEAM_NUMBER.."_"..PLAYER_ID
        Archipelago:SetNotify({HINTS_ID})

        map_id = "DK64Rando_"..TEAM_NUMBER.."_"..PLAYER_ID.."_map"
        Archipelago:SetNotify({map_id})
        Archipelago:Get({map_id})
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v or not v[1] then
        print(string.format("Could not find item mapping for id %s", tostring(item_id)))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            local wasActive = obj.Active
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
    tabs = MAP_MAPPING[tostring(value)]
    for i, tab in ipairs(tabs) do
        Tracker:UiHint("ActivateTab", tab)
    end
end


Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
Archipelago:AddSetReplyHandler("map_id", onMapChange)
Archipelago:AddRetrievedHandler("map_id", onMapChange)