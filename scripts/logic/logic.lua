ScriptHost:LoadScript("scripts/logic/medallogic.lua")
ScriptHost:LoadScript("scripts/logic/logichelper.lua")
ScriptHost:LoadScript("scripts/logic/switchsanity.lua")
ScriptHost:LoadScript("scripts/logic/CBLogic.lua")

function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

function not_has(code)
    local count = Tracker:ProviderCountForCode(code)
    return count < 1
  end

function  coconut()
    return has("donkey") and has("coconut")
end

function bongos()
    return has("donkey") and has("bongos")
end

function grab()
    return has("donkey") and has("grab")
end

function blast()
    return has("donkey") and has("blast")
end

function strong()
    return has("donkey") and has("strong")
end

function peanuts()
    return has("diddy") and has("peanuts")
end

function guitar()
    return has("diddy") and has("guitar")
end

function charge()
    return has("diddy") and has("charge")
end

function spring()
    return has("diddy") and has("spring")
end

function rocket()
    return has("diddy") and has("rocket")
end

function grape()
    return has("lanky") and has("grape")
end

function trombone()
    return has("lanky") and has("trombone")
end

function ostand()
    return has("lanky") and has("orangstand")
end

function balloon()
    return has("lanky") and has("balloon")
end

function sprint()
    return has("lanky") and has("sprint")
end

function feather()
    return has("tiny") and has("feather")
end

function sax()
    return has("tiny") and has("sax")
end

function twirl()
    return has("tiny") and has("twirl")
end

function port()
    return has("tiny") and has("port")
end

function mini()
    return has("tiny") and has("mini")
end

function pineapple()
    return has("chunky") and has("pineapple")
end

function triangle()
    return has("chunky") and has("triangle")
end

function punch()
    return has("chunky") and has("punch")
end

function gone()
    return has("chunky") and has("gone")
end

function hunky()
    return has("chunky") and has("big")
end

function enguarde()
    return has("lanky") and has("dive")
end

-- Other logic
function canEnterTinyTemple()
    return pineapple() or peanuts() or feather() or grape()
end

function canEnterLlamaTemple()
    return canActivateAztecLlamaCoconut() or canActivateAztecLlamaGrape() or canActivateAztecLlamaFeather()
end

function canChangeTime()
    return coconut() or peanuts() or grape() or feather() or pineapple()
end

function topOfMushroom()
    return canClimbMushroom() and (ostand() or rocket())
end

function canClearGauntlet()
    return has("orange") or coconut() or peanuts() or grape() or feather() or pineapple() or bongos() or guitar() or trombone() or sax() or triangle()
end

function canEnterSprintCabin()
    return trombone() and (rocket() or balloon() or moonkicks())
end

function height()
    return balloon() or has("climb")
end

function pastCabinIsle()
    local hasGalleonKey = has("k4")
    local standardMethod = rocket() and has("barrel") and has("chunky") and trombone()
    local advancedPlatforming = avp() and (twirl() or has("donkey"))
    local moonkicks = moonkicks()
    
    return hasGalleonKey and (standardMethod or advancedPlatforming or moonkicks)
end

function winchCage()
    return (peanuts() and guitar() and charge() and nightTime() and ((has("climb") and forestSlam()) or ((has("climb") or balloon()) and moonkicks()))) or phaseswim()
end

function lankyGold()
    local inTreasure = treasure() and has("dive")
    local usingBalloon = balloon() and (raisedWater() or avp())
    
    return inTreasure and (usingBalloon or moonkicks())
end

function diddyGold()
    local inTreasure = treasure() and has("dive")
    local usingSpring = spring() and (raisedWater() or avp())
    
    return inTreasure and (usingSpring or moonkicks())
end

function japesHillside()
    return has("climb") or (avp() and ostand())
end

function topOfMountain()
    return peanuts() or moonkicks()
end

function japesDiddySwitch()
    return japesSlam() and (peanuts() or (avp() and has("diddy")))
end

