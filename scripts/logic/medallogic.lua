-- Medal Logic

-- Helper function to convert AccessibilityLevel to boolean
function accessible(func)
    local result = func
    if type(result) == "function" then
        result = result()
    end
    -- Convert AccessibilityLevel to boolean: Normal is accessible, Sequence Break and None are not
    if result == AccessibilityLevel.Normal then
        return true
    elseif result == AccessibilityLevel.SequenceBreak or result == AccessibilityLevel.None then
        return false
    else
        -- If it's already a boolean or other value, return it as-is
        return result
    end
end

function japesDKMedal()

    if not_has("donkey") then
        return false
    end
    local cb_total = 10 -- W3
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if coconut() and (has("climb") or (accessible(avp) and ostand())) then -- By Snide
        cb_total = cb_total + 10
    end
    if has("climb") then -- Hilltop
        cb_total = cb_total + 15
    end
    if has("climb") or (ostand() and accessible(avp)) then -- Between Snide and Diddy Cage
        cb_total = cb_total + 6
    end
    if coconut() then -- Boulder
        cb_total = cb_total + 10
    end
    if coconut() and accessible(coconutCage) then -- Front of Cranky
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) and canActivateJapesRambi() then -- Behind Rambi Gate and Breakable Hutt
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) then -- Path to Cranky
        cb_total = cb_total + 9
    end
    if  has("climb") and (has("vine") or accessible(avp)) then -- Start
        cb_total = cb_total + 5
    end
    if (has("climb") and has("vine")) or (accessible(avp) and (ostand() or has("climb"))) then -- TnS Alcove
        cb_total = cb_total + 5
    end
    if blast() and has("climb") and (moonkicks() or (has("vine") and (has("lanky") or has("donkey") or has("diddy")))) then -- Blast Course
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function japesDiddyMedal()

    if not_has("diddy") then
        return false
    end
    local DiddyMine = peanuts() and (has("climb") or (accessible(avp) and ostand()))
    local cb_total = 5 -- Start
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("dive") then -- Underwater
        cb_total = cb_total + 10
    end
    if has("climb") then -- Trees
        cb_total = cb_total + 20
    end
    if has("climb") or (ostand() and accessible(avp)) then -- Around Mountain
        cb_total = cb_total + 7
    end
    if canActivateJapesDiddyCave() and peanuts() then -- Diddy Cave Balloon
        cb_total = cb_total + 10
    end
    if DiddyMine then -- Stream and Mound
        cb_total = cb_total + 10
    end
    if DiddyMine and japesSlam() then -- Conveyor
        cb_total = cb_total + 5
    end
    if DiddyMine and japesSlam() and (charge() or accessible(avp)) then -- Inside Minecart
        cb_total = cb_total + 5
    end
    if DiddyMine and peanuts() and japesSlam() then -- Conveyor Balloon
        cb_total = cb_total + 10
    end
    if (has("climb") or (ostand() and accessible(avp))) and (peanuts() or moonkicks()) then -- Top of Mountain
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) then -- Diddy Kasplat
        cb_total = cb_total + 3
    end
    if accessible(coconutCage) and canActivateJapesRambi() then -- Breakable Hutt
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function japesLankyMedal()

    if not_has("lanky") then
        return false
    end
    local cb_total = 1 -- First CB of Painting Slope
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("dive") then -- Underwater
        cb_total = cb_total + 5
    end
    if canActivateJapesDiddyCave() and grape() then
        cb_total = cb_total + 5
    end
    if has("climb") then -- Snide Treetop
        cb_total = cb_total + 5
    end
    if has("climb") or (ostand() and accessible(avp)) then -- Snide
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and grape() then -- 10 by Kasplat 10 by Hutt
        cb_total = cb_total + 20
    end
    if ostand() or twirl() or moonkicks() then -- Painting Slope
        cb_total = cb_total + 2
    end
    if (ostand() or twirl() or moonkicks()) and canActivateJapesPainting() then -- Bunches in Painting
        cb_total = cb_total + 20
    end
    if (ostand() or twirl() or moonkicks()) and canActivateJapesPainting() and grape() then -- Balloon in Painting
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) then -- 1 to Kasplat 2 on slopes
        cb_total = cb_total + 3
    end
    if accessible(coconutCage) and (ostand() or has("slope_resets")) then -- Bonus Slopes
        cb_total = cb_total + 9
    end
    if accessible(coconutCage) and has("climb") then -- Cranky Treetop
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and canActivateJapesRambi() then -- 5 in hutt 5 in rambi cave
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function japesTinyMedal()

    if not_has("tiny") then
        return false
    end
    local cb_total = 5 -- First Tunnel
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("climb") and accessible(coconutCage) then -- Cranky Treetop
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) then -- Before Rambi Gate
        cb_total = cb_total + 2
    end
    if accessible(coconutCage) and canActivateJapesRambi() then
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and feather() then -- Hutt Balloon
        cb_total = cb_total + 10
    end
    if accessible(shellhive) then -- Front of Beehive
        cb_total = cb_total + 5
    end
    if accessible(shellhive) and mini() then -- Shellhive Logs
        cb_total = cb_total + 30
    end
    if canActivateJapesDiddyCave() and feather() then -- Diddy Cave Tiny Bonus
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and canActivateJapesRambi() then -- Behind Rambi Gate
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and canActivateJapesRambi() and feather() then -- Fairy Pool Balloon
        cb_total = cb_total + 10
    end
    if accessible(shellhive) and mini() and japesSlam() and (canChangeTime() or has("orange")) then -- Third Beehive Room
        cb_total = cb_total + 8
    end
    if accessible(shellhive) and mini() and feather() then -- First Beehive Balloon
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function japesChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 5 -- Around Boulder
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("climb") or (ostand() and accessible(avp)) then -- Funky
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) then -- Path to Shellhive
        cb_total = cb_total + 10
    end
    if accessible(coconutCage) and has("climb") then -- On Cranky
        cb_total = cb_total + 5
    end
    if accessible(shellhive) and has("climb") and hunky() then -- On Hunky Trees
        cb_total = cb_total + 20
    end
    if accessible(coconutCage) and canActivateJapesRambi() and has("barrel") then -- Rambi Boulder
        cb_total = cb_total + 5
    end
    if accessible(coconutCage) and canActivateJapesRambi() and pineapple() then -- Mother of all Loads
        cb_total = cb_total + 30
    end
    if (has("barrel") and has("slam")) or phaseswim() then -- Underground
        cb_total = cb_total + 15
    end
    return cb_total >= cb_amount
