-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
ScriptHost:LoadScript("scripts/logic/medallogic.lua")

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
    return (rocket() or has("climb")) and ostand() or rocket()
end

function canClearGauntlet()
    return has("orange") or coconut() or peanuts() or grape() or feather() or pineapple() or bongos() or guitar() or trombone() or sax() or triangle()
end

function canEnterSprintCabin()
    return trombone() and (rocket() or balloon())
end

function raisedWater()
    local in_lighthouse = lighthouse()
    if has("waterraised") then
        return 1
    elseif has("waterlowered") then
        return has("dive") and in_lighthouse
    end
    return 0
end

function loweredWater()
    local in_lighthouse = lighthouse()
    if has("waterlowered") then
        return 1
    elseif has("waterraised") then
        return has("dive") and in_lighthouse
    end
    return 0
end

function dayTime()
    if has("daytime") or has("dusk") then
        return 1
    elseif has("nighttime") then
        return coconut() or peanuts() or grape() or feather() or pineapple()
    end
end

function nightTime()
    if has("nighttime") or has("dusk") then
        return 1
    elseif has("daytime") then
        return coconut() or peanuts() or grape() or feather() or pineapple()
    end
end

-- Barriers

function coconutCage()
    if has("coconutgate") then
        return true
    else
        return has("climb")
    end
end

function shellhive()
    if has("shellhive") then
        return true
    else
        return feather()
    end
end

function templeIce()
    if has("tinyice") then
        return true
    else
        return aztecSlam() and peanuts() and guitar()
    end
end

function tunnelDoor()
    if has("tunnels") then
        return true
    else
        return has("climb") and has("vine") and guitar()
    end
end

function aztec5DT()
    local in_tunnel = tunnelDoor()
    if has("5dt") then
        return in_tunnel
    else
        return rocket() and peanuts() and aztecSlam() and in_tunnel
    end
end

function llamaSwitches()
    local in_tunnel = tunnelDoor()
    if has("llama") then
        return in_tunnel
    else
        return blast() and in_tunnel
    end
end

function production()
    local in_testing = testing()
    if has("production") then
        return in_testing
    else
        return coconut() and grab() and in_testing
    end
end

function testing()
    if has("testing") then
        return true
    else
        return has("slam")
    end
end

function lighthouse()
    if has("lighthouse") then
        return true
    else
        return coconut()
    end
end

function shipyard()
    if has("shipyard") then
        return true
    else
        return peanuts()
    end
end

function seasick()
    local in_lighthouse = lighthouse()
    if has("seasick") then
        return in_lighthouse
    else
        return has("climb") and galleonSlam() and grab() and in_lighthouse
    end
end

function treasure()
    local in_shipyard = shipyard()
    if has("treasure") then
        return in_shipyard
    else
        return in_shipyard and has("lanky")
    end
end

function greenTunnel()
    if has("green") then
        return true
    else
        return feather() and pineapple()
    end
end

function greenTunnelFeather()
    if has("green") then
        return true
    else
        return feather()
    end
end

function yellowTunnel()
    if has("yellow") then
        return true
    else
        return grape()
    end
end

function igloo()
    if has("igloo") then
        return true
    else
        return rocket()
    end
end

function cavesIce()
    if has("ice") then
        return true
    else
        return punch()
    end
end

function dkCryptDoors()
    if has("cryptdoors") then
        return true
    else
        return coconut()
    end
end

function diddyCryptDoors()
    if has("cryptdoors") then
        return true
    else
        return peanuts()
    end
end

function chunkyCryptDoors()
    if has("cryptdoors") then
        return true
    else
        return pineapple()
    end
end

function cryptDoors()
    if has("cryptdoors") then
        return true
    else
        return coconut() or peanuts() or pineapple()
    end
end

function mausoleumDoors()
    if has("cryptDoors") then
        return true
    else
        return grape() or feather()
    end
end

-- Slam logic

