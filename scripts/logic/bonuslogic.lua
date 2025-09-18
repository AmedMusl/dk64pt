function isMinigameSanityEnabled()
    return MINIGAMEDATA ~= nil
end

function getMinigameType(minigame_name)
    if MINIGAMEDATA and MINIGAMEDATA[minigame_name] then
        return MINIGAMEDATA[minigame_name]
    end
    return nil
end

function getMinigameLogic(minigame_name)
    local result = {}
    result.isMinigameSanity = isMinigameSanityEnabled()
    result.minigameType = getMinigameType(minigame_name)
    
    return result
end

function canPlayMinigame(minigame_name)
    local logic = getMinigameLogic(minigame_name)
    if not logic.isMinigameSanity then
        return true
    end
    if not logic.minigameType then
        return true
    end
    
    -- Define the logic for each minigame type
    if logic.minigameType == "LankyShooting" then
        return anyGun()
    elseif logic.minigameType == "BeaverBotherHard" then
        return true
    elseif logic.minigameType == "BeaverBotherNormal" then
        return true
    elseif logic.minigameType == "BeaverBotherEasy" then
        return true
    elseif logic.minigameType == "TinyMushroom" then
        return true
    elseif logic.minigameType == "DonkeyTarget" then
        return blast()
    elseif logic.minigameType == "LankyMaze" then
        return sprint()
    elseif logic.minigameType == "TinyPonyTailTwirl" then
        return twirl()
    elseif logic.minigameType == "Arcade100" then
        return true
    elseif logic.minigameType == "Arcade75" then
        return true
    elseif logic.minigameType == "Arcade50" then
        return true
    elseif logic.minigameType == "Arcade25" then
        return true
    elseif logic.minigameType == "OrangeBarrel" then
        return has("oranges")
    elseif logic.minigameType == "DiddyKremling" then
        return has("slam")
    elseif logic.minigameType == "ChunkyHiddenKremling" then
        return hunky() and punch()
    elseif logic.minigameType == "ChunkyShooting" then
        return anyGun() and (has("sniper") or has("homing") or hard_shooting())
    elseif logic.minigameType == "VineBarrel" then
        return has("climb") and has("vine")
    elseif logic.minigameType == "DiddyRocketbarrel" then
        return rocket() and peanuts()
    elseif logic.minigameType == "NoGame" then
        return true
    elseif logic.minigameType == "DonkeyRambi" then
        return has("donkey") and blast()
    elseif logic.minigameType == "BarrelBarrel" then
        return has("barrel")
    elseif logic.minigameType == "DiveBarrel" then
        return has("dive")
    elseif logic.minigameType == "JetpacRocket" then
        return true
    -- Batty Barrel Bandit variants
    elseif logic.minigameType == "BattyBarrelBanditVEasy" then
        return true
    elseif logic.minigameType == "BattyBarrelBanditEasy" then
        return true
    elseif logic.minigameType == "BattyBarrelBanditNormal" then
        return true
    elseif logic.minigameType == "BattyBarrelBanditHard" then
        return true
    -- Big Bug Bash variants
    elseif logic.minigameType == "BigBugBashVEasy" then
        return true
    elseif logic.minigameType == "BigBugBashEasy" then
        return true
    elseif logic.minigameType == "BigBugBashNormal" then
        return true
    elseif logic.minigameType == "BigBugBashHard" then
        return true
    -- Busy Barrel Barrage variants
    elseif logic.minigameType == "BusyBarrelBarrageEasy" then
        return anyGun()
    elseif logic.minigameType == "BusyBarrelBarrageNormal" then
        return anyGun()
    elseif logic.minigameType == "BusyBarrelBarrageHard" then
        return anyGun()
    -- Mad Maze Maul variants
    elseif logic.minigameType == "MadMazeMaulEasy" then
        return true
    elseif logic.minigameType == "MadMazeMaulNormal" then
        return true
    elseif logic.minigameType == "MadMazeMaulHard" then
        return (has("shockwave") or has("oranges")) and anyGun()
    elseif logic.minigameType == "MadMazeMaulInsane" then
        return anyGun()
    -- Minecart Mayhem variants
    elseif logic.minigameType == "MinecartMayhemEasy" then
        return true
    elseif logic.minigameType == "MinecartMayhemNormal" then
        return true
    elseif logic.minigameType == "MinecartMayhemHard" then
        return true
    -- Teetering Turtle Trouble variants
    elseif logic.minigameType == "TeeteringTurtleTroubleVEasy" then
        return true
    elseif logic.minigameType == "TeeteringTurtleTroubleEasy" then
        return true
    elseif logic.minigameType == "TeeteringTurtleTroubleNormal" then
        return true
    elseif logic.minigameType == "TeeteringTurtleTroubleHard" then
        return true
    -- Stealthy Snoop variants
    elseif logic.minigameType == "StealthySnoopVEasy" then
        return true
    elseif logic.minigameType == "StealthySnoopEasy" then
        return true
    elseif logic.minigameType == "StealthySnoopNormal" then
        return true
    elseif logic.minigameType == "StealthySnoopHard" then
        return true
    -- Stash Snatch variants
    elseif logic.minigameType == "StashSnatchEasy" then
        return true
    elseif logic.minigameType == "StashSnatchNormal" then
        return true
    elseif logic.minigameType == "StashSnatchHard" then
        return true
    elseif logic.minigameType == "StashSnatchInsane" then
        return true
    -- Splish Splash Salvage variants
    elseif logic.minigameType == "SplishSplashSalvageEasy" then
        return has("dive") and has("vine")
    elseif logic.minigameType == "SplishSplashSalvageNormal" then
        return has("dive")
    elseif logic.minigameType == "SplishSplashSalvageHard" then
        return has("dive")
    -- Speedy Swing Sortie variants
    elseif logic.minigameType == "SpeedySwingSortieEasy" then
        return has("vine")
    elseif logic.minigameType == "SpeedySwingSortieNormal" then
        return has("vine") and twirl() and (has("monkey_maneuvers") and has("donkey") and has("climbing"))
    elseif logic.minigameType == "SpeedySwingSortieHard" then
        return has("vine")
    -- Krazy Kong Klamour variants
    elseif logic.minigameType == "KrazyKongKlamourEasy" then
        return true
    elseif logic.minigameType == "KrazyKongKlamourNormal" then
        return true
    elseif logic.minigameType == "KrazyKongKlamourHard" then
        return true
    elseif logic.minigameType == "KrazyKongKlamourInsane" then
        return true
    -- Searchlight Seek variants
    elseif logic.minigameType == "SearchlightSeekVEasy" then
        return true
    elseif logic.minigameType == "SearchlightSeekEasy" then
        return true
    elseif logic.minigameType == "SearchlightSeekNormal" then
        return true
    elseif logic.minigameType == "SearchlightSeekHard" then
        return true
    -- Kremling Kosh variants
    elseif logic.minigameType == "KremlingKoshVEasy" then
        return true
    elseif logic.minigameType == "KremlingKoshEasy" then
        return true
    elseif logic.minigameType == "KremlingKoshNormal" then
        return true
    elseif logic.minigameType == "KremlingKoshHard" then
        return true
    -- Peril Path Panic variants
    elseif logic.minigameType == "PerilPathPanicVEasy" then
        return true
    elseif logic.minigameType == "PerilPathPanicEasy" then
        return true
    elseif logic.minigameType == "PerilPathPanicNormal" then
        return true
    elseif logic.minigameType == "PerilPathPanicHard" then
        return true
    -- Arena minigames
    elseif logic.minigameType == "RambiArena" then
        return true
    elseif logic.minigameType == "EnguardeArena" then
        return true
    end
    
    return false