end

function aztecDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 3 -- Front of Llama Cage
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("climb") then -- Top of Oasis Trees
        cb_total = cb_total + 15
    end
    if coconut() and accessible(tunnelDoor) then -- 2 balloons in cranky 1 behind llama temple
        cb_total = cb_total + 30
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and canActivateAztecQuickSandSwitch() and strong() then -- Quicksand Tunnel
        cb_total = cb_total + 20
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() then -- Inside Llama Temple
        cb_total = cb_total + 15
    end
    if accessible(tunnelDoor) then -- 4 Near Llama Temple 3 Near Snide
        cb_total = cb_total + 7
    end
    if strong() and canActivateAztecBlueprintDoor() then -- In DK Kasplat Room
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function aztecDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 5 -- Bunch Front Tiny Temple
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if peanuts() then -- Balloon Front Tiny Temple
        cb_total = cb_total + 10
    end
    if canEnterTinyTemple() and aztecSlam() then --3 on tiny tiny tongue
        cb_total = cb_total + 3
    end
    if aztecSlam() and peanuts() and canEnterTinyTemple then -- 15 on tiny tongue
        cb_total = cb_total + 15
    end
    if peanuts() and has("dive") and templeIce() then -- 7 Underwater
        cb_total = cb_total + 7
    end
    if accessible(tunnelDoor) then -- 5 Behind Guitar Door 3 Near Rockets 3 GongSteps 4 5DTemple Steps
        cb_total = cb_total + 15
    end
    if (has("climb") or rocket()) and tunnelDoor() then -- Gong Tower Treetops
        cb_total = cb_total + 15
    end
    if accessible(tunnelDoor) and rocket() then -- 5 Sun Ring 5 top Llama Temple
        cb_total = cb_total + 10
    end
    if accessible(tunnelDoor) and peanuts() and accessible(aztec5DT) then -- Inside 5DT
        cb_total = cb_total + 10
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and canActivateAztecQuickSandSwitch() and (strong() or rocket()) and peanuts() then -- Balloon Inside Quicksand Cave
        cb_total = cb_total + 10
    end
    
    local result = cb_total >= cb_amount
    return result
end

