function isSwitchsanityEnabled()
    return SWITCHSANITY ~= nil
end

function getSwitchKong(switch_name)
    if SWITCHSANITY and SWITCHSANITY[switch_name] and SWITCHSANITY[switch_name]["kong"] then
        return SWITCHSANITY[switch_name]["kong"]
    end
    return nil
end

function getSwitchType(switch_name)
    if SWITCHSANITY and SWITCHSANITY[switch_name] and SWITCHSANITY[switch_name]["type"] then
        return SWITCHSANITY[switch_name]["type"]
    end
    return nil
end

function getSwitchLogic(switch_name)
    local result = {}
    result.isSwitchsanity = isSwitchsanityEnabled()
    result.kong = getSwitchKong(switch_name)
    result.type = getSwitchType(switch_name)
    
    if result.kong and result.type then
        if result.kong == "donkey" then
            result.hasKong = has("donkey")
            result.hasGun = coconut()
            result.hasInstrument = bongos()
            result.hasSlam = has("donkey") and has("slam")
            result.hasPadMove = blast()
            result.hasMiscAbility = grab()
        elseif result.kong == "diddy" then
            result.hasKong = has("diddy")
            result.hasGun = peanuts()
            result.hasInstrument = guitar()
            result.hasSlam = has("diddy") and has("slam")
            result.hasMiscAbility = charge()
        elseif result.kong == "lanky" then
            result.hasKong = has("lanky")
            result.hasGun = grape()
            result.hasInstrument = trombone()
            result.hasSlam = has("lanky") and has("slam")
            result.hasPadMove = balloon()
        elseif result.kong == "tiny" then
            result.hasKong = has("tiny")
            result.hasGun = feather()
            result.hasInstrument = sax()
            result.hasSlam = has("tiny") and has("slam")
            result.hasPadMove = port()
        elseif result.kong == "chunky" then
            result.hasKong = has("chunky")
            result.hasGun = pineapple()
            result.hasInstrument = triangle()
            result.hasSlam = has("chunky") and has("slam")
            result.hasPadMove = gone()
            result.hasMiscAbility = punch()
        end
    end
    
    return result
end

function canActivateSwitch(switch_name)
    local logic = getSwitchLogic(switch_name)
    if not logic.isSwitchsanity then
        return true
    end
    if not logic.kong or not logic.type then
        return true
    end
    if not logic.hasKong then
        return false
    end
    
    if logic.type == "GunSwitch" then
        return logic.hasGun
    elseif logic.type == "InstrumentPad" then
        return logic.hasInstrument
    elseif logic.type == "SlamSwitch" then
        return logic.hasSlam
    elseif logic.type == "PadMove" then
        return logic.hasPadMove
    elseif logic.type == "MiscActivator" then
        return logic.hasMiscAbility
    elseif logic.type == "GunInstrumentCombo" then
        return logic.hasGun and logic.hasInstrument
    elseif logic.type == "PushableButton" then
        return logic.hasMiscAbility
    end
    
    return false
end

function canActivateAztecGuitar()
    local logic = getSwitchLogic("AztecGuitar")
    
    if not logic.isSwitchsanity then
        return guitar()
    else
        return canActivateSwitch("AztecGuitar")
    end
end

function canActivateJapesFeather()
    local logic = getSwitchLogic("JapesFeather")
    
    if not logic.isSwitchsanity then
        return feather()
    else
        return canActivateSwitch("JapesFeather")
    end
end

function canActivateIslesSpawnRocketbarrel()
    local logic = getSwitchLogic("IslesSpawnRocketbarrel")
    
    if not logic.isSwitchsanity then
        return trombone()
    else
        return canActivateSwitch("IslesSpawnRocketbarrel")
    end
end

function canActivateAztecQuickSandSwitch()
    local logic = getSwitchLogic("AztecQuicksandSwitch")
    
    if not logic.isSwitchsanity then
        return has("donkey") and aztecSlam()
    else
        return canActivateSwitch("AztecQuicksandSwitch") and aztecSlam()
    end
end

function canActivateJapesRambi()
    local logic = getSwitchLogic("JapesRambi")
    
    if not logic.isSwitchsanity then
        return coconut()
    else
        return canActivateSwitch("JapesRambi")
    end
end

function canActivateFungiGreenFeather()
    local logic = getSwitchLogic("FungiGreenFeather")
    
    if not logic.isSwitchsanity then
        return feather()
    else
        return canActivateSwitch("FungiGreenFeather")
    end
end

function canActivateFungiGreenPineapple()
    local logic = getSwitchLogic("FungiGreenPineapple")
    
    if not logic.isSwitchsanity then
        return pineapple()
    else
        return canActivateSwitch("FungiGreenPineapple")
    end
