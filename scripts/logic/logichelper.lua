-- Reworked Level Entry function to account for lobbies
function canEnterLevel(levels, ignoreBlocker)
    for _, level in ipairs(levels) do
        local levelCode = level[1]
        local blockerCode = level[2]
        local keys = level[3]

        -- Check if the level is accessible
        if has(levelCode) then
            -- Skip blocker check if ignoreBlocker is true
            if ignoreBlocker or canEnterWithBlocker(levelCode, blockerCode) then
                -- Check keys if they are required
                if not keys then
                    return true
                elseif type(keys) == "table" then
                    local allKeysPresent = true
                    for _, key in ipairs(keys) do
                        if not has(key) then
                            allKeysPresent = false
                            break
                        end
                    end
                    if allKeysPresent then
                        return true
                    end
                else
                    if has(keys) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Japes
function canEnterJapesLobby()
    return canEnterLevel({
        {"l1_japes", "blocker1"},
        {"l2_japes", "blocker2", "k1"},
        {"l3_japes", "blocker3", "k2"},
        {"l4_japes", "blocker4", {"k2", "dive"}},
        {"l5_japes", "blocker5", "k4"},
        {"l6_japes", "blocker6", "k5"},
        {"l7_japes", "blocker7", "k5"}
    }, true)
end

function canEnterJapes()
    return canEnterLevel({
        {"l1_japes", "blocker1"},
        {"l2_japes", "blocker2", "k1"},
        {"l3_japes", "blocker3", "k2"},
        {"l4_japes", "blocker4", {"k2", "dive"}},
        {"l5_japes", "blocker5", "k4"},
        {"l6_japes", "blocker6", "k5"},
        {"l7_japes", "blocker7", "k5"}
    }, false)
end

-- Aztec
function canEnterAztecLobby()
    return canEnterLevel({
        {"l1_aztec", "blocker1"},
        {"l2_aztec", "blocker2", "k1"},
        {"l3_aztec", "blocker3", "k2"},
        {"l4_aztec", "blocker4", {"k2", "dive"}},
        {"l5_aztec", "blocker5", "k4"},
        {"l6_aztec", "blocker6", "k5"},
        {"l7_aztec", "blocker7", "k5"}
    }, true)
end

function canEnterAztec()
    return canEnterLevel({
        {"l1_aztec", "blocker1"},
        {"l2_aztec", "blocker2", "k1"},
        {"l3_aztec", "blocker3", "k2"},
        {"l4_aztec", "blocker4", {"k2", "dive"}},
        {"l5_aztec", "blocker5", "k4"},
        {"l6_aztec", "blocker6", "k5"},
        {"l7_aztec", "blocker7", "k5"}
    }, false)
end

-- Factory
function canEnterFactoryLobby()
    return canEnterLevel({
        {"l1_factory", "blocker1"},
        {"l2_factory", "blocker2", "k1"},
        {"l3_factory", "blocker3", "k2"},
        {"l4_factory", "blocker4", {"k2", "dive"}},
        {"l5_factory", "blocker5", "k4"},
        {"l6_factory", "blocker6", "k5"},
        {"l7_factory", "blocker7", "k5"}
    }, true)
end

function canEnterFactory()
    return canEnterLevel({
        {"l1_factory", "blocker1"},
        {"l2_factory", "blocker2", "k1"},
        {"l3_factory", "blocker3", "k2"},
        {"l4_factory", "blocker4", {"k2", "dive"}},
        {"l5_factory", "blocker5", "k4"},
        {"l6_factory", "blocker6", "k5"},
        {"l7_factory", "blocker7", "k5"}
    }, false)
end

-- Galleon
function canEnterGalleonLobby()
    return canEnterLevel({
        {"l1_galleon", "blocker1"},
        {"l2_galleon", "blocker2", "k1"},
        {"l3_galleon", "blocker3", "k2"},
        {"l4_galleon", "blocker4", {"k2", "dive"}},
        {"l5_galleon", "blocker5", "k4"},
        {"l6_galleon", "blocker6", "k5"},
        {"l7_galleon", "blocker7", "k5"}
    }, true)
end

function canEnterGalleon()
    return canEnterLevel({
        {"l1_galleon", "blocker1"},
        {"l2_galleon", "blocker2", "k1"},
        {"l3_galleon", "blocker3", "k2"},
        {"l4_galleon", "blocker4", {"k2", "dive"}},
        {"l5_galleon", "blocker5", "k4"},
        {"l6_galleon", "blocker6", "k5"},
        {"l7_galleon", "blocker7", "k5"}
    }, false)
end

-- Forest
function canEnterForestLobby()
    return canEnterLevel({
        {"l1_forest", "blocker1"},
        {"l2_forest", "blocker2", "k1"},
        {"l3_forest", "blocker3", "k2"},
        {"l4_forest", "blocker4", {"k2", "dive"}},
        {"l5_forest", "blocker5", "k4"},
        {"l6_forest", "blocker6", "k5"},
        {"l7_forest", "blocker7", "k5"}
    }, true)
end

function canEnterForest()
    return canEnterLevel({
        {"l1_forest", "blocker1"},
        {"l2_forest", "blocker2", "k1"},
        {"l3_forest", "blocker3", "k2"},
        {"l4_forest", "blocker4", {"k2", "dive"}},
        {"l5_forest", "blocker5", "k4"},
        {"l6_forest", "blocker6", "k5"},
        {"l7_forest", "blocker7", "k5"}
    }, false)
end

-- Caves
function canEnterCavesLobby()
    return canEnterLevel({
        {"l1_caves", "blocker1"},
        {"l2_caves", "blocker2", "k1"},
        {"l3_caves", "blocker3", "k2"},
        {"l4_caves", "blocker4", {"k2", "dive"}},
        {"l5_caves", "blocker5", "k4"},
        {"l6_caves", "blocker6", "k5"},
        {"l7_caves", "blocker7", "k5"}
    }, true)
end

function canEnterCaves()
    return canEnterLevel({
        {"l1_caves", "blocker1"},
        {"l2_caves", "blocker2", "k1"},
        {"l3_caves", "blocker3", "k2"},
        {"l4_caves", "blocker4", {"k2", "dive"}},
        {"l5_caves", "blocker5", "k4"},
        {"l6_caves", "blocker6", "k5"},
        {"l7_caves", "blocker7", "k5"}
    }, false)
end

-- Castle
function canEnterCastleLobby()
    return canEnterLevel({
        {"l1_castle", "blocker1"},
        {"l2_castle", "blocker2", "k1"},
        {"l3_castle", "blocker3", "k2"},
        {"l4_castle", "blocker4", {"k2", "dive"}},
        {"l5_castle", "blocker5", "k4"},
        {"l6_castle", "blocker6", "k5"},
        {"l7_castle", "blocker7", "k5"}
    }, true)
end

function canEnterCastle()
    return canEnterLevel({
        {"l1_castle", "blocker1"},
        {"l2_castle", "blocker2", "k1"},
        {"l3_castle", "blocker3", "k2"},
        {"l4_castle", "blocker4", {"k2", "dive"}},
        {"l5_castle", "blocker5", "k4"},
        {"l6_castle", "blocker6", "k5"},
        {"l7_castle", "blocker7", "k5"}
    }, false)
end

function canEnterHelmLobby()
    return canEnterLevel({
        {"level8", "blocker8", {"k6", "k7"}}
    }, true)
    and port()
end

function canEnterHelm()
    return canEnterLevel({
        {"level8", "blocker8", {"k6", "k7"}}
    }, false)
    and port() and gone() and has("vine")
end