function aztecLankyMedal()
    if not_has("lanky") then
        return false
    end
    local cb_total = 5 -- Beginning
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if canEnterTinyTemple() and has("dive") and templeIce() then -- Vulture Room
        cb_total = cb_total + 14
    end
    if accessible(tunnelDoor) then -- By Cranky and Funky
        cb_total = cb_total + 10
    end
    if accessible(tunnelDoor) and (has("climb") or rocket()) then -- Treetops
        cb_total = cb_total + 25
    end
    if accessible(aztec5DT) and grape() then -- 5DT
        cb_total = cb_total + 10
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() then -- In Llama Temple
        cb_total = cb_total + 11
    end
    if (accessible(llamaSwitches) and canEnterLlamaTemple() and grape() and has("dive")) and (lankyFreeing() or phaseswim()) then -- Inside Lanky Freeing Room
        cb_total = cb_total + 20
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and has("vine") then -- Lanky Matching Room
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function aztecTinyMedal()
    if not_has("tiny") then
        return false
    end
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("medalamount")

    if canEnterTinyTemple() and templeIce() and has("dive") and (mini() or phaseswim()) then -- Inside Klaptrap Gauntlet
        cb_total = cb_total + 5
    end
    if canEnterTinyTemple() and templeIce() and has("dive") and feather() then -- Inside KONGs Room
        cb_total = cb_total + 20
    end
    if accessible(tunnelDoor) then -- All around Totem Area
        cb_total = cb_total + 25
    end
    if accessible(tunnelDoor) and (has("climb") or twirl() or rocket()) then -- 5DT Treetops
        cb_total = cb_total + 25
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and feather() then -- Outside Pedestals
        cb_total = cb_total + 10
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() then -- Before Pedestal Hole
        cb_total = cb_total + 3
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and mini() then -- Past Pedestal Hole
        cb_total = cb_total + 2
    end
    if accessible(llamaSwitches) and canEnterLlamaTemple() and mini() and aztecSlam() and (twirl() or accessible(avp)) then -- Pedestals
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function aztecChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 5 -- Beginning
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("dive") and templeIce() and canEnterTinyTemple() and pineapple() then -- Vulture Room Balloon
        cb_total = cb_total + 10
    end
    if pineapple() then -- Vase Room
        cb_total = cb_total + 20
    end
    if canEnterTinyTemple() then -- Tiny Temple
        cb_total = cb_total + 29
    end
    if accessible(tunnelDoor) then -- All Around Totem
        cb_total = cb_total + 16
    end
    if pineapple() and accessible(aztec5DT) then -- 5DT
        cb_total = cb_total + 20
    end
    return cb_total >= cb_amount
end

function factoryDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 15 -- 11 to Prod, 4 to storage
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if testing() and has("climb") then -- To Numbers Game
        cb_total = cb_total + 5
    end
    if testing() and has("climb") and coconut() then -- Balloon In Number Game and Balloon by Magic Hatch
        cb_total = cb_total + 20
    end
    if powerHutPlatform() and (coconut() or moonkicks()) then -- Power Hutt
        cb_total = cb_total + 15
    end
    if coconut() then -- Duo Shop Balloons
        cb_total = cb_total + 10
    end
    if blast() then -- Self Explanatory
        cb_total = cb_total + 20
    end
    if accessible(production) and strong() then -- Crusher Room
        cb_total = cb_total + 15
    end
    return cb_total >= cb_amount
end

function factoryDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 12 -- Base of Prod
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if testing() and has("climb") then -- Funkys
        cb_total = cb_total + 8
    end
    if has("climb") then -- Arcade Tunnel
        cb_total = cb_total + 10
    end
    if accessible(production) and has("climb") then -- Production Cylinder
        cb_total = cb_total + 15
    end
    if (spring() or moontail()) and has("climb") and testing() then -- Block Tower
        cb_total = cb_total + 25
    end
    if guitar() and peanuts() and testing() and has("climb") then -- Pincode Balloons
        cb_total = cb_total + 30
    end
    return cb_total >= cb_amount
end