end

-- Specific functions for each minigame location
function canPlayForestDiddyTopofMushroom()
    local logic = getMinigameLogic("ForestDiddyTopofMushroom")
    
    if not logic.isMinigameSanity then
        return rocket()
    else
        if logic.minigameType == "NoGame" then
            return rocket()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return rocket() and canPlayMinigame("ForestDiddyTopofMushroom")
        else
            return rocket() and canPlayMinigame("ForestDiddyTopofMushroom")
        end
    end
end

function canPlayFactoryTinyProductionRoom()
    local logic = getMinigameLogic("FactoryTinyProductionRoom")
    
    if not logic.isMinigameSanity then
        return production() and twirl() and factorySlam() and has("climb")
    else
        if logic.minigameType == "NoGame" then
            return production() and twirl() and factorySlam() and has("climb")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return production() and twirl() and factorySlam() and has("climb") and canPlayMinigame("FactoryTinyProductionRoom")
        else
            return production() and twirl() and factorySlam() and has("climb") and canPlayMinigame("FactoryTinyProductionRoom")
        end
    end
end

function canPlayCavesChunky5DoorCabin()
    local logic = getMinigameLogic("CavesChunky5DoorCabin")
    
    if not logic.isMinigameSanity then
        return triangle() and has("slam") and gone()
    else
        if logic.minigameType == "NoGame" then
            return triangle() and has("slam") and gone()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return triangle() and has("slam") and gone() and pineapple() and canPlayMinigame("CavesChunky5DoorCabin")
        else
            return triangle() and has("slam") and gone() and canPlayMinigame("CavesChunky5DoorCabin")
        end
    end
end

function canPlayHelmTiny2()
    local logic = getMinigameLogic("HelmTiny2")
    
    if not logic.isMinigameSanity then
        return sax()
    else
        if logic.minigameType == "NoGame" then
            return sax
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return sax() and canPlayMinigame("HelmTiny2")
        else
            return sax() and canPlayMinigame("HelmTiny2")
        end
    end
