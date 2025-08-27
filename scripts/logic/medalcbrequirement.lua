function isMedalCBRequirementLevelEnabled()
    return MEDALCBREQUIREMENTLEVEL ~= nil
end

function getMedalCBRequirement(level_name)
    if MEDALCBREQUIREMENTLEVEL and type(MEDALCBREQUIREMENTLEVEL) == "table" then
        if MEDALCBREQUIREMENTLEVEL[level_name] then
            return MEDALCBREQUIREMENTLEVEL[level_name]
        end
    end
    return nil
end

-- Level name mappings for the slot data
local LEVEL_NAMES = {
    ["japes"] = "JungleJapes",
    ["aztec"] = "AngryAztec", 
    ["factory"] = "FranticFactory",
    ["galleon"] = "GloomyGalleon",
    ["forest"] = "FungiForest",
    ["caves"] = "CrystalCaves",
    ["castle"] = "CreepyCastle"
}

function getMedalCBRequirementForLevel(level_key)
    if not isMedalCBRequirementLevelEnabled() then
        return nil
    end
    
    local level_name = LEVEL_NAMES[level_key]
    if level_name then
        return getMedalCBRequirement(level_name)
    end
    
    return nil
end

-- Helper functions for each level
function getJapesMedalCBRequirement()
    return getMedalCBRequirementForLevel("japes")
end

function getAztecMedalCBRequirement()
    return getMedalCBRequirementForLevel("aztec")
end

function getFactoryMedalCBRequirement()
    return getMedalCBRequirementForLevel("factory")
end

function getGalleonMedalCBRequirement()
    return getMedalCBRequirementForLevel("galleon")
end

function getForestMedalCBRequirement()
    return getMedalCBRequirementForLevel("forest")
end

function getCavesMedalCBRequirement()
    return getMedalCBRequirementForLevel("caves")
end

function getCastleMedalCBRequirement()
    return getMedalCBRequirementForLevel("castle")
end