function factoryLankyMedal()
    if not_has("lanky") then
        return false
    end
    local intest = testing() and has("climb")
    local cb_total = 11 -- 5 warp 2 5 boxes, 1 pipe
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if intest then -- R&D
        cb_total = cb_total + 15
    end
    if intest and trombone() and grape() then -- Piano Room
        cb_total = cb_total + 10
    end
    if ostand() or has("slope_resets") then -- Pipe
        cb_total = cb_total + 4
    end
    if accessible(production) and grape() then -- Crusher Balloon
        cb_total = cb_total + 10
    end
    if accessible(production) and has("climb") then -- 15 Prod Stairs 5 ostand pipe
        cb_total = cb_total + 20
    end
    if accessible(production) and has("climb") and ostand() then -- Ostand Pipe
        cb_total = cb_total + 20
    end
    if accessible(production) and has("climb") and grape() then -- Prod T&S Pipe
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function factoryTinyMedal()
    if not_has("tiny") then
        return false
    end
    local intest = testing() and has("climb")
    local cb_total = 13 -- 3 to testing 10 Mid Hatch
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if intest then -- 7 to testing 5 Mini Tunnel 10 to car race
        cb_total = cb_total + 22
    end
    if intest and mini() then -- BHDW Bunch
        cb_total = cb_total + 5
    end
    if intest and feather() then -- 10 Snide 10 Funky
        cb_total = cb_total + 20
    end
    if has("climb") then -- Arcade Tunnel
        cb_total = cb_total + 5
    end
    if accessible(production) and feather() then -- Mid Prod Balloon
        cb_total = cb_total + 10
    end
    if accessible(production) and has("climb") then -- Prod Conveyors
        cb_total = cb_total + 20
    end
    if accessible(production) and has("climb") and twirl() then -- Past Twirl Bonus
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function factoryChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 20 -- 5 Warp 1, 10 Down Pipe, 5 Warp 1
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if pineapple() then -- Around Hatch
        cb_total = cb_total + 10
    end
    if testing() and has("climb") then -- Snide Warp 3
        cb_total = cb_total + 5
    end
    if accessible(production) and has("climb") then -- Spinning Core
        cb_total = cb_total + 20
    end
    if punch() then -- Dark Room Platforms
        cb_total = cb_total + 15
    end
    if pineapple() and testing() and has("climb") then -- Above Snide Room
        cb_total = cb_total + 10
    end
    if punch() and triangle() and testing() and has("climb") then -- Chunky R&D
        cb_total = cb_total + 10
    end
    if pineapple() and punch() and triangle() and testing() and has("climb") then -- Chunky R&D
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

-- Galleon

function galleonDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if coconut() then -- Chest
        cb_total = cb_total + 10
    end
    if lighthouse() and accessible(lighthousePlatform) and coconut() then -- Lighthouse Platform Balloon
        cb_total = cb_total + 10
    end
    if lighthouse() and (enguarde() or phaseswim()) then -- Enguarde Gate
        cb_total = cb_total + 10
    end
    if lighthouse() and accessible(lighthousePlatform) and blast() then -- Blast Course
        cb_total = cb_total + 15
    end
    if lighthouse() and accessible(lighthousePlatform) and galleonSlam() and has("climb") and coconut() then -- Lighthouse Balloon
        cb_total = cb_total + 10
    end
    if lighthouse() and accessible(lighthousePlatform) and galleonSlam() and has("climb") then -- Lighthouse Bunches
        cb_total = cb_total + 20
    end
    if accessible(shipyard) and has("dive") then -- Shipwreck
        cb_total = cb_total + 15
    end
    if accessible(shipyard) and has("dive") and (bongos() or phaseswim()) then -- DK 5DS
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function galleonDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 10 -- To Cranky
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if lighthouse() and accessible(lighthousePlatform) and peanuts() then -- Seal Platform
        cb_total = cb_total + 10
    end
    if lighthouse() and accessible(lighthousePlatform) and rocket() then -- Top of Lighthouse
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and peanuts() then -- Cactus Balloon
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") then -- 20 mechfish grate 6 to gold tower 10 2DS
        cb_total = cb_total + 36
    end
    if accessible(treasure) and peanuts() and has("dive") then -- Treasure Balloon
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") and ((guitar() and loweredWater()) or phaseswim()) then -- Diddy 5DS
        cb_total = cb_total + 14
    end
    return cb_total >= cb_amount
end