end

function canPlayHelmDonkey1()
    local logic = getMinigameLogic("HelmDonkey1")
    
    if not logic.isMinigameSanity then
        return bongos()
    else
        if logic.minigameType == "NoGame" then
            return true
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return bongos() and canPlayMinigame("HelmDonkey1")
        else
            return bongos() and canPlayMinigame("HelmDonkey1")
        end
    end
end

function canPlayCastleLankyTower()
    local logic = getMinigameLogic("CastleLankyTower")
    
    if not logic.isMinigameSanity then
        local baseRequirements = castleSlam() and grape() and balloon()
        if has("sniper") then
            return baseRequirements
        elseif has("homing") then
            return baseRequirements and hard_shooting()
        else
            return false
        end
    else
        if logic.minigameType == "NoGame" then
            local baseRequirements = castleSlam() and grape() and balloon()
            if has("sniper") then
                return baseRequirements
            elseif has("homing") then
                return baseRequirements and hard_shooting()
            else
                return false
            end
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            local baseRequirements = castleSlam() and grape() and balloon() and canPlayMinigame("CastleLankyTower")
            if has("sniper") then
                return baseRequirements
            elseif has("homing") then
                return baseRequirements and hard_shooting()
            else
                return false
            end
        else
            local baseRequirements = castleSlam() and grape() and balloon() and canPlayMinigame("CastleLankyTower")
            if has("sniper") then
                return baseRequirements
            elseif has("homing") then
                return baseRequirements and hard_shooting()
            else
                return false
            end
        end
    end
end

function canPlayJapesTinyFeatherGateBarrel()
    local logic = getMinigameLogic("JapesTinyFeatherGateBarrel")
    
    if not logic.isMinigameSanity then
        return (canActivateJapesDiddyCave() or phaseswim()) and feather()
    else
        if logic.minigameType == "NoGame" then
            return (canActivateJapesDiddyCave() or phaseswim()) and feather()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return (canActivateJapesDiddyCave() or phaseswim()) and feather() and canPlayMinigame("JapesTinyFeatherGateBarrel")
        else
            return (canActivateJapesDiddyCave() or phaseswim()) and feather() and canPlayMinigame("JapesTinyFeatherGateBarrel")
        end
    end
end

function canPlayAztecDonkeyQuicksandCave()
    local logic = getMinigameLogic("AztecDonkeyQuicksandCave")
    
    if not logic.isMinigameSanity then
        return canEnterLlamaTemple() and llamaSwitches() and canActivateAztecQuickSandSwitch() and strong()
    else
        if logic.minigameType == "NoGame" then
            return canEnterLlamaTemple() and llamaSwitches() and canActivateAztecQuickSandSwitch() and strong()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return canEnterLlamaTemple() and llamaSwitches() and canActivateAztecQuickSandSwitch() and strong() and canPlayMinigame("AztecDonkeyQuicksandCave")
        else
            return canEnterLlamaTemple() and llamaSwitches() and canActivateAztecQuickSandSwitch() and strong() and canPlayMinigame("AztecDonkeyQuicksandCave")
        end
    end
end

function canPlayHelmDiddy2()
    local logic = getMinigameLogic("HelmDiddy2")
    
    if not logic.isMinigameSanity then
        return rocket() and guitar()
    else
        if logic.minigameType == "NoGame" then
            return rocket() and guitar()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return rocket() and guitar() and canPlayMinigame("HelmDiddy2")
        else
            return rocket() and guitar() and canPlayMinigame("HelmDiddy2")
        end
    end
end

function canPlayIslesLankyCastleLobby()
    local logic = getMinigameLogic("IslesLankyCastleLobby")
    
    if not logic.isMinigameSanity then
        return true
    else
        if logic.minigameType == "NoGame" then
            return true
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return canPlayMinigame("IslesLankyCastleLobby")
        else
            return canPlayMinigame("IslesLankyCastleLobby")
        end
    end
end

function canPlayGalleonTiny2DoorShip()
    local logic = getMinigameLogic("GalleonTiny2DoorShip")
    
    if not logic.isMinigameSanity then
        return has("tiny") and has("dive") or phaseswim()
    else
        if logic.minigameType == "NoGame" then
            return has("tiny") and has("dive") or phaseswim()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return has("tiny") and has("dive") or phaseswim() and canPlayMinigame("GalleonTiny2DoorShip")
        else
            return has("tiny") and has("dive") or phaseswim() and canPlayMinigame("GalleonTiny2DoorShip")
        end
    end
end

