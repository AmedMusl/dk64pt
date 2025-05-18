function getSwitchKong(switch_name)
    if SWITCHSANITY and SWITCHSANITY[switch_name] and SWITCHSANITY[switch_name]["kong"] then
        return SWITCHSANITY[switch_name]["kong"]
    end
    return nil -- Default if not found or not using switchsanity
end

function getSwitchType(switch_name)
    if SWITCHSANITY and SWITCHSANITY[switch_name] and SWITCHSANITY[switch_name]["type"] then
        return SWITCHSANITY[switch_name]["type"]
    end
    return nil -- Default if not found or not using switchsanity
end

-- Check if a specific kong can activate a switch
function canActivateSwitch(switch_name)
    local kong = getSwitchKong(switch_name)
    local switch_type = getSwitchType(switch_name)
    
    if not kong or not switch_type then
        -- Switch not found in SwitchSanity data, use default logic
        return true
    end
    
    -- First check if the player has the required kong
    if kong == "donkey" and not has("donkey") then return false end
    if kong == "diddy" and not has("diddy") then return false end
    if kong == "lanky" and not has("lanky") then return false end
    if kong == "tiny" and not has("tiny") then return false end
    if kong == "chunky" and not has("chunky") then return false end
    
    -- Kong-specific checks
    if kong == "donkey" then
        if switch_type == "GunSwitch" then
            return coconut()
        elseif switch_type == "InstrumentPad" then
            return bongos()
        elseif switch_type == "SlamSwitch" then
            return has("donkey") and has("slam")
        elseif switch_type == "PadMove" then
            return blast()
        elseif switch_type == "MiscActivator" then
            return grab()
        end
    elseif kong == "diddy" then
        if switch_type == "GunSwitch" then
            return peanuts()
        elseif switch_type == "InstrumentPad" then
            return guitar()
        elseif switch_type == "PadMove" then
            return spring()
        elseif switch_type == "SlamSwitch" then
            return has("diddy") and has("slam")
        elseif switch_type == "MiscActivator" then
            return charge()
        end
    elseif kong == "lanky" then
        if switch_type == "GunSwitch" then
            return grape()
        elseif switch_type == "InstrumentPad" then
            return trombone()
        elseif switch_type == "PadMove" then
            return balloon()
        elseif switch_type == "SlamSwitch" then
            return has("lanky") and has("slam")
        end
    elseif kong == "tiny" then
        if switch_type == "GunSwitch" then
            return feather()
        elseif switch_type == "InstrumentPad" then
            return sax()
        elseif switch_type == "PadMove" then
            return port()
        elseif switch_type == "SlamSwitch" then
            return has("tiny") and has("slam")
        end
    elseif kong == "chunky" then
        if switch_type == "GunSwitch" then
            return pineapple()
        elseif switch_type == "InstrumentPad" then
            return triangle()
        elseif switch_type == "PadMove" then
            return gone()
        elseif switch_type == "SlamSwitch" then
            return has("chunky") and has("slam")
        end
    end
    
    return false
end

function canActivateAztecGuitar()
    return canActivateSwitch("AztecGuitar")
end

function canActivateJapesFeather()
    return canActivateSwitch("JapesFeather")
end

function canActivateIslesSpawnRocketbarrel()
    return canActivateSwitch("IslesSpawnRocketbarrel")
end

function canActivateAztecQuickSandSwitch()
    return canActivateSwitch("AztecQuicksandSwitch") and aztecSlam()
end

function canActivateJapesRambi()
    return canActivateSwitch("JapesRambi")
end

function canActivateFungiGreenFeather()
    return canActivateSwitch("FungiGreenFeather")
end

function canActivateFungiGreenPineapple()
    return canActivateSwitch("FungiGreenPineapple")
end

function canActivateIslesMonkeyport()
    return canActivateSwitch("IslesMonkeyport")
end

function canActivateAztecLlamaGrape()
    return canActivateSwitch("AztecLlamaGrape")
end

function canActivateFungiYellow()
    return canActivateSwitch("FungiYellow")
end

function canActivateGalleonShipwreck()
    return canActivateSwitch("GalleonShipwreck")
end

function canActivateIslesAztecLobbyFeather()
    return canActivateSwitch("IslesAztecLobbyFeather")
end

function canActivateJapesDiddyCave()
    return canActivateSwitch("JapesDiddyCave")
end

function canActivateIslesFungiLobbyFeather()
    return canActivateSwitch("IslesFungiLobbyFeather")
end

function canActivateAztecBlueprintDoor()
    return canActivateSwitch("AztecBlueprintDoor")
end

function canActivateGalleonLighthouse()
    return canActivateSwitch("GalleonLighthouse")
end

function canActivateGalleonCannonGame()
    return canActivateSwitch("GalleonCannonGame")
end

function canActivateIslesHelmLobbyGone()
    return canActivateSwitch("IslesHelmLobbyGone")
end

function canActivateAztecLlamaFeather()
    return canActivateSwitch("AztecLlamaFeather")
end

function canActivateJapesPainting()
    return canActivateSwitch("JapesPainting")
end

function canActivateAztecLlamaCoconut()
    return canActivateSwitch("AztecLlamaCoconut")
end