function galleonLankyMedal()
    if not_has("lanky") then
        return false
    end
    local cb_total = 5 -- To Warp 1
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if grape() and punch() then -- Arena Balloons
        cb_total = cb_total + 20
    end
    if lighthouse() and (enguarde() or phaseswim()) then -- Lighthouse Chests
        cb_total = cb_total + 20
    end
    if lighthouse() and has("dive") then -- Enguarde
        cb_total = cb_total + 5
    end
    if accessible(shipyard) then -- Cactus
        cb_total = cb_total + 5
    end
    if accessible(shipyard) and grape() then -- Shipyard balloon
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") then -- Enguarde
        cb_total = cb_total + 5
    end
    if accessible(treasure) and has("dive") and ((raisedWater() and balloon()) or (enguarde() and accessible(avp)) or moonkicks() and balloon()) then -- Gold Tower
        cb_total = cb_total + 4
    end
    if accessible(treasure) and has("dive") and ((raisedWater()) or (enguarde() and accessible(avp)) or moonkicks()) then -- Gold Tower Bottom
        cb_total = cb_total + 1
    end
    if accessible(shipyard) and has("dive") and (galleonSlam() or phaseswim()) then -- Lanky 2DS
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") and ((trombone() and loweredWater()) or phaseswim()) then -- Lanky 5DS
        cb_total = cb_total + 15
    end
    return cb_total >= cb_amount
end

function galleonTinyMedal()
    if not_has("tiny") then
        return false
    end
    local cb_total = 9 -- Galleon Start
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("vine") or moonkicks() then -- Past Vines
        cb_total = cb_total + 8
    end
    if (canActivateGalleonCannonGame() or (phaseswim() and raisedWater())) and canGetOnCannonGamePlatform() then -- Cannon Game
        cb_total = cb_total + 15
    end
    if lighthouse() and feather() and loweredWater() then -- KEVIN
        cb_total = cb_total + 10
    end
    if lighthouse() and (raisedWater() or (has("lanky") or has("chunky") and accessible(avp))) then -- Snide
        cb_total = cb_total + 5
    end
    if lighthouse() and feather() and (raisedWater() or (has("lanky") or has("chunky") and accessible(avp))) then -- Snide Balloon
        cb_total = cb_total + 10
    end
    if accessible(treasure) and has("dive") then -- Hype Chest Entrance
        cb_total = cb_total + 5
    end
    if accessible(treasure) and feather() and has("dive") then -- Gold Tower Balloon
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") and (galleonSlam() or phaseswim()) then -- Tiny 2DS
        cb_total = cb_total + 10
    end
    if accessible(shipyard) and has("dive") and (sax() or phaseswim()) then -- Tiny 5DS
        cb_total = cb_total + 18
    end
    return cb_total >= cb_amount
end

function galleonChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 12 -- Galleon Start
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("vine") or moonkicks() then -- Past Vines
        cb_total = cb_total + 3
    end
    if pineapple() and (canActivateGalleonCannonGame() or (phaseswim() and raisedWater())) and canGetOnCannonGamePlatform() then -- Cannon Game Balloon
        cb_total = cb_total + 10
    end
    if lighthouse() and has("dive") then -- Base of Lighthouse
        cb_total = cb_total + 10
    end
    if accessible(seasick) and has("slam") then -- Seasick
        cb_total = cb_total + 20
    end
    if accessible(seasick) and has("slam") and punch() then -- Seasick past gate
        cb_total = cb_total + 5
    end
    if accessible(shipyard) and raisedWater() then -- Warp 2 Bunch
        cb_total = cb_total + 5
    end
    if accessible(shipyard) and pineapple() then -- Cactus and Warp 2 Balloon
        cb_total = cb_total + 20
    end
    if accessible(shipyard) and has("dive") then -- Shipwreck
        cb_total = cb_total + 15
    end
    return cb_total >= cb_amount
end

function forestDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 15 -- 5 blue 5 pink 5 warp 5
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if coconut() and peanuts() and grape() and feather() and pineapple() then -- CoL Cannons
        cb_total = cb_total + 15
    end
    if canClimbMushroom() then -- 2 blast ladder 5 upper warp 5
        cb_total = cb_total + 7
    end
    if lowerMushroomExterior() then -- Tiny Kasplat Platform
        cb_total = cb_total + 13
    end
    if canClimbMushroom() and blast() then -- Blast
        cb_total = cb_total + 10
    end
    if coconut() then -- Behind Dark Rafters
        cb_total = cb_total + 10
    end
    if dayTime() and has("slam") then -- Mills Box
        cb_total = cb_total + 5
    end
    if dayTime() and forestSlam() and coconut() then -- Behind Grab Gate
        cb_total = cb_total + 10
    end
    if nightTime() or phaseswim() then -- Path to Thornvine
        cb_total = cb_total + 5
    end
    if (nightTime() or phaseswim()) and strong() then -- Thornvine Switch
        cb_total = cb_total + 5
    end
    if (nightTime() and strong() and forestSlam()) or phaseswim() and has("slam") then -- Inside Thornvine
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function forestDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 28 -- Scattered throughout Forest
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if canClimbMushroom() then -- 7 Diddy Kasplat 10 Top Mush
        cb_total = cb_total + 17
    end
    if yellowTunnel() then -- Around Owl Tree
        cb_total = cb_total + 15
    end
    if yellowTunnel() and rocket() then -- Top of Tree
        cb_total = cb_total + 5
    end
    if peanuts() and (dayTime() or accessible(avp)) then -- Snide
        cb_total = cb_total + 10
    end
    if peanuts() and forestSlam() and has("climb") and nightTime() then -- Winch Room
        cb_total = cb_total + 10
    end
    if spring() or moontail() then -- Dark Rafters Entrance
        cb_total = cb_total + 5
    end
    if nightTime() and (spring() or moontail()) and guitar() and nightTime() then -- Inside Dark Rafters
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function forestLankyMedal()
    if not_has("lanky") then
        return false
    end
    local cb_total = 21 -- Scattered
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    if has("climb") then -- Winch Rope to Very Top of Mill
        cb_total = cb_total + 2
    end
    if has("climb") or balloon() then -- Top of Mill
        cb_total = cb_total + 9
    end
    if nightTime() and (has("climb") or balloon()) then -- Dark Attic
        cb_total = cb_total + 10
    end
    if grape() then -- Lower Mushroom
        cb_total = cb_total + 10
    end
    if grape() and canClimbMushroom() then -- Top of Mushroom Interior
        cb_total = cb_total + 10
    end
    if topOfMushroom() then -- Very Top of Mushroom
        cb_total = cb_total + 5
    end
    if topOfMushroom() and forestSlam() then -- 10 Inside Bounce 5 Inside Slam
        cb_total = cb_total + 15
    end
    if yellowTunnel() then -- Around Owl Tree Area
        cb_total = cb_total + 18
    end
    return cb_total >= cb_amount
end

function forestTinyMedal()
    if not_has("tiny") then
        return false
    end
    local cb_total = 10
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if greenTunnelFeather() then -- Past Feather Tunnel
        cb_total = cb_total + 4
    end
    if lowerMushroomExterior() and feather() then -- By Tiny Kasplat
        cb_total = cb_total + 10
    end
    if yellowTunnel() then -- Around Anthill
        cb_total = cb_total + 8
    end
    if yellowTunnel() and sax() and mini() then -- Top of Anthill
        cb_total = cb_total + 5
    end
    if has("dive") then -- Mills Underwater
        cb_total = cb_total + 17
    end
    if dayTime() and (punch() or mini()) then -- Inside Rear Mill
        cb_total = cb_total + 15
    end
    if dayTime() and punch() then -- Inside Rear Mill Punch Box
        cb_total = cb_total + 5
    end
    if feather() and (nightTime() or phaseswim()) then -- Behind Thornvine
        cb_total = cb_total + 10
    end
    if greenTunnel() then -- Past Pineapple Tunnel
        cb_total = cb_total + 1
    end
    if greenTunnel() and has("climb") then -- Top of Beanstalk Mushrooms
        cb_total = cb_total + 15
    end
    return cb_total >= cb_amount
end

function forestChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 10
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if lowerMushroomExterior() then
        cb_total = cb_total + 16
    end
    if canClimbMushroom() then
        cb_total = cb_total + 25
    end
    if (canClimbMushroom() and has("vine")) or (canClimbMushroom() and nightTime()) then
        cb_total = cb_total + 5
    end
    if canClimbMushroom() and pineapple() then -- All Around Mushroom Area ^^^^^
        cb_total = cb_total + 10
    end
    if canClimbMushroom() and forestSlam() then -- Face Matching
        cb_total = cb_total + 5
    end
    if canClimbMushroom() and forestSlam() and pineapple() then -- Face Matching Balloon
        cb_total = cb_total + 10
    end
    if dayTime() and punch() then -- Inside Rear Mill Box
        cb_total = cb_total + 5
    end
    if greenTunnel() then -- Around Beanstalk Area
        cb_total = cb_total + 14
    end
    return cb_total >= cb_amount
end

function cavesDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 25 -- Around Caves
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if coconut() and (cavesIce() or phaseswim()) then -- GG Room
        cb_total = cb_total + 10
    end
    if blast() then -- Self Explanatory
        cb_total = cb_total + 20
    end
    if cavesIce() then -- Boulder Room
        cb_total = cb_total + 3
    end
    if cavesIce() and coconut() then -- Boulder Room Balloon
        cb_total = cb_total + 10
    end
    if dk5DI() and igloo() then -- DK 5DI
        cb_total = cb_total + 7
    end
    if igloo() and beginningDK5DI() then -- Beginning of DK 5DI
        cb_total = cb_total + 5
    end
    if coconut() and igloo() and beginningDK5DI() then -- ^^
        cb_total = cb_total + 10
    end
    if bongos() then -- DK Cabins
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function cavesDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 5 -- Near Funky
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if mini() and twirl() then -- Kasplat Cave
        cb_total = cb_total + 10
    end
    if rocket() then -- 20 Around Igloo 5 Below Jetpack Bonus
        cb_total = cb_total + 25
    end
    if rocket() or accessible(avp) then -- Warp 4 Pillar
        cb_total = cb_total + 5
    end
    if peanuts() then -- Warp 4 Pillar And Above Cabins
        cb_total = cb_total + 20
    end
    if igloo() and beginningDiddy5DI() and peanuts() then -- Inside Diddy 5DI
        cb_total = cb_total + 10
    end
    if guitar() and (spring() or moontail()) and rocket() then -- Upper 5DC
        cb_total = cb_total + 15
    end
    if guitar() then -- Lower 5DC
        cb_total = cb_total + 5
    end
    if guitar() and (rocket() or accessible(avp)) then -- Lower 5DC Platforms
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function cavesLankyMedal()
    if not_has("lanky") then
        return false
    end
    local cb_total = 15 -- 5 Beginning 10 cabin lake
    local cb_amount = Tracker:ProviderCountForCode("medalamount")    
    if (balloon() or accessible(avp)) and cavesSlam() then -- Beetle Race Entrance
        cb_total = cb_total + 5
    end
    if balloon() then -- Cranky
        cb_total = cb_total + 15
    end
    if rocket() or (balloon() and accessible(avp)) then -- Lanky Kasplat
        cb_total = cb_total + 20
    end
    if cavesSlam() and grape() then -- tomato balloon
        cb_total = cb_total + 10
    end
    if beginningLanky5DI() and igloo() then -- Bottom Lanky 5DI
        cb_total = cb_total + 1
    end
    if beginningLanky5DI() and igloo() and ((balloon() or accessible(avp))) then -- Lanky 5DI
        cb_total = cb_total + 4
    end
    if beginningLanky5DI() and igloo() and grape() then -- Lanky 5DI Balloon
        cb_total = cb_total + 10
    end
    if grape() then -- Waterfall Balloon
        cb_total = cb_total + 10
    end
    if rocket() or balloon() or moonkicks() then -- Sprint Cabin Roof
        cb_total = cb_total + 5
    end
    if canEnterSprintCabin() then -- Inside Sprint Cabin
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function cavesTinyMedal()
    if not_has("tiny") then
        return false
    end
    local cb_total = 15 -- 10 to Igloo 5 Warp 3
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if mini() then -- Inner Warp 3
        cb_total = cb_total + 5
    end
    if mini() and twirl() and feather() then -- Inside Blueprint Cave
        cb_total = cb_total + 10
    end
    if (mini() and port() and twirl()) or phaseswim() then -- Monkeyport Igloo
        cb_total = cb_total + 5
    end
    if port() and ((has("barrel") and hunky() and cavesIce()) or phaseswim()) then -- Giant Kosha
        cb_total = cb_total + 20
    end
    if beginningTiny5DI() and igloo() then -- Inside Tiny 5DI
        cb_total = cb_total + 5
    end
    if beginningTiny5DI() and igloo() and feather() then -- Tiny 5DI Balloon
        cb_total = cb_total + 10
    end
    if feather() then -- Tiny Kasplat
        cb_total = cb_total + 10
    end
    if sax() then -- Tiny 5DC
        cb_total = cb_total + 10
    end
    if sax() and feather() then -- Tiny 5DC Balloon
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function cavesChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 18 -- 10 Warp 2s 3 Bridge 5 boulder switch
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if has("barrel") or accessible(avp) then -- Inside Small Boulder
        cb_total = cb_total + 5
    end
    if cavesIce() then -- GG and Snide Room
        cb_total = cb_total + 11
    end
    if cavesIce() and has("barrel") then -- Inside Big Boulder Igloo
        cb_total = cb_total + 6
    end
    if cavesIce() and pineapple() then -- Snide Balloon
        cb_total = cb_total + 10
    end
    if cavesIce() and has("barrel") and hunky() then -- Inside Big Boulder
        cb_total = cb_total + 5
    end
    if (cavesIce() and hunky() and has("barrel")) or phaseswim() then -- Inside Transparent Igloo
        cb_total = cb_total + 5
    end
    if triangle() and gone() then -- Chunky 5DC
        cb_total = cb_total + 20
    end
    if igloo() and chunky5DI() and pineapple() then -- Chunky 5DI
        cb_total = cb_total + 10
    end
    if mini() and pineapple() then -- Warp Cave
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function castleDKMedal()
    if not_has("donkey") then
        return false
    end
    local cb_total = 50 -- Castle Climb
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if canEnterTree() and coconut() then -- Inside Tree
        cb_total = cb_total + 15
    end
    if castleSlam() then -- Library and Dungeon
        cb_total = cb_total + 10
    end
    if castleSlam() and strong() then -- Library Books
        cb_total = cb_total + 10
    end
    if cryptDoors() then -- Inside Crypt
        cb_total = cb_total + 5
    end
    if dkCryptDoors() and coconut() then -- Inside DK Crypt
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function castleDiddyMedal()
    if not_has("diddy") then
        return false
    end
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if cryptDoors() then -- Inside Crypt
        cb_total = cb_total + 5
    end
    if peanuts() then -- 10 Bridge 10 Crypt
        cb_total = cb_total + 20
    end
    if rocket() then -- 10 Top of Castle
        cb_total = cb_total + 10
    end
    if castleSlam() and rocket() then -- Inside Ballroom
        cb_total = cb_total + 15
    end
    if castleSlam() and peanuts() then -- 10 Ballroom 10 Dungeon
        cb_total = cb_total + 20
    end
    if punch() then -- Dungeon Gates
        cb_total = cb_total + 20
    end
    if charge() and peanuts() and diddyCryptDoors() then -- Diddy Crypt Coffins
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function castleLankyMedal()
    if not_has("lanky") then
        return false
    end
    local cb_total = 30 -- Lower Dungeon
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if castleSlam() then -- Greenhouse
        cb_total = cb_total + 30
    end
    if castleSlam() and grape() then -- Tower
        cb_total = cb_total + 20
    end
    if castleSlam() and grape() and trombone() and (balloon() or (twirl() and accessible(avp))) then -- Lanky Dungeon
        cb_total = cb_total + 10
    end
    if grape() and sprint() then -- Lanky Mausoleum
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end