function japesDiddyMountain()
    return topOfMountain() and japesDiddySwitch() and japesHillside() and peanuts() and japesHillside()
end

function canEnterTree()
    return blast() or phaseswim()
end

function beginningDK5DI()
    return bongos() or phaseswim()
end

function dk5DI()
    return (bongos() or phaseswim()) and (strong() or moonkicks())
end

function beginningDiddy5DI()
    return guitar() or phaseswim()
end

function diddy5DI()
    return (guitar() or phaseswim()) and (has("barrel"))
end

function beginningLanky5DI()
    return trombone() or phaseswim()
end

function lanky5DI()
    return (trombone() or phaseswim()) and (balloon() or avp()) 
end

function beginningTiny5DI()
    return sax() or phaseswim()
end

function tiny5DI()
    return (sax() or phaseswim()) and has("slam")
end

function chunky5DI()
    return triangle() or phaseswim()
end

function forestDKLevers()
    if dayTime() and nightTime() and forestSlam() and grab() and punch() and triangle() then
        return AccessibilityLevel.Normal
    elseif dayTime() and forestSlam() and grab() and punch() and triangle() then
        return phaseswim()
    end
end

function canEnterThornvine()
    if nightTime() and strong() and forestSlam() then
        return AccessibilityLevel.Normal
    elseif nightTime() then
        return phaseswim()
    end
end

function canBeatSpider()
    if not_has("dusk") then
        return punch() and mini() and canChangeTime()
    elseif has("dusk") then
        return (punch() or mini()) and canChangeTime()
    end
end

function lowerMushroomExterior()
    return (twirl() and avp()) or canClimbMushroom() or (has("climb") and (has("donkey") or has("chunky")) and avp())
end

function canClimbMushroom()
    return has("climb") or rocket() or (coconut() and peanuts() and grape() and feather() and pineapple())
end

function raisedWater()
    local in_lighthouse = lighthouse()
    if has("waterraised") then
        return true
    elseif has("waterlowered") then
        return has("dive") and in_lighthouse
    end
    return false
end

function loweredWater()
    local in_lighthouse = lighthouse()
    if has("waterlowered") then
        return true
    elseif has("waterraised") then
        return has("dive") and in_lighthouse
    end
    return false
end

function dayTime()
    if has("daytime") or has("dusk") then
        return true
    elseif has("nighttime") then
        return coconut() or peanuts() or grape() or feather() or pineapple()
    end
end

function nightTime()
    if has("nighttime") or has("dusk") then
        return true
    elseif has("daytime") then
        return coconut() or peanuts() or grape() or feather() or pineapple()
    end
end

function lankyPaint()
    return has("slam") and has("lanky") and (coconut() or grape() or peanuts() or feather() or pineapple() or bongos() or guitar() or trombone() or sax() or triangle())
end

function lighthousePlatform()
    if raisedWater() then
        return true
    elseif has("lanky") or has("chunky") then
        return avp()
    end
end

function aztecAccess()
    if canEnterAztec() and (has("vine") or twirl()) then
        return AccessibilityLevel.Normal
    elseif canEnterAztec() then
        return AccessibilityLevel.SequenceBreak
    else
        return AccessibilityLevel.None
    end
end

function japesChunkyTimed()
    if coconutCage() and canActivateJapesRambi() and has("barrel") and japesSlam() and has("chunky") and has("climb") then
        return AccessibilityLevel.Normal
    elseif coconutCage() and canActivateJapesRambi() and has("barrel") and japesSlam() and has("chunky") and ostand() then
        return AccessibilityLevel.SequenceBreak
    end
end

function japesDiddyTimed()
    if coconutCage() and japesSlam() and has("climb") and canActivateJapesRambi() and has("diddy") then
        return AccessibilityLevel.Normal
    elseif coconutCage() and canActivateJapesRambi() and japesSlam() and ostand() and has("diddy") then
        return AccessibilityLevel.SequenceBreak
    end
end

