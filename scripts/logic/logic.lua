ScriptHost:LoadScript("scripts/logic/medallogic.lua")
ScriptHost:LoadScript("scripts/logic/logichelper.lua")

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
    return coconut() or grape() or feather()
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
    return trombone() and (rocket() or balloon())
end

function height()
    return balloon() or has("climb")
end

function pastCabinIsle()
    return has("k4") and peanuts() and ((rocket() and has("barrel") and has("chunky") and trombone()) or twirl() or has("donkey"))
end

function canBeatSpider()
    if not_has("dusk") then
        return punch() and mini() and canChangeTime()
    elseif has("dusk") then
        return punch() and canChangeTime()
    end
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
    return has("slam") and (coconut() or grape() or peanuts() or feather() or pineapple() or bongos() or guitar() or trombone() or sax() or triangle())
end

function lighthousePlatform()
    if raisedWater() then
        return AccessibilityLevel.Normal
    elseif has("lanky") or has("chunky") then
        return AccessibilityLevel.SequenceBreak
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
    if coconutCage() and coconut() and has("barrel") and japesSlam() and has("chunky") and has("climb") then
        return AccessibilityLevel.SequenceBreak
    elseif coconutCage() and coconut() and has("barrel") and japesSlam() and has("chunky") and ostand() then
        return AccessibilityLevel.SequenceBreak
    end
end

function japesDiddyTimed()
    if coconutCage() and japesSlam() and has("climb") and coconut() and has("diddy") then
        return AccessibilityLevel.SequenceBreak
    elseif coconutCage() and coconut() and japesSlam() and ostand() and has("diddy") then
        return AccessibilityLevel.SequenceBreak
    end
end

function japesLankyTimed()
    if coconutCage() and japesSlam() and has("climb") and coconut() and has("lanky") then
        return AccessibilityLevel.SequenceBreak
    elseif coconutCage() and coconut() and japesSlam() and ostand() and has("lanky") then
        return AccessibilityLevel.SequenceBreak
    end
end

function trash()
    if mini() and (sax() or ((feather() or coconut() or peanuts() or grape() or pineapple()) and has("homing")) or bongos() or guitar() or trombone() or triangle()) then
        return AccessibilityLevel.Normal
    elseif mini() and (feather() or coconut() or peanuts() or grape() or pineapple()) then
        return AccessibilityLevel.SequenceBreak
    end
end

function dkCabin()
    if bongos() and ((coconut() or peanuts() or grape() or feather() or pineapple()) and has("homing")) then
        return AccessibilityLevel.Normal
    elseif bongos() and (coconut() or peanuts() or grape() or feather() or pineapple()) then
        return AccessibilityLevel.SequenceBreak
    end
end

function lankyAttic()
    if has("lanky") and nightTime() and forestSlam() and (balloon() or has("climb")) and ((coconut() or peanuts() or grape() or feather() or pineapple()) and has("homing")) then
        return AccessibilityLevel.Normal
    elseif has("lanky") and nightTime() and forestSlam() and (balloon() or has("climb")) and (coconut() or peanuts() or grape() or feather() or pineapple()) then
        return AccessibilityLevel.SequenceBreak

    end
end

function ap()
    return AccessibilityLevel.SequenceBreak
end

-- Barriers

function coconutCage()
    if has("japes_coconut_gates") then
        return AccessibilityLevel.Normal
    elseif has("climb") then
        return AccessibilityLevel.Normal
    elseif ostand() then
        return AccessibilityLevel.SequenceBreak
    end
end

function shellhive()
    local in_coconut = coconutCage()
    if has("japes_shellhive_gate") then
        return in_coconut
    else
        return feather() and in_coconut
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
    elseif guitar() and has("climb") and ((has("vine")) or rocket()) then
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
    local in_testing = testing()
    if has("factory_production_room") then
        return in_testing
    else
        return coconut() and grab() and in_testing
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
        return coconut()
    end
end

function shipyard()
    if has("galleon_shipyard_area_gate") then
        return true
    else
        return peanuts()
    end
end