function canPlayCavesDiddyJetpackBarrel()
    local logic = getMinigameLogic("CavesDiddyJetpackBarrel")
    
    if not logic.isMinigameSanity then
        return rocket() or (has("donkey") and avp()) or (twirl() and avp())
    else
        if logic.minigameType == "NoGame" then
            return rocket() or (has("donkey") and avp()) or (twirl() and avp())
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return (rocket() and peanuts()) or (has("donkey") and avp() and coconut()) or (twirl() and avp() and feather()) and canPlayMinigame("CavesDiddyJetpackBarrel")
        else
            return rocket() or (has("donkey") and avp()) or (twirl() and avp()) and canPlayMinigame("CavesDiddyJetpackBarrel")
        end
    end
end

function canPlayForestDonkeyBarn()
    local logic = getMinigameLogic("ForestDonkeyBarn")
    
    if not logic.isMinigameSanity then
        return canEnterThornvine() and has("slam")
    else
        if logic.minigameType == "NoGame" then
            return canEnterThornvine() and has("slam")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return canEnterThornvine() and has("slam") and has("vine") and has("climb") and coconut() and canPlayMinigame("ForestDonkeyBarn")
        else
            return canEnterThornvine() and has("slam") and has("vine") and has("climb") and canPlayMinigame("ForestDonkeyBarn")
        end
    end
end

function canPlayGalleonDonkey5DoorShip()
    local logic = getMinigameLogic("GalleonDonkey5DoorShip")
    
    if not logic.isMinigameSanity then
        return shipyard() and (bongos() or phaseswim()) and has("dive")
    else
        if logic.minigameType == "NoGame" then
            return shipyard() and (bongos() or phaseswim()) and has("dive")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return shipyard() and (bongos() or phaseswim()) and has("dive") and canPlayMinigame("GalleonDonkey5DoorShip")
        else
            return shipyard() and (bongos() or phaseswim()) and has("dive") and canPlayMinigame("GalleonDonkey5DoorShip")
        end
    end
end

function canPlayCastleTinyOverChasm()
    local logic = getMinigameLogic("CastleTinyOverChasm")
    
    if not logic.isMinigameSanity then
        return twirl()
    else
        if logic.minigameType == "NoGame" then
            return twirl()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return twirl() and canPlayMinigame("CastleTinyOverChasm")
        else
            return twirl() and canPlayMinigame("CastleTinyOverChasm")
        end
    end
end

function canPlayJapesLankySlope()
    local logic = getMinigameLogic("JapesLankySlope")
    
    if not logic.isMinigameSanity then
        return coconutCage() and ostand() or has("slope_resets")
    else
        if logic.minigameType == "NoGame" then
            return coconutCage() and ostand() or has("slope_resets")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return coconutCage() and ostand() or has("slope_resets") and canPlayMinigame("JapesLankySlope")
        else
            return coconutCage() and ostand() or has("slope_resets") and canPlayMinigame("JapesLankySlope")
        end
    end
end

function canPlayGalleonChunky5DoorShip()
    local logic = getMinigameLogic("GalleonChunky5DoorShip")
    
    if not logic.isMinigameSanity then
        return shipyard() and ((lighthouse() and loweredWater() and triangle()) or phaseswim()) and has("dive")
    else
        if logic.minigameType == "NoGame" then
            return shipyard() and ((lighthouse() and loweredWater() and triangle()) or phaseswim()) and has("dive")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return shipyard() and ((lighthouse() and loweredWater() and triangle()) or phaseswim()) and has("dive") and canPlayMinigame("GalleonChunky5DoorShip")
        else
            return shipyard() and ((lighthouse() and loweredWater() and triangle()) or phaseswim()) and has("dive") and canPlayMinigame("GalleonChunky5DoorShip")
        end
    end
end

function canPlayJapesLankyGrapeGate()
    local logic = getMinigameLogic("JapesLankyGrapeGate")
    
    if not logic.isMinigameSanity then
        return (canActivateJapesDiddyCave() or phaseswim()) and grape()
    else
        if logic.minigameType == "NoGame" then
            return (canActivateJapesDiddyCave() or phaseswim()) and grape()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return (canActivateJapesDiddyCave() or phaseswim()) and grape() and canPlayMinigame("JapesLankyGrapeGate")
        else
            return (canActivateJapesDiddyCave() or phaseswim()) and grape() and canPlayMinigame("JapesLankyGrapeGate")
        end
    end
end

function canPlayForestTinyMushroomBarrel()
    local logic = getMinigameLogic("ForestTinyMushroomBarrel")
    
    if not logic.isMinigameSanity then
        return forestSlam() and has("climb") and has("tiny")
    else
        if logic.minigameType == "NoGame" then
            return forestSlam() and has("climb") and has("tiny")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return forestSlam() and has("climb") and has("tiny") and canPlayMinigame("ForestTinyMushroomBarrel")
        else
            return forestSlam() and has("climb") and has("tiny") and canPlayMinigame("ForestTinyMushroomBarrel")
        end
    end
