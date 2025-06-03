-- Reworked Level Entry function to account for lobbies
-- Helper function to check if a function result indicates accessibility
function isAccessible(result)
    return result == true or result == AccessibilityLevel.Normal or result == AccessibilityLevel.SequenceBreak
end

-- Helper function to determine if a result is a sequence break
function isSequenceBreak(result)
    return result == AccessibilityLevel.SequenceBreak
end

function canEnterLevel(levels, ignoreBlocker)
    local finalResult = false
    
    for _, level in ipairs(levels) do
        local levelCode = level[1]
        local blockerCode = level[2]
        local keys = level[3]

        -- Check if the level is accessible
        if has(levelCode) then
            -- Skip blocker check if ignoreBlocker is true
            if ignoreBlocker or canEnterWithBlocker(levelCode, blockerCode) then
                -- Check keys if they are required (but ignore keys if openlobbies is enabled)
                if not keys then
                    return true
                elseif type(keys) == "table" then
                    local allKeysPresent = AccessibilityLevel.Normal
                    if has("openlobbies") then
                        -- When openlobbies is enabled, only check for ability requirements, not key requirements
                        for _, item in ipairs(keys) do
                            if not string.match(tostring(item), "^k%d+$") then
                                if type(item) == "function" then
                                    if not item() then
                                        allKeysPresent = AccessibilityLevel.None
                                        break
                                    end
                                elseif not has(item) then
                                    allKeysPresent = AccessibilityLevel.None
                                    break
                                end
                            end
                        end                    else
                        -- Normal logic - check all requirements including keys
                        for _, item in ipairs(keys) do
                            if type(item) == "function" then
                                local result = item()
                                if result == false or result == AccessibilityLevel.None then
                                    allKeysPresent = AccessibilityLevel.None
                                    break
                                end
                                -- If we have any sequence breaks, we'll mark this as a sequence break
                                if result == AccessibilityLevel.SequenceBreak and allKeysPresent ~= AccessibilityLevel.SequenceBreak then
                                    allKeysPresent = AccessibilityLevel.SequenceBreak
                                end
                            elseif not has(item) then
                                allKeysPresent = AccessibilityLevel.None
                                break
                            end
                        end
                    end
                    if allKeysPresent == true then
                        return true
                    elseif allKeysPresent == AccessibilityLevel.SequenceBreak then
                        return AccessibilityLevel.SequenceBreak
                    end
                else
                    -- Single requirement case (e.g. "k1")
                    if type(keys) == "function" then
                        -- If it's a function, just call it directly
                        local result = keys()
                        if result == true or result == AccessibilityLevel.Normal then
                            return true
                        elseif result == AccessibilityLevel.SequenceBreak then
                            return AccessibilityLevel.SequenceBreak
                        end
                    elseif has("openlobbies") and string.match(keys, "^k%d+$") then
                        -- Ignore key requirements with openlobbies
                        return true
                    elseif has(keys) then
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
        {"l4_japes", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_japes", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_japes", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_japes", "blocker7", "k5"}
    }, true)
end

function canEnterJapes()
    return canEnterLevel({
        {"l1_japes", "blocker1"},
        {"l2_japes", "blocker2", "k1"},
        {"l3_japes", "blocker3", "k2"},
        {"l4_japes", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_japes", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_japes", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            return false
        end},
        {"l7_japes", "blocker7", "k5"}
    }, false)
end