end

function canActivateIslesMonkeyport()
    local logic = getSwitchLogic("IslesMonkeyport")
    
    if not logic.isSwitchsanity then
        return port()
    else
        return canActivateSwitch("IslesMonkeyport")
    end
end

function canActivateAztecLlamaGrape()
    local logic = getSwitchLogic("AztecLlamaGrape")
    
    if not logic.isSwitchsanity then
        return grape()
    else
        return canActivateSwitch("AztecLlamaGrape")
    end
end

function canActivateFungiYellow()
    local logic = getSwitchLogic("FungiYellow")
    
    if not logic.isSwitchsanity then
        return grape()
    else
        return canActivateSwitch("FungiYellow")
    end
end

function canActivateGalleonShipwreck()
    local logic = getSwitchLogic("GalleonShipwreck")
    
    if not logic.isSwitchsanity then
        return peanuts()
    else
        return canActivateSwitch("GalleonShipwreck")
    end
end

function canActivateIslesAztecLobbyFeather()
    local logic = getSwitchLogic("IslesAztecLobbyFeather")
    
    if not logic.isSwitchsanity then
        return feather()
    else
        return canActivateSwitch("IslesAztecLobbyFeather")
    end
end

function canActivateJapesDiddyCave()
    local logic = getSwitchLogic("JapesDiddyCave")
    
    if not logic.isSwitchsanity then
        return peanuts()
    else
        return canActivateSwitch("JapesDiddyCave")
    end
end

function canActivateIslesFungiLobbyFeather()
    local logic = getSwitchLogic("IslesFungiLobbyFeather")
    
    if not logic.isSwitchsanity then
        return feather()
    else
        return canActivateSwitch("IslesFungiLobbyFeather")
    end
end

function canActivateAztecBlueprintDoor()
    local logic = getSwitchLogic("AztecBlueprintDoor")
    
    if not logic.isSwitchsanity then
        return coconut()
    else
        return canActivateSwitch("AztecBlueprintDoor")
    end
end

function canActivateGalleonLighthouse()
    local logic = getSwitchLogic("GalleonLighthouse")
    
    if not logic.isSwitchsanity then
        return coconut()
    else
        return canActivateSwitch("GalleonLighthouse")
    end
end

function canActivateGalleonCannonGame()
    local logic = getSwitchLogic("GalleonCannonGame")
    
    if not logic.isSwitchsanity then
        return pineapple()
    else
        return canActivateSwitch("GalleonCannonGame")
    end
end

function canActivateIslesHelmLobbyGone()
    local logic = getSwitchLogic("IslesHelmLobbyGone")
    
    if not logic.isSwitchsanity then
        return gone()
    else
        return canActivateSwitch("IslesHelmLobbyGone")
    end
end

function canActivateAztecLlamaFeather()
    local logic = getSwitchLogic("AztecLlamaFeather")
    
    if not logic.isSwitchsanity then
        return feather()
    else
        return canActivateSwitch("AztecLlamaFeather")
    end
end

function canActivateJapesPainting()
    local logic = getSwitchLogic("JapesPainting")
    
    if not logic.isSwitchsanity then
        return peanuts()
    else
        return canActivateSwitch("JapesPainting")
    end
end

function canActivateAztecLlamaCoconut()
    local logic = getSwitchLogic("AztecLlamaCoconut")
    
    if not logic.isSwitchsanity then
        return coconut()
    else
        return canActivateSwitch("AztecLlamaCoconut")
    end
end

function canActivateJapesFreeKong()
    local logic = getSwitchLogic("JapesFreeKong")
    if not logic.isSwitchsanity then
        return coconut()
    else
        return canActivateSwitch("JapesFreeKong")
    end
end

function canActivateKONGPuzzle()
    local logic = getSwitchLogic("AztecOKONGPuzzle")
    if not logic.isSwitchsanity then
        return charge()
    else
        return canActivateSwitch("AztecOKONGPuzzle")
    end
end

function canActivateAztecLlamaPuzzle()
    local logic = getSwitchLogic("AztecLlamaPuzzle")
    if not logic.isSwitchsanity then
        return bongos() and coconut()
    else
        return canActivateSwitch("AztecLlamaPuzzle")
    end
end

function canActivateFactoryFreeKong()
    local logic = getSwitchLogic("FactoryFreeKong")
    if not logic.isSwitchsanity then
        return factorySlam() and has("lanky") and ostand()
    else
        local result = canActivateSwitch("FactoryFreeKong")
        -- If Lanky is assigned to this switch, add orangstand requirement
        if logic.kong == "lanky" then
            result = result and ostand()
        end
        return result
    end
end