-- dropsanity.lua
-- Handles enemy-specific logic based on EnemyData slot data

-- Enemy type constants for easier reference
local ENEMY_TYPES = {
    KLUMP = "Klump",
    KOSHA = "Kosha",
    KLAPTRAP_PURPLE = "KlaptrapPurple",
    KLAPTRAP_RED = "KlaptrapRed",
    KLOBBER = "Klobber",
    KABOOM = "Kaboom",
    ROBO_KREMLING = "RoboKremling",
    GUARD = "Guard"
}

-- Map constants for easier reference
local MAPS = {
    AZTEC_DIDDY_5D_TEMPLE = "AztecDiddy5DTemple",
    AZTEC_DONKEY_5D_TEMPLE = "AztecDonkey5DTemple",
    JAPES_MOUNTAIN = "JapesMountain",
    FRANTIC_FACTORY = "FranticFactory",
    HIDEOUT_HELM = "HideoutHelm",
    CASTLE_LOWER_CAVE = "CastleLowerCave",
    CRYSTAL_CAVES = "CrystalCaves",
    CAVES_TINY_CABIN = "CavesTinyCabin",
    CREEPY_CASTLE = "CreepyCastle",
    AZTEC_LLAMA_TEMPLE = "AztecLlamaTemple",
    FUNGI_FOREST = "FungiForest",
    CAVES_DIDDY_LOWER_CABIN = "CavesDiddyLowerCabin",
    JAPES_TINY_HIVE = "JapesTinyHive",
    GLOOMY_GALLEON = "GloomyGalleon",
    CAVES_DONKEY_IGLOO = "CavesDonkeyIgloo",
    FOREST_ANTHILL = "ForestAnthill",
    AZTEC_CHUNKY_5D_TEMPLE = "AztecChunky5DTemple",
    CAVES_LANKY_CABIN = "CavesLankyCabin",
    GALLEON_LIGHTHOUSE = "GalleonLighthouse",
    CASTLE_BALLROOM = "CastleBallroom",
    CAVES_DIDDY_UPPER_CABIN = "CavesDiddyUpperCabin",
    FOREST_THORNVINE_BARN = "ForestThornvineBarn",
    AZTEC_TINY_TEMPLE = "AztecTinyTemple",
    CREEPY_CASTLE_LOBBY = "CreepyCastleLobby",
    CAVES_TINY_IGLOO = "CavesTinyIgloo",
    FOREST_GIANT_MUSHROOM = "ForestGiantMushroom",
    CASTLE_MUSEUM = "CastleMuseum",
    CASTLE_DUNGEON = "CastleDungeon"
}

-- Function to get enemy data for a specific location
function getEnemyDataForLocation(location)
    if not ENEMY_DATA or not location then
        return nil
    end
    
    return ENEMY_DATA[location]
end

-- Function to get all locations with a specific enemy type
function getLocationsByEnemyType(enemy_type)
    if not ENEMY_DATA then
        return {}
    end
    
    local locations = {}
    for location, data in pairs(ENEMY_DATA) do
        if data.enemy == enemy_type then
            table.insert(locations, location)
        end
    end
    
    return locations
end

-- Function to get all locations in a specific map
function getLocationsByMap(map_name)
    if not ENEMY_DATA then
        return {}
    end
    
    local locations = {}
    for location, data in pairs(ENEMY_DATA) do
        if data.map == map_name then
            table.insert(locations, location)
        end
    end
    
    return locations
end

-- Main function to apply logic based on location/enemy
function applyEnemyLogic(location)
    local enemy_data = getEnemyDataForLocation(location)
    
    if not enemy_data then
        return heavyEnemy()
    end
    
    local enemy_type = enemy_data.enemy
    local map_name = enemy_data.map
    
    -- Apply enemy-specific logic
    if enemy_type == ENEMY_TYPES.KLUMP then
        return applyKlumpLogic()
    elseif enemy_type == ENEMY_TYPES.KOSHA then
        return applyKoshaLogic()
    elseif enemy_type == ENEMY_TYPES.KLAPTRAP_PURPLE then
        return applyKlaptrapPurpleLogic()
    elseif enemy_type == ENEMY_TYPES.KLAPTRAP_RED then
        return applyKlaptrapRedLogic()
    elseif enemy_type == ENEMY_TYPES.KLOBBER then
        return applyKlobberLogic()
    elseif enemy_type == ENEMY_TYPES.KABOOM then
        return applyKaboomLogic()
    elseif enemy_type == ENEMY_TYPES.ROBO_KREMLING then
        return applyRoboKremlingLogic()
    elseif enemy_type == ENEMY_TYPES.GUARD then
        return applyGuardLogic()
    else
        print("Unknown enemy type: " .. tostring(enemy_type))
        return false
    end
end

-- Enemy-specific logic functions
-- You can customize these functions to implement specific logic for each enemy type

function applyKlumpLogic()
    return heavyEnemy()
end

function applyKoshaLogic()
    return heavyEnemy()
end

function applyKlaptrapPurpleLogic()
    return has("oranges") or bongos() or guitar() or trombone() or sax() or triangle()
end

function applyKlaptrapRedLogic()
    return heavyEnemy() or canChangeTime()
end

function applyKlobberLogic()
    return heavyEnemy()
end

function applyKaboomLogic()
    return heavyEnemy()
end

function applyRoboKremlingLogic()
    return heavyEnemy() or punch()
end

function applyGuardLogic()
    return heavyEnemy() or canChangeTime()
end


-- Function to check if enemy logic can be applied (i.e., ENEMY_DATA is available)
function canApplyEnemyLogic()
    return ENEMY_DATA ~= nil and type(ENEMY_DATA) == "table"
end