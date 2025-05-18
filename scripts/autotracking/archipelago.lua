ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/hints_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/map_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil
-- Store the level positions globally so they can be accessed by the update function
LEVEL_POSITIONS = {}
-- Track which lobbies the player has visited
VISITED_LOBBIES = {}

local SAVEDATA_KEY = "dk64pt_visited_lobbies"
local CURRENT_SLOT_KEY = "dk64pt_current_slot"
local SAVEDATA_FILENAME = "dk64pt_savedata.txt"
local VISITED_LOBBIES_FILE = "dk64pt_visited_lobbies"

-- Use global variables for session persistence
-- Global table to store visited lobbies between sessions (works during tracker runtime)
SAVED_LOBBIES_BY_SLOT = SAVED_LOBBIES_BY_SLOT or {}

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
    
    -- For each level position (1-7), find where each level is in the level order
    for i = 1, 7 do
        local obj = Tracker:FindObjectForCode("level" .. i)
        if obj then
            -- Get current stage value to check if it's already set
            local current_stage = obj.CurrentStage
            
            -- Check which level is at this position in the order
            local level_id = LEVEL_POSITIONS[i]
            if level_id then
                -- Find which level name corresponds to this level_id
                for level_name, id in pairs({
                    ["JungleJapes"] = 1,
                    ["AngryAztec"] = 2,
                    ["FranticFactory"] = 3,
                    ["GloomyGalleon"] = 4,
                    ["FungiForest"] = 5,
                    ["CrystalCaves"] = 6,
                    ["CreepyCastle"] = 7
                }) do
                    -- If this is the level at position i and we've visited its lobby,
                    -- show that level's icon at the current position
                    if id == level_id and VISITED_LOBBIES[level_name] then
                        obj.CurrentStage = level_id
                        break
                    end
                end
                
                -- If we didn't find a visited lobby for this position but it was already marked,
                -- preserve the previous marking
                if obj.CurrentStage == 0 and current_stage > 0 then
                    obj.CurrentStage = current_stage
                end
            else
                -- No level_id for this position, but preserve existing marking if any
                if current_stage > 0 then
                    obj.CurrentStage = current_stage
                end
            end
        end
    end
    
    -- Save the visited lobbies data whenever it changes
    save_visited_lobbies()
end

-- Function to save visited lobbies to memory storage
function save_visited_lobbies()
    if not SLOT_DATA or not PLAYER_ID or PLAYER_ID < 0 then
        return
    end
    
    -- Create a unique key for this player's slot
    local slot_key = PLAYER_ID .. "_" .. (TEAM_NUMBER or 0)
    
    -- Initialize or update the storage for this slot key
    if not SAVED_LOBBIES_BY_SLOT[slot_key] then
        SAVED_LOBBIES_BY_SLOT[slot_key] = {
            level_order = SLOT_DATA['LevelOrder'],
            lobbies = {}
        }
    end
    
    -- Save the lobbies under this slot key
    SAVED_LOBBIES_BY_SLOT[slot_key].lobbies = {}
    
    for lobby_name, visited in pairs(VISITED_LOBBIES) do
        if visited then
            SAVED_LOBBIES_BY_SLOT[slot_key].lobbies[lobby_name] = true
        end
    end
end

-- Function to load visited lobbies from memory storage
function load_visited_lobbies()
    if not SLOT_DATA or not PLAYER_ID or PLAYER_ID < 0 then
        return
    end
    
    -- Create a unique key for this player's slot
    local slot_key = PLAYER_ID .. "_" .. (TEAM_NUMBER or 0)
    
    -- Check if we have saved data for this slot
    if SAVED_LOBBIES_BY_SLOT[slot_key] then
        -- Check if the level order matches between saved data and current data
        if SLOT_DATA['LevelOrder'] and SAVED_LOBBIES_BY_SLOT[slot_key].level_order 
           and SLOT_DATA['LevelOrder'] ~= SAVED_LOBBIES_BY_SLOT[slot_key].level_order then
            return false
        end
        
        -- Restore the visited lobbies
        for lobby_name, visited in pairs(SAVED_LOBBIES_BY_SLOT[slot_key].lobbies or {}) do
            if visited then
                VISITED_LOBBIES[lobby_name] = true
            end
        end
        
        -- Update the level display with the loaded data
        if next(LEVEL_POSITIONS) ~= nil then
            update_level_display()
        end
        
        return true
    end
    
    return false
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

    if slot_data['SwitchSanity'] then
        SWITCHSANITY = slot_data['SwitchSanity']
        -- print("Received SwitchSanity data:")
        -- print(dump_table(SWITCHSANITY))
    else
        SWITCHSANITY = {}
    end

    if slot_data['MermaidPearls'] then
        local obj = Tracker:FindObjectForCode("mermaid")
        obj.AcquiredCount = (slot_data['MermaidPearls'])
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


Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)
Archipelago:AddSetReplyHandler("map_id", onMapChange)
Archipelago:AddRetrievedHandler("map_id", onMapChange)