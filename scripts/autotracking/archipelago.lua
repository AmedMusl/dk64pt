ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil

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
        else
            -- print(string.format("Warning: Could not find object for blocker %d", blocker))
        end
    end
end

local function process_removed_barriers(barriers)
    -- print("Processing RemovedBarriers...")
    -- print("Contents of RemovedBarriers:")
    -- print(dump_table(barriers)) -- Debugging: Print the entire table

    for barrier, code in pairs(barriers) do
        code = code:match("^%s*(.-)%s*$") -- Trim whitespace
        -- print(string.format("Processing barrier: %s with code: %s", barrier, code))
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            -- print(string.format("Found object for code: %s", code))
            activate_object(obj, code)
        else
            -- print(string.format("Could not find object for code: %s", code))
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
        -- print("RemovedBarriers is a string. Converting to table...")
        local barriers = {}
        for barrier in string.gmatch(tostring(slot_data['RemovedBarriers']), "[^,]+") do
            barriers[barrier] = barrier -- Map the barrier name to itself or a default code
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
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v or not v[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
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


Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)