function japesLankyTimed()
    if coconutCage() and japesSlam() and has("climb") and canActivateJapesRambi() and has("lanky") then
        return AccessibilityLevel.Normal
    elseif coconutCage() and canActivateJapesRambi() and japesSlam() and ostand() and has("lanky") then
        return AccessibilityLevel.SequenceBreak
    end
end

function trash()
    if mini() and (sax() or ((feather() or coconut() or peanuts() or grape() or pineapple()) and has("homing")) or bongos() or guitar() or trombone() or triangle()) then
        return AccessibilityLevel.Normal
    elseif mini() and (feather() or coconut() or peanuts() or grape() or pineapple()) then
        return hardshooting()
    end
end

function chunkyTree()
    if pineapple() and punch() and has("sniper") then
        return AccessibilityLevel.Normal
    elseif pineapple() and punch() then
        return hardshooting()
    end
end

function lankyTower()
    if has("sniper") and balloon() and grape() and castleSlam() then
        return AccessibilityLevel.Normal
    elseif has("homing") and balloon() and grape() and castleSlam() then
        return hardshooting()
    end
end

function dkCabin()
    if bongos() and ((coconut() or peanuts() or grape() or feather() or pineapple()) and has("homing")) then
        return AccessibilityLevel.Normal
    elseif bongos() and (coconut() or peanuts() or grape() or feather() or pineapple()) then
        return hardshooting()
    end
end

function lankyAttic()
    if has("lanky") and nightTime() and forestSlam() and (balloon() or has("climb")) and ((coconut() or peanuts() or grape() or feather() or pineapple()) and has("homing")) then
        return AccessibilityLevel.Normal
    elseif has("lanky") and nightTime() and forestSlam() and (balloon() or has("climb")) and (coconut() or peanuts() or grape() or feather() or pineapple()) then
        return hardshooting()
    end
end

function chunkyShed()
    return punch() and ((gone() and canChangeTime()) or triangle() or bongos() or guitar() or trombone() or sax())
end

function powerHutPlatform()
    return (testing() and has("climb")) or (moonkicks()) or (twirl() and avp())
end

function canGetOnCannonGamePlatform()
    return raisedWater() or (avp() and (has("chunky") or has("lanky")))
end

function lankyFreeing()
    if LANKY_FREEING_KONG == "donkey" then
        return bongos()
    elseif LANKY_FREEING_KONG == "diddy" then
        return guitar()
    elseif LANKY_FREEING_KONG == "lanky" then
        return trombone()
    elseif LANKY_FREEING_KONG == "tiny" then
        return sax()
    elseif LANKY_FREEING_KONG == "chunky" then
        return triangle()
    end
    -- Default case if LANKY_FREEING_KONG is not set
    return false
end

-- Glitches

function avp()
    if has("advanced_platforming") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function avpMedal()
    return has("advanced_platforming")
end

function hardshooting()
    if has("hardshooting") then
        return AccessibilityLevel.Normal
    else
        return AccessibilityLevel.SequenceBreak
    end
end

function moonkicks()
    return has("moonkicks") and has("donkey")
end

function phaseswim()
    return has("phase_swimming") and has("dive")
end

function sts()
    return has("swim_through_shores") and has("dive")
end

function tnsskip()
    return has("troff_n_scoff_skips")
end

function moontail()
    return has("diddy") and has("moontail")
end

-- Barriers

function coconutCage()
    if has("japes_coconut_gates") then
        return AccessibilityLevel.Normal
    elseif has("climb") then
        return AccessibilityLevel.Normal
    elseif ostand() then
        return avp()
    end
end

function shellhive()
    local in_coconut = coconutCage()
    if has("japes_shellhive_gate") then
        return in_coconut
    else
        return in_coconut and (canActivateJapesFeather() or (moonkicks() and has("climb")))
    end
end

function templeIce()
    if has("aztec_tiny_temple_ice") then
        return true
    else
        return aztecSlam() and peanuts() and guitar()
    end
end

