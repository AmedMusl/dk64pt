-- Level Entry Logic

function bLocker1()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Japes")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker1")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker2()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Aztec")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker2")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker3()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Factory")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker3")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker4()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Galleon")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker4")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker5()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Forest")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker5")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker6()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Caves")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker6")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker7()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Castle")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker7")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function bLocker8()
    -- Check BLockerValues first if enabled
    if isBLockerEnabled() then
        return canEnterLevel("Helm")
    end
    
    -- Fallback to manual blocker settings
    local blockerCount = Tracker:ProviderCountForCode("blocker8")
    if blockerCount < 1 then
        return true
    else
        local gb_count = Tracker:ProviderCountForCode("gb")
        -- Add blueprint count since turning in blueprints gives golden bananas
        -- Only count blueprints for kongs you have
        local blueprint_total = 0
        local kong_blueprint_map = {
            {"donkey", "dkbp"},
            {"diddy", "diddybp"}, 
            {"lanky", "lankybp"},
            {"tiny", "tinybp"},
            {"chunky", "chunkybp"}
        }
        
        for _, kong_bp_pair in ipairs(kong_blueprint_map) do
            local kong_code = kong_bp_pair[1]
            local blueprint_code = kong_bp_pair[2]
            local kong_obj = Tracker:FindObjectForCode(kong_code)
            
            if kong_obj and kong_obj.Active then
                local blueprint_obj = Tracker:FindObjectForCode(blueprint_code)
                if blueprint_obj then
                    blueprint_total = blueprint_total + (blueprint_obj.AcquiredCount or 0)
                end
            end
        end
        return (gb_count + blueprint_total) >= blockerCount
    end
end

function canEnterJapesLobby()
    if has("l1_japes") then
        return true
    elseif has("l2_japes") then
        return has("k1") or has("openlobbies")
    elseif has("l3_japes") then
        return ((has("k2") or has("openlobbies")))
    elseif has("l4_japes") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_japes") then
        return has("k4") or moonkicks() or has("openlobbies")
    elseif has("l6_japes") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_japes") then
        return has("k5") or has("openlobbies")
    elseif has("l8_japes") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterJapes()
    if has("l1_japes") then
        return bLocker1()
    elseif has("l2_japes") then
        return (has("k1") or has("openlobbies")) and bLocker1()
    elseif has("l3_japes") then
        return (has("k2") or has("openlobbies")) and bLocker1()
    elseif has("l4_japes") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker1()
    elseif has("l5_japes") then
        return (has("k4") or moonkicks() or has("openlobbies")) and bLocker1()
    elseif has("l6_japes") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker1() then
            return AccessibilityLevel.Normal
        elseif key and bLocker1() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_japes") then
        return (has("k5") or has("openlobbies")) and bLocker1()
    elseif has("l8_japes") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker1()
    end
end

function canEnterAztecLobby()
    if has("l1_aztec") then
        return true
    elseif has("l2_aztec") then
        return has("k1") or has("openlobbies")
    elseif has("l3_aztec") then
        return ((has("k2") or has("openlobbies")))
    elseif has("l4_aztec") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_aztec") then
        return has("k4") or moonkicks() or has("openlobbies")
    elseif has("l6_aztec") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_aztec") then
        return has("k5") or has("openlobbies")
    elseif has("l8_aztec") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterAztec()
    if has("l1_aztec") then
        return bLocker2()
    elseif has("l2_aztec") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_aztec") then
        return (has("k2") or has("openlobbies")) and bLocker2()
    elseif has("l4_aztec") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker2()
    elseif has("l5_aztec") then
        return (has("k4") or moonkicks() or has("openlobbies")) and bLocker2()
    elseif has("l6_aztec") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker2() then
            return AccessibilityLevel.Normal
        elseif key and bLocker2() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_aztec") then
        return (has("k5") or has("openlobbies")) and bLocker2()
    elseif has("l8_aztec") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker2()
    end
end

function canEnterFactoryLobby()
    if has("l1_factory") then
        return true
    elseif has("l2_factory") then
        return has("k1") or has("openlobbies")
    elseif has("l3_factory") then
        return ((has("k2") or has("openlobbies")))
    elseif has("l4_factory") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_factory") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_factory") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_factory") then
        return has("k5") or has("openlobbies")
    elseif has("l8_factory") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterFactory()
    if has("l1_factory") then
        return bLocker3()
    elseif has("l2_factory") then
        return (has("k1") or has("openlobbies")) and bLocker3()
    elseif has("l3_factory") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_factory") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker3()
    elseif has("l5_factory") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker3()
    elseif has("l6_factory") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker3() then
            return AccessibilityLevel.Normal
        elseif key and bLocker3() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_factory") then
        return (has("k5") or has("openlobbies")) and bLocker3()
    elseif has("l8_factory") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker3()
    end
end