function seasick()
    local in_lighthouse = lighthouse()
    if has("galleon_seasick_ship") then
        return in_lighthouse
    else
        return has("climb") and galleonSlam() and grab() and in_lighthouse
    end
end

function treasure()
    local in_shipyard = shipyard()
    if has("galleon_treasure_room") then
        return in_shipyard and AccessibilityLevel.Normal
    elseif raisedWater() then
        return in_shipyard and has("lanky") and AccessibilityLevel.Normal
    else
        return in_shipyard and has("lanky") and AccessibilityLevel.SequenceBreak
    end
end

function greenTunnel()
    if has("forest_green_tunnel") then
        return true
    else
        return feather() and pineapple()
    end
end

function greenTunnelFeather()
    if has("forest_green_tunnel") then
        return true
    else
        return feather()
    end
end

function yellowTunnel()
    if has("forest_yellow_tunnel") then
        return true
    else
        return grape()
    end
end

function igloo()
    if has("caves_igloo_pads") then
        return true
    else
        return rocket()
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

function dkHelm()
    return hasHelm("helmdk")
end

function diddyHelm()
    return hasHelm("helmdiddy")
end

function lankyHelm()
    return hasHelm("helmlanky")
end

function tinyHelm()
    return hasHelm("helmtiny")
end

function chunkyHelm()
    return hasHelm("helmchunky")
end

function endOfHelm()
    local helmOrder = {
        {kong = "helmdk", check = bongos},
        {kong = "helmdiddy", check = function() return rocket() and guitar() end},
        {kong = "helmlanky", check = trombone},
        {kong = "helmtiny", check = sax},
        {kong = "helmchunky", check = triangle}
    }

    for _, helm in ipairs(helmOrder) do
        if hasHelm(helm.kong) and not helm.check() then
            return false
        end
    end

    return true
end

function toggleLevelOrder()
    if has("k1") then
        Tracker:FindObjectForCode("num2").Active = true
    elseif not_has("k1") then
        Tracker:FindObjectForCode("num2").Active = false
    end
    if has("k2") then
        Tracker:FindObjectForCode("num3").Active = true
    else
        Tracker:FindObjectForCode("num3").Active = false
    end
    if has("k2") and has("dive") then
        Tracker:FindObjectForCode("num4").Active = true
    else
        Tracker:FindObjectForCode("num4").Active = false
    end
    if has("k4") then
        Tracker:FindObjectForCode("num5").Active = true
    else
        Tracker:FindObjectForCode("num5").Active = false
    end
    if has("k5") then
        Tracker:FindObjectForCode("num6").Active = true
        Tracker:FindObjectForCode("num7").Active = true
    else
        Tracker:FindObjectForCode("num6").Active = false
        Tracker:FindObjectForCode("num7").Active = false
    end
    if has("k6") and has("k7") then
        Tracker:FindObjectForCode("num8").Active = true
    else
        Tracker:FindObjectForCode("num8").Active = false
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

function levelBossLogic()
    local bossOrder = {
        {boss = "army1", check = function() return has("barrel") end},
        {boss = "doga1", check = function() return has("barrel") end},
        {boss = "jack", check = function () return has("slam") and twirl() end},
        {boss = "puff", check = function() return true end},
        {boss = "doga2", check = function() return has("barrel") and hunky() end},
        {boss = "army2", check = function() return has("barrel") end},
        {boss = "kutout", check = function() return true end}
    }

    for _, boss in ipairs(bossOrder) do
        if hasBoss(boss.boss) and not boss.check() then
            return false
        end
    end
    return true
end


ScriptHost:AddWatchForCode("number2", "k1", toggleLevelOrder)
ScriptHost:AddWatchForCode("number3", "k2", toggleLevelOrder)
ScriptHost:AddWatchForCode("number4_dive", "dive", toggleLevelOrder)
ScriptHost:AddWatchForCode("number5", "k4", toggleLevelOrder)
ScriptHost:AddWatchForCode("number67", "k5", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8", "k6", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8_k6", "k6", toggleLevelOrder)
ScriptHost:AddWatchForCode("number8_k7", "k7", toggleLevelOrder)