function tunnelDoor()
    if has("aztec_tunnel_door") then
        return AccessibilityLevel.Normal
    elseif canActivateAztecGuitar() and has("climb") and ((has("vine")) or rocket()) then
        return AccessibilityLevel.Normal
    else
        return guitar() and AccessibilityLevel.SequenceBreak
    end
end

function aztec5DT()
    local in_tunnel = tunnelDoor()
    if has("aztec_5dtemple_switches") then
        return in_tunnel
    else
        return rocket() and peanuts() and aztecSlam() and in_tunnel
    end
end

function llamaSwitches()
    local in_tunnel = tunnelDoor()
    if has("aztec_llama_switches") then
        return in_tunnel
    else
        return blast() and in_tunnel
    end
end

function production()
    local powerhut = powerHutPlatform() and (coconut() or moonkicks())
    if has("factory_production_room") then
        return true
    else
        return powerhut and grab()
    end
end

function testing()
    if has("factory_testing_gate") then
        return true
    else
        return has("slam")
    end
end

function lighthouse()
    if has("galleon_lighthouse_gate") then
        return true
    else
        return canActivateGalleonLighthouse()
    end
end

function shipyard()
    if has("galleon_shipyard_area_gate") then
        return true
    else
        return canActivateGalleonShipwreck() or (phaseswim() and raisedWater())
    end
end

function seasick()
    local in_lighthouse = lighthouse()
    if has("galleon_seasick_ship") then
        return in_lighthouse and lighthousePlatform()
    else
        return has("climb") and galleonSlam() and grab() and in_lighthouse and lighthousePlatform()
    end
end

function treasure()
    local in_shipyard = shipyard()
    
    if has("galleon_treasure_room") then
        return in_shipyard
    end
    if raisedWater() and enguarde() then
        return in_shipyard
    elseif phaseswim() then
        return (canActivateGalleonCannonGame() and raisedWater()) or in_shipyard
    else
        return in_shipyard and has("lanky") and avp()
    end
end

function greenTunnel()
    if has("forest_green_tunnel") then
        return true
    else
        return (canActivateFungiGreenFeather() and canActivateFungiGreenPineapple()) or phaseswim()
    end
end

function greenTunnelFeather()
    if has("forest_green_tunnel") then
        return true
    else
        return canActivateFungiGreenFeather() or phaseswim()
    end
end

function yellowTunnel()
    if has("forest_yellow_tunnel") then
        return true
    else
        return canActivateFungiYellow() or phaseswim()
    end
end

function igloo()
    if has("caves_igloo_pads") then
        return true
    else
        return rocket() or phaseswim()
    end
end

function cavesIce()
    if has("caves_ice_walls") then
        return true
    else
        return punch()
    end
end

function dkCryptDoors()
    if has("castle_crypt_doors") then
        return true
    else
        return coconut()
    end
end

function diddyCryptDoors()
    if has("castle_crypt_doors") then
        return true
    else
        return peanuts()
    end
end

function chunkyCryptDoors()
    if has("castle_crypt_doors") then
        return true
    else
        return pineapple()
    end
end

function cryptDoors()
    if has("castle_crypt_doors") then
        return true
    else
        return coconut() or peanuts() or pineapple()
    end
end

function mausoleumDoors()
    if has("castle_crypt_doors") then
        return true
    else
        return grape() or feather()
    end
end

-- Slam logic