end

function canPlayCastleChunkyTree()
    local logic = getMinigameLogic("CastleChunkyTree")
    
    if not logic.isMinigameSanity then
        return blast() and punch() and pineapple() and (has("sniper") or hard_shooting())
    else
        if logic.minigameType == "NoGame" then
            return true
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return blast() and punch() and pineapple() and (has("sniper") or hard_shooting()) and canPlayMinigame("CastleChunkyTree")
        else
            return blast() and punch() and pineapple() and (has("sniper") or hard_shooting()) and canPlayMinigame("CastleChunkyTree")
        end
    end
end

function canPlayIslesDiddySnidesLobby()
    local logic = getMinigameLogic("IslesDiddySnidesLobby")
    
    if not logic.isMinigameSanity then
        return true
    else
        if logic.minigameType == "NoGame" then
            return true
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return spring() and peanuts() and canPlayMinigame("IslesDiddySnidesLobby")
        else
            return spring() and canPlayMinigame("IslesDiddySnidesLobby")
        end
    end
end


function canPlayForestDiddyOwlRace()
    local logic = getMinigameLogic("ForestDiddyOwlRace")
    
    if not logic.isMinigameSanity then
        return nightTime() and guitar() and rocket() and yellowTunnel()
    else
        if logic.minigameType == "NoGame" then
            return nightTime() and guitar() and rocket() and yellowTunnel()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return nightTime() and guitar() and rocket() and yellowTunnel() and canPlayMinigame("ForestDiddyOwlRace")
        else
            return nightTime() and guitar() and rocket() and yellowTunnel() and canPlayMinigame("ForestDiddyOwlRace")
        end
    end
end

function canPlayFactoryChunkybyArcade()
    local logic = getMinigameLogic("FactoryChunkybyArcade")
    
    if not logic.isMinigameSanity then
        return has("climb") and punch()
    else
        if logic.minigameType == "NoGame" then
            return has("climb") and punch()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return has("climb") and punch() and canPlayMinigame("FactoryChunkybyArcade")
        else
            return has("climb") and punch() and canPlayMinigame("FactoryChunkybyArcade")
        end
    end
end

function canPlayFactoryDiddyChunkyRoomBarrel()
    local logic = getMinigameLogic("FactoryDiddyChunkyRoomBarrel")
    
    if not logic.isMinigameSanity then
        return powerHutPlatform() and factorySlam() and has("diddy")
    else
        if logic.minigameType == "NoGame" then
            return powerHutPlatform() and factorySlam() and has("diddy")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return powerHutPlatform() and factorySlam() and peanuts() and has("vine") and canPlayMinigame("FactoryDiddyChunkyRoomBarrel")
        else
            return powerHutPlatform() and factorySlam() and has("diddy") and has("vine") and canPlayMinigame("FactoryDiddyChunkyRoomBarrel")
        end
    end
end

function canPlayAztecChunkyCagedBarrel()
    local logic = getMinigameLogic("AztecChunkyCagedBarrel")
    
    if not logic.isMinigameSanity then
        return tunnelDoor() and hunky() and has("barrel")
    else
        if logic.minigameType == "NoGame" then
            return tunnelDoor() and hunky() and has("barrel")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return tunnelDoor() and hunky() and has("barrel") and canPlayMinigame("AztecChunkyCagedBarrel")
        else
            return tunnelDoor() and hunky() and has("barrel") and canPlayMinigame("AztecChunkyCagedBarrel")
        end
    end
end

function canPlayHelmTiny1()
    local logic = getMinigameLogic("HelmTiny1")
    
    if not logic.isMinigameSanity then
        return sax()
    else
        if logic.minigameType == "NoGame" then
            return sax()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return sax() and canPlayMinigame("HelmTiny1")
        else
            return sax() and canPlayMinigame("HelmTiny1")
        end
    end
end

function canPlayAztecChunky5DoorTemple()
    local logic = getMinigameLogic("AztecChunky5DoorTemple")
    
    if not logic.isMinigameSanity then
        return pineapple()
    else
        if logic.minigameType == "NoGame" then
            return pineapple()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return pineapple() and canPlayMinigame("AztecChunky5DoorTemple")
        else
            return pineapple() and canPlayMinigame("AztecChunky5DoorTemple")
        end
    end
end

function canPlayHelmChunky1()
    local logic = getMinigameLogic("HelmChunky1")
    
    if not logic.isMinigameSanity then
        return triangle()
    else
        if logic.minigameType == "NoGame" then
            return triangle()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return triangle() and canPlayMinigame("HelmChunky1")
        else
            return triangle() and canPlayMinigame("HelmChunky1")
        end
    end
end


