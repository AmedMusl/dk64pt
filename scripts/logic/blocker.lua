function isBLockerEnabled()
    return BLOCKER_VALUES ~= nil
end

function getBLockerRequirement(level_name)
    if BLOCKER_VALUES then
        -- Parse string format: "Japes: 9 Blueprint, Aztec: 3 Fairy..."
        local pattern = level_name .. ":%s*(%d+)%s+([^,]+)"
        local count, item_type = BLOCKER_VALUES:match(pattern)
        if count and item_type then
            return {
                item = item_type:match("^%s*(.-)%s*$"),
                count = tonumber(count)
            }
        end
    end
end

function getBLockerItemType(level_name)
    local requirement = getBLockerRequirement(level_name)
    if requirement and requirement["item"] then
        return requirement["item"]
    end
    return nil
end

function getBLockerCount(level_name)
    local requirement = getBLockerRequirement(level_name)
    if requirement and requirement["count"] then
        return requirement["count"]
    end
    return 0
end

function getBLockerItemCount(item_type)
    if item_type == "GoldenBanana" then
        local obj = Tracker:FindObjectForCode("gb")
        local gb_count = obj and obj.AcquiredCount or 0
        
        -- Add blueprint count since turning in blueprints gives golden bananas
        local blueprint_total = 0
        for _, blueprint_code in ipairs({"dkbp", "diddybp", "lankybp", "tinybp", "chunkybp"}) do
            local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
            if blueprint_obj then
                local bp_count = blueprint_obj.AcquiredCount or 0
                blueprint_total = blueprint_total + bp_count
                -- Debug output
            end
        end
        return gb_count + blueprint_total
    elseif item_type == "Crown" then
        local obj = Tracker:FindObjectForCode("crowns")
        return obj and obj.AcquiredCount or 0
    elseif item_type == "Blueprint" then
        -- Sum all individual blueprint types
        local total = 0
        for _, blueprint_code in ipairs({"dkbp", "diddybp", "lankybp", "tinybp", "chunkybp"}) do
            local obj = Tracker:FindObjectForCode(blueprint_code)
            if obj then
                total = total + (obj.AcquiredCount or 0)
            end
        end
        return total
    elseif item_type == "Pearl" then
        local obj = Tracker:FindObjectForCode("pearl")
        return obj and obj.AcquiredCount or 0
    elseif item_type == "Bean" then
        local obj = Tracker:FindObjectForCode("bean")
        return obj and (obj.Active and 1 or 0) or 0
    elseif item_type == "Fairy" then
        local obj = Tracker:FindObjectForCode("fairies")
        return obj and obj.AcquiredCount or 0
    elseif item_type == "RainbowCoin" then
        local obj = Tracker:FindObjectForCode("rainbow")
        return obj and obj.AcquiredCount or 0
    elseif item_type == "Medal" then
        local obj = Tracker:FindObjectForCode("medals")
        return obj and obj.AcquiredCount or 0
    elseif item_type == "CompanyCoin" then
        -- Sum Nintendo and Rareware coins (both are toggles)
        local nintendo_obj = Tracker:FindObjectForCode("nintendo")
        local rareware_obj = Tracker:FindObjectForCode("rareware")
        local nintendo_count = nintendo_obj and (nintendo_obj.Active and 1 or 0) or 0
        local rareware_count = rareware_obj and (rareware_obj.Active and 1 or 0) or 0
        return nintendo_count + rareware_count
    end
    return 0
end

function canEnterLevel(level_name)
    if not isBLockerEnabled() then
        return true -- No B-Locker restrictions if not enabled
    end
    
    local item_type = getBLockerItemType(level_name)
    local required_count = getBLockerCount(level_name)
    
    if not item_type or required_count == 0 then
        return true -- No requirements or invalid data
    end
    
    local current_count = getBLockerItemCount(item_type)
    return current_count >= required_count
end

-- Helper function to get readable requirement text (Has no use yet :( ))
function getBLockerRequirementText(level_name)
    local item_type = getBLockerItemType(level_name)
    local count = getBLockerCount(level_name)
    
    if not item_type or count == 0 then
        return "No requirements"
    end
    
    local item_name = item_type
    if item_type == "GoldenBanana" then
        item_name = "Golden Banana" .. (count > 1 and "s" or "")
    elseif item_type == "Crown" then
        item_name = "Crown" .. (count > 1 and "s" or "")
    elseif item_type == "Blueprint" then
        item_name = "Blueprint" .. (count > 1 and "s" or "")
    elseif item_type == "Pearl" then
        item_name = "Pearl" .. (count > 1 and "s" or "")
    elseif item_type == "Bean" then
        item_name = "Bean" .. (count > 1 and "s" or "")
    elseif item_type == "Fairy" then
        item_name = "Fairie" .. (count > 1 and "s" or "")
    elseif item_type == "RainbowCoin" then
        item_name = "Rainbow Coin" .. (count > 1 and "s" or "")
    elseif item_type == "Medal" then
        item_name = "Medal" .. (count > 1 and "s" or "")
    elseif item_type == "CompanyCoin" then
        item_name = "Company Coin" .. (count > 1 and "s" or "")
    end
    
    return count .. " " .. item_name
end