function japesSlam()
    if has("greenslam")  and (has("l1_japes") or has("l2_japes") or has("l3_japes") or has("l4_japes")) then
      return true
    end
    if has("blueslam") and (has("l5_japes") or has("l6_japes")) then
      return true
    end
    if has("redslam") and has("l7_japes") then
      return true
    end
    return false
  end

  function aztecSlam()
    if has("greenslam") and (has("l1_aztec") or has("l2_aztec") or has("l3_aztec") or has("l4_aztec")) then
      return true
    end
    if has("blueslam") and (has("l5_aztec") or has("l6_aztec")) then
      return true
    end
    if has("redslam") and has("l7_aztec") then
      return true
    end
    return false
  end

  function factorySlam()
    if has("greenslam") and (has("l1_factory") or has("l2_factory") or has("l3_factory") or has("l4_factory")) then
      return true
    end
    if has("blueslam") and (has("l5_factory") or has("l6_factory")) then
      return true
    end
    if has("redslam") and has("l7_factory") then
      return true
    end
    return false
  end

  function galleonSlam()
    if has("greenslam") and (has("l1_galleon") or has("l2_galleon") or has("l3_galleon") or has("l4_galleon")) then
      return true
    end
    if has("blueslam") and (has("l5_galleon") or has("l6_galleon")) then
      return true
    end
    if has("redslam") and has("l7_galleon") then
      return true
    end
    return false
  end

  function forestSlam()
    if has("greenslam") and (has("l1_forest") or has("l2_forest") or has("l3_forest") or has("l4_forest")) then
      return true
    end
    if has("blueslam") and (has("l5_forest") or has("l6_forest")) then
      return true
    end
    if has("redslam") and has("l7_forest") then
      return true
    end
    return false
  end

  function cavesSlam()
  if has("greenslam") and (has("l1_caves") or has("l2_caves") or has("l3_caves") or has("l4_caves")) then
    return true
  end
  if has("blueslam") and (has("l5_caves") or has("l6_caves")) then
    return true
  end
  if has("redslam") and has("l7_caves") then
    return true
  end
  return false
end

function castleSlam()
    if has("greenslam") and (has("l1_castle") or has("l2_castle") or has("l3_castle") or has("l4_castle")) then
      return true
    end
    if has("blueslam") and (has("l5_castle") or has("l6_castle")) then
      return true
    end
    if has("redslam") and has("l7_castle") then
      return true
    end
    return false
end

  -- Level Entry

  function canEnterWithBlocker(level, blockerCode)
    local gbCount = Tracker:ProviderCountForCode("gb")
    if not blockerCode then
        -- If blockerCode is nil, assume no blocker is required
        return has(level)
    end
    return has(level) and gbCount >= Tracker:ProviderCountForCode(blockerCode)
end

function jetPac()
    local medals = Tracker:ProviderCountForCode("medals")
    local jetrec = Tracker:ProviderCountForCode("jetpacReq")
    return medals >= jetrec
end

function BFI()
    local fairies = Tracker:ProviderCountForCode("fairies")
    local bfi = Tracker:ProviderCountForCode("bfiReq")
    return fairies >= bfi
end

function mermaid()
    local pearls = Tracker:ProviderCountForCode("pearl")
    local mermaid = Tracker:ProviderCountForCode("mermaid")
    return pearls >= mermaid
end

function hasHelm(prefix)
    for i = 1, 5 do
        if has(prefix .. i) then
            return true
        end
    end
    return false
end

-- Get the current helm order based on helm position codes
function getHelmOrder()
    local helmOrder = {}
    local helmRequirements = {
        helmdk = function() return bongos() end,
        helmdiddy = function() return rocket() and guitar() end,
        helmlanky = function() return trombone() end,
        helmtiny = function() return sax() end,
        helmchunky = function() return triangle() end
    }
    
    -- Check each position (1-5) and see which kong is assigned to it
    for i = 1, 5 do
        for kongCode, requirement in pairs(helmRequirements) do
            if has(kongCode .. i) then
                table.insert(helmOrder, {kong = kongCode, check = requirement, position = i})
                break
            end
        end
    end
    
    -- Sort by position to ensure correct order
    table.sort(helmOrder, function(a, b) return a.position < b.position end)
    
    return helmOrder
end

-- Check if a kong is in the current helm order and return its position
function getKongHelmPosition(kongCode)
    local helmOrder = getHelmOrder()
    for i, helm in ipairs(helmOrder) do
        if helm.kong == kongCode then
            return i
        end
    end
    return nil
end