function canPlayCastleDiddyAboveCastle()
    local logic = getMinigameLogic("CastleDiddyAboveCastle")
    
    if not logic.isMinigameSanity then
        return rocket()
    else
        if logic.minigameType == "NoGame" then
            return rocket()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return rocket() and canPlayMinigame("CastleDiddyAboveCastle")
        else
            return rocket() and canPlayMinigame("CastleDiddyAboveCastle")
        end
    end
end

function canPlayCastleChunkyCrypt()
    local logic = getMinigameLogic("CastleChunkyCrypt")
    
    if not logic.isMinigameSanity then
        return punch()
    else
        if logic.minigameType == "NoGame" then
            return punch()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return punch() and canPlayMinigame("CastleChunkyCrypt")
        else
            return punch() and canPlayMinigame("CastleChunkyCrypt")
        end
    end
end

function canPlayJapesChunkyGiantBonusBarrel()
    local logic = getMinigameLogic("JapesChunkyGiantBonusBarrel")
    
    if not logic.isMinigameSanity then
        return shellhive() and hunky() and has("climb")
    else
        if logic.minigameType == "NoGame" then
            return shellhive() and hunky() and has("climb")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return shellhive() and hunky() and pineapple and has("climb") and canPlayMinigame("JapesChunkyGiantBonusBarrel")
        else
            return shellhive() and hunky() and has("climb") and canPlayMinigame("JapesChunkyGiantBonusBarrel")
        end
    end
end

function canPlayGalleonLankyGoldTower()
    local logic = getMinigameLogic("GalleonLankyGoldTower")
    local inTreasure = treasure() and has("dive")
    local usingBalloon = balloon() and (raisedWater() or avp())
    if not logic.isMinigameSanity then
    return inTreasure and (usingBalloon or moonkicks())
    else
        if logic.minigameType == "NoGame" then
            return inTreasure and (usingBalloon or moonkicks())
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return inTreasure and (usingBalloon or moonkicks()) and canPlayMinigame("GalleonLankyGoldTower")
        else
            return inTreasure and (usingBalloon or moonkicks()) and canPlayMinigame("GalleonLankyGoldTower")
        end
    end
end

function canPlayIslesDiddySummit()
    local logic = getMinigameLogic("IslesDiddySummit")
    
    if not logic.isMinigameSanity then
        return has("barrel") and canActivateIslesSpawnRocketbarrel() and has("k4") and rocket() and has("chunky")
    else
        if logic.minigameType == "NoGame" then
            return has("barrel") and canActivateIslesSpawnRocketbarrel() and has("k4") and rocket() and has("chunky")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return has("barrel") and canActivateIslesSpawnRocketbarrel() and has("k4") and rocket() and has("chunky") and peanuts() and canPlayMinigame("IslesDiddySummit")
        else
            return has("barrel") and canActivateIslesSpawnRocketbarrel() and has("k4") and rocket() and has("chunky") and canPlayMinigame("IslesDiddySummit")
        end
    end
end

function canPlayIslesChunkyHelmLobby()
    local logic = getMinigameLogic("IslesChunkyHelmLobby")
    
    if not logic.isMinigameSanity then
        return canEnterHelmLobby() and ((canActivateIslesHelmLobbyGone() and has("vine")) or twirl())
    else
        if logic.minigameType == "NoGame" then
            return canEnterHelmLobby() and ((canActivateIslesHelmLobbyGone() and has("vine")) or twirl())
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return (canEnterHelmLobby() and canActivateIslesHelmLobbyGone()) and (has("vine") or twirl()) and canPlayMinigame("IslesChunkyHelmLobby")
        else
            return (canEnterHelmLobby() and canActivateIslesHelmLobbyGone()) and (has("vine") or twirl()) and canPlayMinigame("IslesChunkyHelmLobby")
        end
    end
end

function canPlayFactoryDiddyBlockTower()
    local logic = getMinigameLogic("FactoryDiddyBlockTower")
    
    if not logic.isMinigameSanity then
        return testing() and (spring() or moontail()) and has("climb")
    else
        if logic.minigameType == "NoGame" then
            return testing() and (spring() or moontail()) and has("climb")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return testing() and (spring() or moontail()) and has("climb") and peanuts() and canPlayMinigame("FactoryDiddyBlockTower")
        else
            return testing() and (spring() or moontail()) and has("climb") and canPlayMinigame("FactoryDiddyBlockTower")
        end
    end
end

function canPlayGalleonDiddy5DoorShip()
    local logic = getMinigameLogic("GalleonDiddy5DoorShip")
    
    if not logic.isMinigameSanity then
        return ((loweredWater() and guitar()) or phaseswim()) and has("dive")
    else
        if logic.minigameType == "NoGame" then
            return ((loweredWater() and guitar()) or phaseswim()) and has("dive")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return ((loweredWater() and guitar()) or phaseswim()) and has("dive") and canPlayMinigame("GalleonDiddy5DoorShip")
        else
            return ((loweredWater() and guitar()) or phaseswim()) and has("dive") and canPlayMinigame("GalleonDiddy5DoorShip")
        end
    end
