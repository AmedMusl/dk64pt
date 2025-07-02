-- Level Entry Logic

function bLocker1()
    local blockerCount = Tracker:ProviderCountForCode("blocker1")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker2()
    local blockerCount = Tracker:ProviderCountForCode("blocker2")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker3()
    local blockerCount = Tracker:ProviderCountForCode("blocker3")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker4()
    local blockerCount = Tracker:ProviderCountForCode("blocker4")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker5()
    local blockerCount = Tracker:ProviderCountForCode("blocker5")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker6()
    local blockerCount = Tracker:ProviderCountForCode("blocker6")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker7()
    local blockerCount = Tracker:ProviderCountForCode("blocker7")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
    end
end

function bLocker8()
    local blockerCount = Tracker:ProviderCountForCode("blocker8")
    if blockerCount < 1 then
        return true
    else
        return Tracker:ProviderCountForCode("gb") >= blockerCount
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
    end
end

function canEnterJapes()
    if has("l1_japes") then
        return bLocker1()
    elseif has("l2_japes") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_japes") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_japes") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_japes") then
        return (has("k4") or moonkicks() or has("openlobbies")) and bLocker5()
    elseif has("l6_japes") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_japes") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterAztec()
    if has("l1_aztec") then
        return bLocker1()
    elseif has("l2_aztec") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_aztec") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_aztec") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_aztec") then
        return (has("k4") or moonkicks() or has("openlobbies")) and bLocker5()
    elseif has("l6_aztec") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_aztec") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterFactory()
    if has("l1_factory") then
        return bLocker1()
    elseif has("l2_factory") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_factory") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_factory") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_factory") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_factory") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_factory") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterGalleon()
    if has("l1_galleon") then
        return bLocker1()
    elseif has("l2_galleon") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_galleon") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_galleon") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_galleon") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_galleon") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_galleon") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterForest()
    if has("l1_forest") then
        return bLocker1()
    elseif has("l2_forest") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_forest") then
        return ((has("k2") or has("openlobbies"))) and bLocker3()
    elseif has("l4_forest") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_forest") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_forest") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_forest") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterCaves()
    if has("l1_caves") then
        return bLocker1()
    elseif has("l2_caves") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_caves") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_caves") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_caves") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_caves") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_caves") then
        return (has("k5") or has("openlobbies")) and bLocker7()
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
    end
end

function canEnterCastle()
    if has("l1_castle") then
        return bLocker1()
    elseif has("l2_castle") then
        return (has("k1") or has("openlobbies")) and bLocker2()
    elseif has("l3_castle") then
        return (has("k2") or has("openlobbies")) and bLocker3()
    elseif has("l4_castle") then
        return (has("k2") or has("openlobbies") or phaseswim()) and has("dive") and bLocker4()
    elseif has("l5_castle") then
        return (has("k4") or has("openlobbies") or moonkicks()) and bLocker5()
    elseif has("l6_castle") then
        local key = has("k5") or has("openlobbies") or moonkicks()
        local move = twirl() or has("donkey") or has("chunky")
        if key and move and bLocker6() then
            return AccessibilityLevel.Normal
        elseif key and bLocker6() and (has("diddy") or has("lanky") or has("tiny")) then
            return avp()
        end
    elseif has("l7_castle") then
        return (has("k5") or has("openlobbies")) and bLocker7()
    end
end

function canEnterHelmLobby()
    return ((has("k6") and has("k7")) or has("openlobbies")) and canActivateIslesMonkeyport()
end

function canEnterHelm()
    return canEnterHelmLobby() and canActivateIslesHelmLobbyGone() and has("vine") and bLocker8()
end