function dkHelm()
    local helmOrder = getHelmOrder()
    local dkPosition = getKongHelmPosition("helmdk")
    
    -- If DK is not in the helm order, return true (not required)
    if not dkPosition then
        return bongos()
    end
    
    -- DK is in the helm order, check all requirements from positions 1 to DK's position
    -- This includes ALL previous kongs' requirements AND DK's own requirement
    for i = 1, dkPosition do
        if not helmOrder[i].check() then
            return false
        end
    end
    
    return true
end

function diddyHelm()
    local helmOrder = getHelmOrder()
    local diddyPosition = getKongHelmPosition("helmdiddy")
    
    -- If Diddy is not in the helm order, return true (not required)
    if not diddyPosition then
        return rocket() and guitar()
    end
    
    -- Diddy is in the helm order, check all requirements from positions 1 to Diddy's position
    for i = 1, diddyPosition do
        if not helmOrder[i].check() then
            return false
        end
    end
    
    return true
end

function lankyHelm()
    local helmOrder = getHelmOrder()
    local lankyPosition = getKongHelmPosition("helmlanky")
    
    -- If Lanky is not in the helm order, return true (not required)
    if not lankyPosition then
        return trombone()
    end
    
    -- Lanky is in the helm order, check all requirements from positions 1 to Lanky's position
    for i = 1, lankyPosition do
        if not helmOrder[i].check() then
            return false
        end
    end
    
    return true
end

function tinyHelm()
    local helmOrder = getHelmOrder()
    local tinyPosition = getKongHelmPosition("helmtiny")
    
    -- If Tiny is not in the helm order, return true (not required)
    if not tinyPosition then
        return sax()
    end
    
    -- Tiny is in the helm order, check all requirements from positions 1 to Tiny's position
    for i = 1, tinyPosition do
        if not helmOrder[i].check() then
            return false
        end
    end
    
    return true
end

function chunkyHelm()
    local helmOrder = getHelmOrder()
    local chunkyPosition = getKongHelmPosition("helmchunky")
    
    -- If Chunky is not in the helm order, return true (not required)
    if not chunkyPosition then
        return triangle()
    end
    
    -- Chunky is in the helm order, check all requirements from positions 1 to Chunky's position
    for i = 1, chunkyPosition do
        if not helmOrder[i].check() then
            return false
        end
    end
    
    return true
end

function endOfHelm()
    local helmOrder = getHelmOrder()
    
    -- Check that all kongs in the helm order meet their requirements
    for _, helm in ipairs(helmOrder) do
        if not helm.check() then
            return false
        end
    end

    return true
end

function toggleLevelOrder()
    if has("openlobbies") then
        Tracker:FindObjectForCode("num2").Active = true
        Tracker:FindObjectForCode("num3").Active = true
        Tracker:FindObjectForCode("num4").Active = true
        Tracker:FindObjectForCode("num5").Active = true
        Tracker:FindObjectForCode("num6").Active = true
        Tracker:FindObjectForCode("num7").Active = true
        Tracker:FindObjectForCode("num8").Active = true
    else
        Tracker:FindObjectForCode("num2").Active = false
        Tracker:FindObjectForCode("num3").Active = false
        Tracker:FindObjectForCode("num4").Active = false
        Tracker:FindObjectForCode("num5").Active = false
        Tracker:FindObjectForCode("num6").Active = false
        Tracker:FindObjectForCode("num7").Active = false
        Tracker:FindObjectForCode("num8").Active = false
        if has("k1") then
            Tracker:FindObjectForCode("num2").Active = true
        end
        
        if has("k2") then
            Tracker:FindObjectForCode("num3").Active = true
        end
        
        if has("k2") and has("dive") then
            Tracker:FindObjectForCode("num4").Active = true
        end
        
        if has("k4") then
            Tracker:FindObjectForCode("num5").Active = true
        end
        
        if has("k5") then
            Tracker:FindObjectForCode("num6").Active = true
            Tracker:FindObjectForCode("num7").Active = true
        end
        
        if has("k6") and has("k7") then
            Tracker:FindObjectForCode("num8").Active = true
        end
    end