end

function canPlayHelmDonkey2()
    local logic = getMinigameLogic("HelmDonkey2")
    
    if not logic.isMinigameSanity then
        return bongos()
    else
        if logic.minigameType == "NoGame" then
            return bongos()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return bongos() and canPlayMinigame("HelmDonkey2")
        else
            return bongos() and canPlayMinigame("HelmDonkey2")
        end
    end
end

function canPlayHelmLanky2()
    local logic = getMinigameLogic("HelmLanky2")
    
    if not logic.isMinigameSanity then
        return trombone()
    else
        if logic.minigameType == "NoGame" then
            return trombone()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return trombone() and canPlayMinigame("HelmLanky2")
        else
            return trombone() and canPlayMinigame("HelmLanky2")
        end
    end
end

function canPlayCastleDiddyBallroom()
    local logic = getMinigameLogic("CastleDiddyBallroom")
    
    if not logic.isMinigameSanity then
        return castleSlam() and rocket()
    else
        if logic.minigameType == "NoGame" then
            return castleSlam() and rocket()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return castleSlam() and rocket() and peanuts() and canPlayMinigame("CastleDiddyBallroom")
        else
            return castleSlam() and rocket() and canPlayMinigame("CastleDiddyBallroom")
        end
    end
end

function canPlayHelmLanky1()
    local logic = getMinigameLogic("HelmLanky1")
    
    if not logic.isMinigameSanity then
        return trombone()
    else
        if logic.minigameType == "NoGame" then
            return trombone()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return trombone() and canPlayMinigame("HelmLanky1")
        else
            return trombone() and canPlayMinigame("HelmLanky1")
        end
    end
end

function canPlayHelmDiddy1()
    local logic = getMinigameLogic("HelmDiddy1")
    
    if not logic.isMinigameSanity then
        return rocket() and guitar()
    else
        if logic.minigameType == "NoGame" then
            return rocket() and guitar()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return rocket() and guitar() and canPlayMinigame("HelmDiddy1")
        else
            return rocket() and guitar() and canPlayMinigame("HelmDiddy1")
        end
    end
end

function canPlayHelmChunky2()
    local logic = getMinigameLogic("HelmChunky2")
    
    if not logic.isMinigameSanity then
        return triangle()
    else
        if logic.minigameType == "NoGame" then
            return triangle()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return triangle() and canPlayMinigame("HelmChunky2")
        else
            return triangle() and canPlayMinigame("HelmChunky2")
        end
    end
end

function canPlayCavesTinyCaveBarrel()
    local logic = getMinigameLogic("CavesTinyCaveBarrel")
    
    if not logic.isMinigameSanity then
        return mini()
    else
        if logic.minigameType == "NoGame" then
            return mini()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return mini() and canPlayMinigame("CavesTinyCaveBarrel")
        else
            return mini() and canPlayMinigame("CavesTinyCaveBarrel")
        end
    end
end

function canPlayFactoryLankyTestingRoomBarrel()
    local logic = getMinigameLogic("FactoryLankyTestingRoomBarrel")
    
    if not logic.isMinigameSanity then
        return testing() and (balloon() or (avp() and (has("diddy") or has("lanky") or has("tiny")))) and has("climb")
    else
        if logic.minigameType == "NoGame" then
            return testing() and (balloon() or (avp() and (has("diddy") or has("lanky") or has("tiny")))) and has("climb")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return testing() and ((balloon() and grape()) or (avp() and (peanuts() or grape() or feather()))) and has("climb") and canPlayMinigame("FactoryLankyTestingRoomBarrel")
        else
            return testing() and (balloon() or (avp() and (has("diddy") or has("lanky") or has("tiny")))) and has("climb") and canPlayMinigame("FactoryLankyTestingRoomBarrel")
        end
    end
end

function canPlayAztecLanky5DoorTemple()
    local logic = getMinigameLogic("AztecLanky5DoorTemple")
    
    if not logic.isMinigameSanity then
        return grape()
    else
        if logic.minigameType == "NoGame" then
            return grape()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return grape() and canPlayMinigame("AztecLanky5DoorTemple")
        else
            return grape() and canPlayMinigame("AztecLanky5DoorTemple")
        end
    end
end

function canPlayGalleonTinySubmarine()
    local logic = getMinigameLogic("GalleonTinySubmarine")
    
    if not logic.isMinigameSanity then
        return shipyard() and has("dive") and (mini() or phaseswim() or has("swim_through_shores"))
    else
        if logic.minigameType == "NoGame" then
            return shipyard() and has("dive") and (mini() or phaseswim() or has("swim_through_shores"))
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return shipyard() and has("dive") and (mini() or phaseswim() or has("swim_through_shores")) and canPlayMinigame("GalleonTinySubmarine")
        else
            return shipyard() and has("dive") and (mini() or phaseswim() or has("swim_through_shores")) and canPlayMinigame("GalleonTinySubmarine")
        end
    end