function japesSlam()
    if has("greenslam")  and (has("l1_japes") or has("l2_japes") or has("l3_japes") or has("l4_japes")) then
      return 1
    end
    if has("blueslam") and (has("l5_japes") or has("l6_japes")) then
      return 1
    end
    if has("redslam") and has("l7_japes") then
      return 1
    end
    return 0
  end

  function aztecSlam()
    if has("greenslam") and (has("l1_aztec") or has("l2_aztec") or has("l3_aztec") or has("l4_aztec")) then
      return 1
    end
    if has("blueslam") and (has("l5_aztec") or has("l6_aztec")) then
      return 1
    end
    if has("redslam") and has("l7_aztec") then
      return 1
    end
    return 0
  end

  function factorySlam()
    if has("greenslam") and (has("l1_factory") or has("l2_factory") or has("l3_factory") or has("l4_factory")) then
      return 1
    end
    if has("blueslam") and (has("l5_factory") or has("l6_factory")) then
      return 1
    end
    if has("redslam") and has("l7_factory") then
      return 1
    end
    return 0
  end

  function galleonSlam()
    if has("greenslam") and (has("l1_galleon") or has("l2_galleon") or has("l3_galleon") or has("l4_galleon")) then
      return 1
    end
    if has("blueslam") and (has("l5_galleon") or has("l6_galleon")) then
      return 1
    end
    if has("redslam") and has("l7_galleon") then
      return 1
    end
    return 0
  end

  function forestSlam()
    if has("greenslam") and (has("l1_forest") or has("l2_forest") or has("l3_forest") or has("l4_forest")) then
      return 1
    end
    if has("blueslam") and (has("l5_forest") or has("l6_forest")) then
      return 1
    end
    if has("redslam") and has("l7_forest") then
      return 1
    end
    return 0
  end

  function cavesSlam()
  if has("greenslam") and (has("l1_caves") or has("l2_caves") or has("l3_caves") or has("l4_caves")) then
    return 1
  end
  if has("blueslam") and (has("l5_caves") or has("l6_caves")) then
    return 1
  end
  if has("redslam") and has("l7_caves") then
    return 1
  end
  return 0
end

function castleSlam()
    if has("greenslam") and (has("l1_castle") or has("l2_castle") or has("l3_castle") or has("l4_castle")) then
      return 1
    end
    if has("blueslam") and (has("l5_castle") or has("l6_castle")) then
      return 1
    end
    if has("redslam") and has("l7_castle") then
      return 1
    end
    return 0
end

  -- Level Entry

function canEnterJapes()
    if has("l1_japes") then
        return 1
    end
    if has("l2_japes") then
        return has("k1")
    end
    if has("l3_japes") then
        return has("k2")
    end
    if has("l4_japes") then
        return has("k2") and has("dive")
    end
    if has("l5_japes") then
        return has("k4")
    end
    if has("l6_japes") or has("l7_japes") then
        return has("k5")
    end
end

function canEnterAztec()
    if has("l1_aztec") then
        return 1
    end
    if has("l2_aztec") then
        return has("k1")
    end
    if has("l3_aztec") then
        return has("k2")
    end
    if has("l4_aztec") then
        return has("k2") and has("dive")
    end
    if has("l5_aztec") then
        return has("k4")
    end
    if has("l6_aztec") or has("l7_aztec") then
        return has("k5")
    end
end

function canEnterFactory()
    if has("l1_factory") then
        return 1
    end
    if has("l2_factory") then
        return has("k1")
    end
    if has("l3_factory") then
        return has("k2")
    end
    if has("l4_factory") then
        return has("k2") and has("dive")
    end
    if has("l5_factory") then
        return has("k4")
    end
    if has("l6_factory") or has("l7_factory") then
        return has("k5")
    end
  end

function canEnterGalleon()
    if has("l1_galleon") then
        return 1
    end
    if has("l2_galleon") then
        return has("k1")
    end
    if has("l3_galleon") then
        return has("k2")
    end
    if has("l4_galleon") then
        return has("k2") and has("dive")
    end
    if has("l5_galleon") then
        return has("k4")
    end
    if has("l6_galleon") or has("l7_galleon") then
        return has("k5")
    end
end

function canEnterForest()
    if has("l1_forest") then
        return 1
    end
    if has("l2_forest") then
        return has("k1")
    end
    if has("l3_forest") then
        return has("k2")
    end
    if has("l4_forest") then
        return has("k2") and has("dive")
    end
    if has("l5_forest") then
        return has("k4")
    end
    if has("l6_forest") or has("l7_forest") then
        return has("k5")
    end
end

function canEnterCaves()
    if has("l1_caves") then
        return 1
    end
    if has("l2_caves") then
        return has("k1")
    end
    if has("l3_caves") then
        return has("k2")
    end
    if has("l4_caves") then
        return has("k2") and has("dive")
    end
    if has("l5_caves") then
        return has("k4")
    end
    if has("l6_caves") or has("l7_caves") then
        return has("k5")
    end
end

function canEnterCastle()
    if has("l1_castle") then
        return 1
    end
    if has("l2_castle") then
        return has("k1")
    end
    if has("l3_castle") then
        return has("k2")
    end
    if has("l4_castle") then
        return has("k2") and has("dive")
    end
    if has("l5_castle") then
        return has("k4")
    end
    if has("l6_castle") or has("l7_castle") then
        return has("k5")
    end
end