end
function hasBoss(prefix)
    for i = 1, 7 do
        if has(prefix .. i) then
            return true
        end
    end
    return false
end

-- Check if a specific boss is assigned to a level (by TNS order)
function checkBossInLevel(levelNum, bossName)
    local bossMap = {
        army1 = {"army11", "army12", "army13", "army14", "army1", "army16", "army17"},
        doga1 = {"doga11", "doga12", "doga13", "doga14", "doga15", "doga16", "doga17"},
        jack = {"jack1", "jack2", "jack3", "jack4", "jack5", "jack6", "jack7"},
        puff = {"puff1", "puff2", "puff3", "puff4", "puff5", "puff6", "puff7"},
        doga2 = {"doga21", "doga22", "doga23", "doga24", "doga25", "doga26", "doga27"},
        army2 = {"army21", "army22", "army23", "army24", "army25", "army26", "army27"},
        kutout = {"kutout1", "kutout2", "kutout3", "kutout4", "kutout5", "kutout6", "kutout7"},
        dkphase = {"dkphase1", "dkphase2", "dkphase3", "dkphase4", "dkphase5", "dkphase6", "dkphase7"},
        diddyphase = {"diddyphase1", "diddyphase2", "diddyphase3", "diddyphase4", "diddyphase5", "diddyphase6", "diddyphase7"},
        lankyphase = {"lankyphase1", "lankyphase2", "lankyphase3", "lankyphase4", "lankyphase5", "lankyphase6", "lankyphase7"},
        tinyphase = {"tinyphase1", "tinyphase2", "tinyphase3", "tinyphase4", "tinyphase5", "tinyphase6", "tinyphase7"},
        chunkyphase = {"chunkyphase1", "chunkyphase2", "chunkyphase3", "chunkyphase4", "chunkyphase5", "chunkyphase6", "chunkyphase7"}
    }
    
    if bossMap[bossName] and levelNum >= 1 and levelNum <= 7 then
        return has(bossMap[bossName][levelNum])
    end
    return false
end

function hasKongForBoss(level_num)
    if not level_num or level_num < 1 or level_num > 7 then
        return true -- If invalid level number, don't block access
    end
    
    local bossKongObject = Tracker:FindObjectForCode("bosskong" .. level_num)
    if not bossKongObject then
        return true -- If boss kong object doesn't exist, don't block access
    end
    
    local kongStage = bossKongObject.CurrentStage
    if kongStage <= 0 then
        return true -- No kong requirement for this boss
    end
    
    -- Map stage number to kong code
    local kongs = {"donkey", "diddy", "lanky", "tiny", "chunky"}
    local requiredKong = kongs[kongStage]
    
    if not requiredKong then
        return true -- Invalid kong mapping, don't block access
    end
    
    -- Check if player has the required kong
    return has(requiredKong)
end

function getBossInLevel(levelNum)
    -- Check the regular bosses
    if checkBossInLevel(levelNum, "army1") then return "army1" end
    if checkBossInLevel(levelNum, "doga1") then return "doga1" end
    if checkBossInLevel(levelNum, "jack") then return "jack" end
    if checkBossInLevel(levelNum, "puff") then return "puff" end
    if checkBossInLevel(levelNum, "doga2") then return "doga2" end
    if checkBossInLevel(levelNum, "army2") then return "army2" end
    if checkBossInLevel(levelNum, "kutout") then return "kutout" end
    if checkBossInLevel(levelNum, "dkphase") then return "dkphase" end
    if checkBossInLevel(levelNum, "diddyphase") then return "diddyphase" end
    if checkBossInLevel(levelNum, "lankyphase") then return "lankyphase" end
    if checkBossInLevel(levelNum, "tinyphase") then return "tinyphase" end
    if checkBossInLevel(levelNum, "chunkyphase") then return "chunkyphase" end
    
    return nil
end

-- Simplified boss logic functions for vanilla TNS requirements