function canEnterGalleonLobby()
    if has("l1_galleon") then
        return true
    elseif has("l2_galleon") then
        return has("k1") or has("openlobbies")
    elseif has("l3_galleon") then
        return ((has("k2") or has("openlobbies")))
    elseif has("l4_galleon") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_galleon") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_galleon") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_galleon") then
        return has("k5") or has("openlobbies")
    elseif has("l8_galleon") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterGalleon()
    if has("l1_galleon") then
        return bLocker4()
    elseif has("l2_galleon") then
        return (has("k1") or has("openlobbies")) and bLocker4()
    elseif has("l3_galleon") then
        return (has("k2") or has("openlobbies")) and bLocker4()
    elseif has("l4_galleon") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_galleon") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker4()
    elseif has("l6_galleon") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker4() then
            return AccessibilityLevel.Normal
        elseif key and bLocker4() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_galleon") then
        return (has("k5") or has("openlobbies")) and bLocker4()
    elseif has("l8_galleon") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker4()
    end
end

function canEnterForestLobby()
    if has("l1_forest") then
        return true
    elseif has("l2_forest") then
        return has("k1") or has("openlobbies")
    elseif has("l3_forest") then
        return ((has("k2") or has("openlobbies")))
    elseif has("l4_forest") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_forest") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_forest") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_forest") then
        return has("k5") or has("openlobbies")
    elseif has("l8_forest") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterForest()
    if has("l1_forest") then
        return bLocker5()
    elseif has("l2_forest") then
        return (has("k1") or has("openlobbies")) and bLocker5()
    elseif has("l3_forest") then
        return ((has("k2") or has("openlobbies"))) and bLocker5()
    elseif has("l4_forest") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker5()
    elseif has("l5_forest") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_forest") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker5() then
            return AccessibilityLevel.Normal
        elseif key and bLocker5() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_forest") then
        return (has("k5") or has("openlobbies")) and bLocker5()
    elseif has("l8_forest") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker5()
    end
end

function canEnterCavesLobby()
    if has("l1_caves") then
        return true
    elseif has("l2_caves") then
        return has("k1") or has("openlobbies")
    elseif has("l3_caves") then
        return (has("k2") or has("openlobbies"))
    elseif has("l4_caves") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_caves") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_caves") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_caves") then
        return has("k5") or has("openlobbies")
    elseif has("l8_caves") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterCaves()
    if has("l1_caves") then
        return bLocker6()
    elseif has("l2_caves") then
        return (has("k1") or has("openlobbies")) and bLocker6()
    elseif has("l3_caves") then
        return (has("k2") or has("openlobbies")) and bLocker6()
    elseif has("l4_caves") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker6()
    elseif has("l5_caves") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker6()
    elseif has("l6_caves") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_caves") then
        return (has("k5") or has("openlobbies")) and bLocker6()
    elseif has("l8_caves") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker6()
    end
end

function canEnterCastleLobby()
    if has("l1_castle") then
        return true
    elseif has("l2_castle") then
        return has("k1") or has("openlobbies")
    elseif has("l3_castle") then
        return has("k2") or has("openlobbies")
    elseif has("l4_castle") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") 
    elseif has("l5_castle") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_castle") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_castle") then
        return has("k5") or has("openlobbies")
    elseif has("l8_castle") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterCastle()
    if has("l1_castle") then
        return bLocker7()
    elseif has("l2_castle") then
        return (has("k1") or has("openlobbies")) and bLocker7()
    elseif has("l3_castle") then
        return (has("k2") or has("openlobbies")) and bLocker7()
    elseif has("l4_castle") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker7()
    elseif has("l5_castle") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker7()
    elseif has("l6_castle") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker7() then
            return AccessibilityLevel.Normal
        elseif key and bLocker7() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_castle") then
        return (has("k5") or has("openlobbies")) and bLocker7()
    elseif has("l8_castle") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and bLocker7()
    end
end

function canEnterHelmLobby()
    if has("l1_helm") then
        return true
    elseif has("l2_helm") then
        return has("k1") or has("openlobbies")
    elseif has("l3_helm") then
        return has("k2") or has("openlobbies")
    elseif has("l4_helm") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive")
    elseif has("l5_helm") then
        return has("k4") or has("openlobbies") or moonkicks()
    elseif has("l6_helm") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move then
            return AccessibilityLevel.Normal
        elseif key and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_helm") then
        return has("k5") or has("openlobbies")
    elseif has("l8_helm") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
    end
end

function canEnterHelm()
    if has("l1_helm") then
        return canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l2_helm") then
        return (has("k1") or has("openlobbies")) and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l3_helm") then
        return (has("k2") or has("openlobbies")) and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l4_helm") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l5_helm") then
        return (has("k4") or has("openlobbies") or moonkicks()) and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l6_helm") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8() then
            return AccessibilityLevel.Normal
        elseif key and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_helm") then
        return (has("k5") or has("openlobbies")) and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    elseif has("l8_helm") then
        return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport() and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
    end
end