-- Aztec
function canEnterAztecLobby()
    return canEnterLevel({
        {"l1_aztec", "blocker1"},
        {"l2_aztec", "blocker2", "k1"},
        {"l3_aztec", "blocker3", "k2"},
        {"l4_aztec", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_aztec", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_aztec", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_aztec", "blocker7", "k5"}
    }, true)
end

function canEnterAztec()
    return canEnterLevel({
        {"l1_aztec", "blocker1"},
        {"l2_aztec", "blocker2", "k1"},
        {"l3_aztec", "blocker3", "k2"},
        {"l4_aztec", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_aztec", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_aztec", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_aztec", "blocker7", "k5"}
    }, false)
end

-- Factory
function canEnterFactoryLobby()
    return canEnterLevel({
        {"l1_factory", "blocker1"},
        {"l2_factory", "blocker2", "k1"},
        {"l3_factory", "blocker3", "k2"},
        {"l4_factory", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_factory", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_factory", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_factory", "blocker7", "k5"}
    }, true)
end

function canEnterFactory()
    return canEnterLevel({
        {"l1_factory", "blocker1"},
        {"l2_factory", "blocker2", "k1"},
        {"l3_factory", "blocker3", "k2"},
        {"l4_factory", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_factory", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_factory", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_factory", "blocker7", "k5"}
    }, false)
end

-- Galleon
function canEnterGalleonLobby()
    return canEnterLevel({
        {"l1_galleon", "blocker1"},
        {"l2_galleon", "blocker2", "k1"},
        {"l3_galleon", "blocker3", "k2"},
        {"l4_galleon", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_galleon", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_galleon", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_galleon", "blocker7", "k5"}
    }, true)
end

function canEnterGalleon()
    return canEnterLevel({
        {"l1_galleon", "blocker1"},
        {"l2_galleon", "blocker2", "k1"},
        {"l3_galleon", "blocker3", "k2"},
        {"l4_galleon", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_galleon", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_galleon", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_galleon", "blocker7", "k5"}
    }, false)
end

-- Forest
function canEnterForestLobby()
    return canEnterLevel({
        {"l1_forest", "blocker1"},
        {"l2_forest", "blocker2", "k1"},
        {"l3_forest", "blocker3", "k2"},
        {"l4_forest", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_forest", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_forest", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_forest", "blocker7", "k5"}
    }, true)
end

function canEnterForest()
    return canEnterLevel({
        {"l1_forest", "blocker1"},
        {"l2_forest", "blocker2", "k1"},
        {"l3_forest", "blocker3", "k2"},
        {"l4_forest", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_forest", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_forest", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_forest", "blocker7", "k5"}
    }, false)
end

-- Caves
function canEnterCavesLobby()
    return canEnterLevel({
        {"l1_caves", "blocker1"},
        {"l2_caves", "blocker2", "k1"},
        {"l3_caves", "blocker3", "k2"},
        {"l4_caves", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_caves", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_caves", "blocker6", "k5", function() 
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_caves", "blocker7", "k5"}
    }, true)
end

function canEnterCaves()
    return canEnterLevel({
        {"l1_caves", "blocker1"},
        {"l2_caves", "blocker2", "k1"},
        {"l3_caves", "blocker3", "k2"},
        {"l4_caves", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_caves", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_caves", "blocker6", function() 
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_caves", "blocker7", "k5"}
    }, false)
end

-- Castle
function canEnterCastleLobby()
    return canEnterLevel({
        {"l1_castle", "blocker1"},
        {"l2_castle", "blocker2", "k1"},
        {"l3_castle", "blocker3", "k2"},
        {"l4_castle", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_castle", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_castle", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_castle", "blocker7", "k5"}
    }, true)
end

function canEnterCastle()
    return canEnterLevel({
        {"l1_castle", "blocker1"},
        {"l2_castle", "blocker2", "k1"},
        {"l3_castle", "blocker3", "k2"},
        {"l4_castle", "blocker4", function() return (has("k2") and has("dive")) or phaseswim() end},
        {"l5_castle", "blocker5", function() return has("k4") or moonkicks() end},
        {"l6_castle", "blocker6", "k5", function()
            if has("k5") and (twirl() or has("donkey") or has("chunky")) or moonkicks() then
                return true
            end
            
            if has("k5") and (has("diddy") or has("lanky")) then
                local advancedplatform = avp()
                if advancedplatform == AccessibilityLevel.Normal then
                    return true
                elseif advancedplatform == AccessibilityLevel.SequenceBreak then
                    return advancedplatform
                end
            end
            
            return false
        end},
        {"l7_castle", "blocker7", "k5"}
    }, false)
end

function canEnterHelmLobby()
    return canEnterLevel({
        {"level8", "blocker8", {"k6", "k7"}}
    }, true)
    and canActivateIslesMonkeyport()
end

function canEnterHelm()
    return canEnterLevel({
        {"level8", "blocker8", {"k6", "k7"}}
    }, false)
    and canActivateIslesMonkeyport() and ((canActivateIslesHelmLobbyGone() and has("vine")) or moonkicks())
end