end

function canPlayCastleLankyDungeon()
    local logic = getMinigameLogic("CastleLankyDungeon")
    
    if not logic.isMinigameSanity then
        return castleSlam() and trombone() and (balloon() or twirl())
    else
        if logic.minigameType == "NoGame" then
            return castleSlam() and trombone() and (balloon() or twirl())
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return castleSlam() and trombone() and (balloon() or twirl()) and canPlayMinigame("CastleLankyDungeon")
        else
            return castleSlam() and trombone() and (balloon() or twirl()) and canPlayMinigame("CastleLankyDungeon")
        end
    end
end

function canPlayCavesDonkeyBaboonBlast()
    local logic = getMinigameLogic("CavesDonkeyBaboonBlast")
    
    if not logic.isMinigameSanity then
        return blast()
    else
        if logic.minigameType == "NoGame" then
            return blast()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return blast() and coconut() and canPlayMinigame("CavesDonkeyBaboonBlast")
        else
            return blast() and canPlayMinigame("CavesDonkeyBaboonBlast")
        end
    end
end

function canPlayForestDonkeyBaboonBlast()
    local logic = getMinigameLogic("ForestDonkeyBaboonBlast")
    
    if not logic.isMinigameSanity then
        return blast() and canClimbMushroom()
    else
        if logic.minigameType == "NoGame" then
            return blast() and canClimbMushroom()
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return blast() and canClimbMushroom() and coconut() and canPlayMinigame("ForestDonkeyBaboonBlast")
        else
            return blast() and canClimbMushroom() and canPlayMinigame("ForestDonkeyBaboonBlast")
        end
    end
end

function canPlayAztecLankyLlamaTempleBarrel()
    local logic = getMinigameLogic("AztecLankyLlamaTempleBarrel")
    
    if not logic.isMinigameSanity then
        return llamaSwitches() and canEnterLlamaTemple() and trombone() and (ostand() or twirl() or moonkicks() or has("slope_resets"))
    else
        if logic.minigameType == "NoGame" then
            return llamaSwitches() and canEnterLlamaTemple() and trombone() and (ostand() or twirl() or moonkicks() or has("slope_resets"))
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return llamaSwitches() and canEnterLlamaTemple() and trombone() and (ostand() or twirl() or moonkicks() or has("slope_resets")) and canPlayMinigame("AztecLankyLlamaTempleBarrel")
        else
            return llamaSwitches() and canEnterLlamaTemple() and trombone() and (ostand() or twirl() or moonkicks() or has("slope_resets")) and canPlayMinigame("AztecLankyLlamaTempleBarrel")
        end
    end
end

function canPlayIslesTinyAztecLobby()
    local logic = getMinigameLogic("IslesTinyAztecLobby")
    
    if not logic.isMinigameSanity then
        return true
    else
        if logic.minigameType == "NoGame" then
            return true
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return charge() and twirl() and feather() and canPlayMinigame("IslesTinyAztecLobby")
        else
            return charge() and twirl() and canPlayMinigame("IslesTinyAztecLobby")
        end
    end
end

function canPlayForestLankyColoredMushrooms()
    local logic = getMinigameLogic("ForestLankyColoredMushrooms")
    
    if not logic.isMinigameSanity then
        return topOfMushroom() and forestSlam() and has("lanky")
    else
        if logic.minigameType == "NoGame" then
            return topOfMushroom() and forestSlam() and has("lanky")
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return topOfMushroom() and forestSlam() and has("lanky") and canPlayMinigame("ForestLankyColoredMushrooms")
        else
            return topOfMushroom() and forestSlam() and has("lanky") and canPlayMinigame("ForestLankyColoredMushrooms")
        end
    end
end

function canPlayGalleonDiddyGoldTower()
    local logic = getMinigameLogic("GalleonDiddyGoldTower")
    local inTreasure = treasure() and has("dive")
    local usingSpring = spring() and (raisedWater() or avp())
    if not logic.isMinigameSanity then
        return inTreasure and (usingSpring or moonkicks())
    else
        if logic.minigameType == "NoGame" then
            return inTreasure and (usingSpring or moonkicks())
        elseif logic.minigameType == "BusyBarrelBarrageEasy" or logic.minigameType == "BusyBarrelBarrageNormal" or logic.minigameType == "BusyBarrelBarrageHard" then
            return inTreasure and (usingSpring or moonkicks()) and canPlayMinigame("GalleonDiddyGoldTower")
        else
            return inTreasure and (usingSpring or moonkicks()) and canPlayMinigame("GalleonDiddyGoldTower")
        end
    end
end