function castleTinyMedal()
    if not_has("tiny") then
        return false
    end
    local cb_total = 50 -- Castle Climb
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if mini() then -- Trash
        cb_total = cb_total + 5
    end
    if has("diddy") and castleSlam() then -- Ballroom MP Pad
        cb_total = cb_total + 5
    end
    if has("diddy") and castleSlam() and port() then -- Behind Museum Glass
        cb_total = cb_total + 15
    end
    if has("diddy") and castleSlam() and port() and feather() then -- ^^ Balloon
        cb_total = cb_total + 10
    end
    if feather() then -- Funky
        cb_total = cb_total + 10
    end
    if mausoleumDoors() and (twirl() or accessible(avp)) then -- Green Goo Gap
        cb_total = cb_total + 5
    end
    return cb_total >= cb_amount
end

function castleChunkyMedal()
    if not_has("chunky") then
        return false
    end
    local cb_total = 30 -- Upper Dungeon
    local cb_amount = Tracker:ProviderCountForCode("medalamount")
    
    if canEnterTree() then -- Inside Tree
        cb_total = cb_total + 5
    end
    if canEnterTree() and punch() and pineapple() then -- Tree Balloon
        cb_total = cb_total + 10
    end
    if punch() and pineapple() then -- Shed Balloon and Dungeon Balloons
        cb_total = cb_total + 30
    end
    if castleSlam() and punch() and has("barrel") then -- Museum Boulder
        cb_total = cb_total + 5
    end
    if castleSlam() and pineapple() then -- Inside Museum
        cb_total = cb_total + 10
    end
    if chunkyCryptDoors() and punch() then -- Behind Chunky Crypt Coffins
        cb_total = cb_total + 10
    end
    return cb_total >= cb_amount
end