function japesBossLogic()
    -- Check if player has the required kong for Japes (level 1)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(1) then
        return false
    end
    
    -- Check the TNS requirement for Japes
    if not_has("troff_n_scoff_skips") and not has("tns1") then
        return false
    end
    
    -- Check CB requirement for Japes unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not japesCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Japes
    local boss = getBossInLevel(1)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function aztecBossLogic()
    -- Check if player has the required kong for Aztec (level 2)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(2) then
        return false
    end
    
    -- Check the TNS requirement for Aztec
    if not_has("troff_n_scoff_skips") and not has("tns2") then
        return false
    end
    
    -- Check CB requirement for Aztec unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not aztecCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Aztec
    local boss = getBossInLevel(2)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function factoryBossLogic()
    -- Check if player has the required kong for Factory (level 3)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(3) then
        return false
    end
    
    -- Check the TNS requirement for Factory
    if not_has("troff_n_scoff_skips") and not has("tns3") then
        return false
    end
    
    -- Check CB requirement for Factory unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not factoryCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Factory
    local boss = getBossInLevel(3)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function galleonBossLogic()
    -- Check if player has the required kong for Galleon (level 4)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(4) then
        return false
    end
    
    -- Check the TNS requirement for Galleon
    if not_has("troff_n_scoff_skips") and not has("tns4") then
        return false
    end
    
    -- Check CB requirement for Galleon unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not galleonCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Galleon
    local boss = getBossInLevel(4)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function forestBossLogic()
    -- Check if player has the required kong for Forest (level 5)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(5) then
        return false
    end
    
    -- Check the TNS requirement for Forest
    if not_has("troff_n_scoff_skips") and not has("tns5") then
        return false
    end
    
    -- Check CB requirement for Forest unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not forestCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Forest
    local boss = getBossInLevel(5)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function cavesBossLogic()
    -- Check if player has the required kong for Caves (level 6)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(6) then
        return false
    end
    
    -- Check the TNS requirement for Caves
    if not_has("troff_n_scoff_skips") and not has("tns6") then
        return false
    end
    
    -- Check CB requirement for Caves unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not cavesCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Caves
    local boss = getBossInLevel(6)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

function castleBossLogic()
    -- Check if player has the required kong for Castle (level 7)
    if not has("troff_n_scoff_skips") and not hasKongForBoss(7) then
        return false
    end
    
    -- Check the TNS requirement for Castle
    if not_has("troff_n_scoff_skips") and not has("tns7") then
        return false
    end
    
    -- Check CB requirement for Castle unless TNS skips are enabled
    if not_has("troff_n_scoff_skips") and not castleCBTotal() then
        return false
    end
    
    -- Get the boss assigned to Castle
    local boss = getBossInLevel(7)
    if not boss then
        return false
    end
    
    -- Check boss-specific requirements
    local requirements = {
        army1 = function() return has("barrel") end,
        doga1 = function() return has("barrel") end,
        jack = function() return has("slam") and twirl() end,
        puff = function() return true end,
        doga2 = function() return has("barrel") and hunky() end,
        army2 = function() return has("barrel") end,
        kutout = function() return true end,
        dkphase = function() return has("climb") and blast() end,
        diddyphase = function() return rocket() and peanuts() end,
        lankyphase = function() return has("barrel") and trombone() end,
        tinyphase = function() return mini() and feather() end,
        chunkyphase = function() return hunky() and gone() and punch() end
    }
    
    return requirements[boss]()
end

ScriptHost:AddWatchForCode("openlobbies", "openlobbies", toggleLevelOrder)
ScriptHost:AddWatchForCode("number2", "k1", toggleLevelOrder)
ScriptHost:AddWatchForCode("number3", "k2", toggleLevelOrder)
ScriptHost:AddWatchForCode("number4_dive", "dive", toggleLevelOrder)
ScriptHost:AddWatchForCode("number5", "k4", toggleLevelOrder)
ScriptHost:AddWatchForCode("number67", "k5", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8", "k6", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8_k6", "k6", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8_k7", "k7", toggleLevelOrder)