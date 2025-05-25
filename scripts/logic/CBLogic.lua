function japesCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal1")
    
    if has("donkey") then
        cb_total = cb_total + 10
        
        if coconut() and has("climb") then
            cb_total = cb_total + 10
        end
        if has("climb") then
            cb_total = cb_total + 21
        end
        if coconut() then
            cb_total = cb_total + 10
        end
        if coconut() and coconutCage() then
            cb_total = cb_total + 20
        end
        if coconutCage() then
            cb_total = cb_total + 9
        end
        if has("vine") and has("climb") then
            cb_total = cb_total + 10
        end
        if has("vine") and has("climb") and blast() then
            cb_total = cb_total + 10
        end
    end
    
    if has("diddy") then
        cb_total = cb_total + 5
        
        if has("dive") then
            cb_total = cb_total + 10
        end
        if has("climb") then
            cb_total = cb_total + 27
        end
        if peanuts() then
            cb_total = cb_total + 10
        end
        if has("climb") and peanuts() then
            cb_total = cb_total + 20
        end
        if has("climb") and peanuts() and japesSlam() then
            cb_total = cb_total + 15
        end
        if has("climb") and peanuts() and japesSlam() and charge() then
            cb_total = cb_total + 5
        end
        if coconutCage() then
            cb_total = cb_total + 3
        end
        if coconutCage() and coconut() then
            cb_total = cb_total + 5
        end
    end
    
    if has("lanky") then
        cb_total = cb_total + 1
        
        if has("dive") then
            cb_total = cb_total + 5
        end
        if peanuts() and grape() then
            cb_total = cb_total + 5
        end
        if has("climb") then
            cb_total = cb_total + 10
        end
        if coconutCage() and grape() then
            cb_total = cb_total + 20
        end
        if ostand() or twirl() then
            cb_total = cb_total + 2
        end
        if (ostand() or twirl()) and canActivateJapesPainting() then
            cb_total = cb_total + 20
        end
        if (ostand() or twirl()) and canActivateJapesPainting() and grape() then
            cb_total = cb_total + 10
        end
        if coconutCage() then
            cb_total = cb_total + 3
        end
        if coconutCage() and ostand() then
            cb_total = cb_total + 9
        end
        if coconutCage() and has("climb") then
            cb_total = cb_total + 5
        end
        if coconutCage() and coconut() then
            cb_total = cb_total + 10
        end
    end
    
    if has("tiny") then
        cb_total = cb_total + 5
        
        if has("climb") then
            cb_total = cb_total + 5
        end
        if coconutCage() and canActivateJapesRambi() then
            cb_total = cb_total + 12
        end
        if coconutCage() and canActivateJapesRambi() and feather() then
            cb_total = cb_total + 10
        end
        if feather() then
            cb_total = cb_total + 10
        end
        if shellhive() then
            cb_total = cb_total + 5
        end
        if shellhive() and mini() then
            cb_total = cb_total + 38
        end
        if shellhive() and mini() and feather() then
            cb_total = cb_total + 10
        end
        if peanuts() and feather() then
            cb_total = cb_total + 5
        end
    end
    
    if has("chunky") then
        cb_total = cb_total + 15
        
        if has("climb") then
            cb_total = cb_total + 15
        end
        if coconutCage() and pineapple() and canActivateJapesRambi() then
            cb_total = cb_total + 30
        end
        if coconutCage() and canActivateJapesRambi() and has("barrel") then
            cb_total = cb_total + 5
        end
        if shellhive() and hunky() and has("climb") then
            cb_total = cb_total + 20
        end
        if has("barrel") and has("slam") then
            cb_total = cb_total + 15
        end
    end
        
    return cb_total >= cb_amount
end

function aztecCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal2")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 3
        
        if has("climb") then
            cb_total = cb_total + 15
        end
        if coconut() and tunnelDoor() then
            cb_total = cb_total + 30
        end
        if llamaSwitches() and canEnterLlamaTemple() and canActivateAztecQuickSandSwitch() and strong() then
            cb_total = cb_total + 20
        end
        if llamaSwitches() and canEnterLlamaTemple() then
            cb_total = cb_total + 15
        end
        if tunnelDoor() then
            cb_total = cb_total + 7
        end
        if strong() and canActivateAztecBlueprintDoor() then
            cb_total = cb_total + 10
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 5
        
        if peanuts() then
            cb_total = cb_total + 10
        end
        if canEnterTinyTemple() and aztecSlam() then
            cb_total = cb_total + 3
        end
        if aztecSlam() and peanuts() then
            cb_total = cb_total + 15
        end
        if peanuts() and has("dive") and templeIce() then
            cb_total = cb_total + 7
        end
        if tunnelDoor() then
            cb_total = cb_total + 15
        end
        if has("climb") or rocket() then
            cb_total = cb_total + 15
        end
        if tunnelDoor() and rocket() then
            cb_total = cb_total + 10
        end
        if tunnelDoor() and peanuts() and aztec5DT() then
            cb_total = cb_total + 10
        end
        if llamaSwitches() and canEnterLlamaTemple() and canActivateAztecQuickSandSwitch() and strong() and peanuts() then
            cb_total = cb_total + 10
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 5
        
        if tunnelDoor() then
            cb_total = cb_total + 10
        end
        if tunnelDoor() and (has("climb") or rocket()) then
            cb_total = cb_total + 25
        end
        if aztec5DT() and grape() then
            cb_total = cb_total + 10
        end
        if llamaSwitches() and canEnterLlamaTemple() and grape() then
            cb_total = cb_total + 25
        end
        if grape() and has("dive") and templeIce() then
            cb_total = cb_total + 14
        end
        if canEnterLlamaTemple() and llamaSwitches() then
            cb_total = cb_total + 11
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 0
        
        if tunnelDoor() then
            cb_total = cb_total + 25
        end
        if tunnelDoor() and (has("climb") or twirl()) then
            cb_total = cb_total + 25
        end
        if templeIce() and canEnterTinyTemple() and mini() and has("dive") then
            cb_total = cb_total + 5
        end
        if templeIce() and canEnterTinyTemple() and has("dive") then
            cb_total = cb_total + 20
        end
        if canEnterLlamaTemple() and llamaSwitches() then
            cb_total = cb_total + 3
        end
        if canEnterLlamaTemple() and llamaSwitches() and mini() then
            cb_total = cb_total + 12
        end
        if canEnterLlamaTemple() and llamaSwitches() and feather() then
            cb_total = cb_total + 10
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 5
        
        if has("dive") and templeIce() and canEnterTinyTemple() and pineapple() then
            cb_total = cb_total + 10
        end
        if pineapple() then
            cb_total = cb_total + 20
        end
        if canEnterTinyTemple() then
            cb_total = cb_total + 29
        end
        if tunnelDoor() then
            cb_total = cb_total + 16
        end
        if tunnelDoor() and pineapple() and aztec5DT() then
            cb_total = cb_total + 20
        end
    end
    
    return cb_total >= cb_amount
end

function factoryCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal3")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 15
        
        if has("climb") then
            cb_total = cb_total + 5
        end
        if blast() then
            cb_total = cb_total + 20
        end
        if strong() and production() then
            cb_total = cb_total + 15
        end
        if coconut() and testing() and has("climb") then
            cb_total = cb_total + 35
        end
        if coconut() then
            cb_total = cb_total + 10
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 12
        
        if testing() and has("climb") then
            cb_total = cb_total + 8
        end
        if has("climb") then
            cb_total = cb_total + 10
        end
        if production() and has("climb") then
            cb_total = cb_total + 15
        end
        if spring() and has("climb") and testing() then
            cb_total = cb_total + 25
        end
        if guitar() and peanuts() and testing() and has("climb") then
            cb_total = cb_total + 30
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 10
        
        if production() and has("climb") then
            cb_total = cb_total + 20
        end
        if has("climb") and production() and ostand() then
            cb_total = cb_total + 20
        end
        if ostand() then
            cb_total = cb_total + 5
        end
        if testing() and has("climb") then
            cb_total = cb_total + 15
        end
        if grape() and production() and has("climb") then
            cb_total = cb_total + 20
        end
        if testing() and has("climb") and trombone() and grape() then
            cb_total = cb_total + 10
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 10
        
        if has("climb") then
            cb_total = cb_total + 5
        end
        if testing() and has("climb") then
            cb_total = cb_total + 25
        end
        if production() and has("climb") then
            cb_total = cb_total + 20
        end
        if production() and has("climb") and twirl() then
            cb_total = cb_total + 5
        end
        if testing() and mini() and has("climb") then
            cb_total = cb_total + 5
        end
        if testing() and has("climb") and feather() then
            cb_total = cb_total + 20
        end
        if feather() and production() then
            cb_total = cb_total + 10
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 20
        
        if pineapple() then
            cb_total = cb_total + 10
        end
        if testing() and has("climb") then
            cb_total = cb_total + 5
        end
        if production() and has("climb") then
            cb_total = cb_total + 20
        end
        if punch() then
            cb_total = cb_total + 15
        end
        if pineapple() and testing() and has("climb") then
            cb_total = cb_total + 10
        end
        if punch() and triangle() and testing() and has("climb") then
            cb_total = cb_total + 10
        end
        if pineapple() and punch() and triangle() and testing() and has("climb") then
            cb_total = cb_total + 10
        end
    end
    
    return cb_total >= cb_amount
end

function galleonCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal4")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 0
        
        if lighthouse() and raisedWater() and coconut() then
            cb_total = cb_total + 10
        end
        if lighthouse() and raisedWater() and blast() then
            cb_total = cb_total + 15
        end
        if lighthouse() and has("dive") and enguarde() then
            cb_total = cb_total + 10
        end
        if coconut() then
            cb_total = cb_total + 10
        end
        if has("dive") and shipyard() then
            cb_total = cb_total + 15
        end
        if has("dive") and bongos() and shipyard() then
            cb_total = cb_total + 10
        end
        if lighthouse() and raisedWater() and galleonSlam() and has("climb") then
            cb_total = cb_total + 20
        end
        if lighthouse() and raisedWater() and galleonSlam() and has("climb") and coconut() then
            cb_total = cb_total + 10
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 10
        
        if lighthouse() and raisedWater() and rocket() then
            cb_total = cb_total + 10
        end
        if lighthouse() and raisedWater() and rocket() and peanuts() then
            cb_total = cb_total + 10
        end
        if has("dive") and shipyard() then
            cb_total = cb_total + 36
        end
        if loweredWater() and has("dive") and guitar() and peanuts() then
            cb_total = cb_total + 14
        end
        if raisedWater() and has("dive") and peanuts() and treasure() then
            cb_total = cb_total + 10
        end
        if shipyard() and peanuts() then
            cb_total = cb_total + 10
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 5
        
        if shipyard() then
            cb_total = cb_total + 5
        end
        if lighthouse() and has("dive") then
            cb_total = cb_total + 25
        end
        if treasure() and raisedWater() and has("dive") then
            cb_total = cb_total + 10
        end
        if has("dive") and shipyard() then
            cb_total = cb_total + 5
        end
        if has("dive") and shipyard() and galleonSlam() then
            cb_total = cb_total + 10
        end
        if grape() and shipyard() then
            cb_total = cb_total + 10
        end
        if has("dive") and trombone() and loweredWater() and shipyard() then
            cb_total = cb_total + 15
        end
        if has("dive") and raisedWater() and treasure() and balloon() then
            cb_total = cb_total + 4
        end
        if punch() and grape() then
            cb_total = cb_total + 20
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 9
        
        if galleonSlam() and has("dive") and shipyard() then
            cb_total = cb_total + 10
        end
        if has("vine") then
            cb_total = cb_total + 8
        end
        if lighthouse() and raisedWater() then
            cb_total = cb_total + 5
        end
        if lighthouse() and feather() and loweredWater() then
            cb_total = cb_total + 10
        end
        if lighthouse() and feather() and raisedWater() then
            cb_total = cb_total + 10
        end
        if raisedWater() and canActivateGalleonCannonGame() then
            cb_total = cb_total + 15
        end
        if sax() and has("dive") and shipyard() then
            cb_total = cb_total + 18
        end
        if has("dive") and treasure() then
            cb_total = cb_total + 5
        end
        if raisedWater() and has("dive") and treasure() and feather() then
            cb_total = cb_total + 10
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 12
        
        if has("vine") then
            cb_total = cb_total + 3
        end
        if raisedWater() and seasick() then
            cb_total = cb_total + 20
        end
        if lighthouse() and has("dive") then
            cb_total = cb_total + 10
        end
        if raisedWater() and seasick() and punch() and has("slam") then
            cb_total = cb_total + 5
        end
        if raisedWater() and pineapple() and canActivateGalleonCannonGame() then
            cb_total = cb_total + 10
        end
        if pineapple() and shipyard() then
            cb_total = cb_total + 20
        end
        if has("dive") and shipyard() then
            cb_total = cb_total + 15
        end
        if raisedWater() and shipyard() then
            cb_total = cb_total + 5
        end
    end
    
    return cb_total >= cb_amount
end

function forestCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal5")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 28
        
        if coconut() and peanuts() and grape() and feather() and pineapple() and forestSlam() then
            cb_total = cb_total + 15
        end
        if has("climb") or rocket() then
            cb_total = cb_total + 7
        end
        if blast() and (has("climb") or rocket()) then
            cb_total = cb_total + 10
        end
        if coconut() then
            cb_total = cb_total + 10
        end
        if forestSlam() and dayTime() then
            cb_total = cb_total + 5
        end
        if coconut() and forestSlam() and dayTime() then
            cb_total = cb_total + 10
        end
        if nightTime() then
            cb_total = cb_total + 5
        end
        if nightTime() and strong() then
            cb_total = cb_total + 5
        end
        if nightTime() and strong() and forestSlam() then
            cb_total = cb_total + 5
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 28
        
        if has("climb") or rocket() then
            cb_total = cb_total + 17
        end
        if yellowTunnel() then
            cb_total = cb_total + 15
        end
        if yellowTunnel() and rocket() then
            cb_total = cb_total + 5
        end
        if peanuts() and dayTime() then
            cb_total = cb_total + 10
        end
        if peanuts() and forestSlam() and (has("climb") or balloon()) then
            cb_total = cb_total + 10
        end
        if spring() then
            cb_total = cb_total + 5
        end
        if nightTime() and spring() and guitar() then
            cb_total = cb_total + 10
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 20
        
        if has("climb") then
            cb_total = cb_total + 3
        end
        if has("climb") or balloon() then
            cb_total = cb_total + 9
        end
        if nightTime() and (has("climb") or balloon()) then
            cb_total = cb_total + 10
        end
        if grape() then
            cb_total = cb_total + 10
        end
        if grape() and canClimbMushroom() then
            cb_total = cb_total + 10
        end
        if rocket() or (ostand() and canClimbMushroom()) then
            cb_total = cb_total + 5
        end
        if forestSlam() and (rocket() or (ostand() and has("climb"))) then
            cb_total = cb_total + 15
        end
        if yellowTunnel() then
            cb_total = cb_total + 18
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 10
        
        if mini() and punch() and dayTime() then
            cb_total = cb_total + 5
        end
        if mini() and dayTime() then
            cb_total = cb_total + 10
        end
        if mini() and nightTime() and punch() and dayTime() then
            cb_total = cb_total + 5
        end
        if has("dive") then
            cb_total = cb_total + 17
        end
        if feather() then
            cb_total = cb_total + 20
        end
        if greenTunnelFeather() then
            cb_total = cb_total + 4
        end
        if greenTunnel() and has("climb") then
            cb_total = cb_total + 15
        end
        if yellowTunnel() then
            cb_total = cb_total + 8
        end
        if yellowTunnel() and mini() and sax() then
            cb_total = cb_total + 5
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 11
        
        if has("climb") or rocket() then
            cb_total = cb_total + 40
        end
        if punch() and dayTime() then
            cb_total = cb_total + 5
        end
        if greenTunnel() then
            cb_total = cb_total + 14
        end
        if has("vine") and nightTime() and (has("climb") or rocket()) then
            cb_total = cb_total + 5
        end
        if forestSlam() and (has("climb") or rocket()) then
            cb_total = cb_total + 5
        end
        if forestSlam() and pineapple() and (has("climb") or rocket()) then
            cb_total = cb_total + 10
        end
        if pineapple() and (has("climb") or rocket()) then
            cb_total = cb_total + 10
        end
    end
    
    return cb_total >= cb_amount
end

function cavesCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal6")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 25
        
        if cavesIce() then
            cb_total = cb_total + 3
        end
        if cavesIce() and coconut() then
            cb_total = cb_total + 20
        end
        if blast() then
            cb_total = cb_total + 20
        end
        if bongos() then
            cb_total = cb_total + 15
        end
        if bongos() and coconut() and igloo() then
            cb_total = cb_total + 10
        end
        if bongos() and strong() and igloo() then
            cb_total = cb_total + 7
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 5
        
        if mini() and twirl() then
            cb_total = cb_total + 10
        end
        if rocket() then
            cb_total = cb_total + 30
        end
        if peanuts() then
            cb_total = cb_total + 20
        end
        if guitar() and peanuts() and igloo() then
            cb_total = cb_total + 10
        end
        if guitar() and spring() and rocket() then
            cb_total = cb_total + 15
        end
        if guitar() then
            cb_total = cb_total + 5
        end
        if guitar() and rocket() then
            cb_total = cb_total + 5
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 15
        
        if cavesSlam() and grape() then
            cb_total = cb_total + 10
        end
        if cavesSlam() and balloon() then
            cb_total = cb_total + 5
        end
        if rocket() then
            cb_total = cb_total + 20
        end
        if balloon() then
            cb_total = cb_total + 15
        end
        if balloon() or rocket() then
            cb_total = cb_total + 5
        end
        if grape() then
            cb_total = cb_total + 10
        end
        if trombone() and igloo() then
            cb_total = cb_total + 1
        end
        if trombone() and igloo() and balloon() then
            cb_total = cb_total + 4
        end
        if trombone() and balloon() then
            cb_total = cb_total + 5
        end
        if trombone() and igloo() and grape() then
            cb_total = cb_total + 10
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 15
        
        if sax() then
            cb_total = cb_total + 10
        end
        if sax() and igloo() then
            cb_total = cb_total + 5
        end
        if sax() and feather() and igloo() then
            cb_total = cb_total + 10
        end
        if sax() and feather() then
            cb_total = cb_total + 10
        end
        if feather() then
            cb_total = cb_total + 10
        end
        if feather() and mini() and twirl() then
            cb_total = cb_total + 10
        end
        if mini() and port() and twirl() then
            cb_total = cb_total + 5
        end
        if mini() then
            cb_total = cb_total + 5
        end
        if has("barrel") and cavesIce() and hunky() and port() then
            cb_total = cb_total + 20
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 18
        
        if has("barrel") then
            cb_total = cb_total + 5
        end
        if cavesIce() then
            cb_total = cb_total + 11
        end
        if cavesIce() and has("barrel") then
            cb_total = cb_total + 6
        end
        if cavesIce() and pineapple() then
            cb_total = cb_total + 10
        end
        if cavesIce() and has("barrel") and hunky() then
            cb_total = cb_total + 10
        end
        if triangle() and gone() then
            cb_total = cb_total + 20
        end
        if triangle() and pineapple() and igloo() then
            cb_total = cb_total + 10
        end
        if mini() and pineapple() then
            cb_total = cb_total + 10
        end
    end
    
    return cb_total >= cb_amount
end

function castleCBTotal()
    local cb_total = 0
    local cb_amount = Tracker:ProviderCountForCode("tnsportal7")
    
    -- DK bananas
    if has("donkey") then
        cb_total = cb_total + 50
        
        if castleSlam() then
            cb_total = cb_total + 10
        end
        if castleSlam() and strong() then
            cb_total = cb_total + 10
        end
        if blast() and coconut() then
            cb_total = cb_total + 15
        end
        if dkCryptDoors() then
            cb_total = cb_total + 5
        end
        if dkCryptDoors() and coconut() then
            cb_total = cb_total + 10
        end
    end
    
    -- Diddy bananas
    if has("diddy") then
        cb_total = cb_total + 0
        
        if cryptDoors() then
            cb_total = cb_total + 5
        end
        if peanuts() then
            cb_total = cb_total + 20
        end
        if rocket() then
            cb_total = cb_total + 10
        end
        if castleSlam() and rocket() then
            cb_total = cb_total + 15
        end
        if castleSlam() and peanuts() then
            cb_total = cb_total + 20
        end
        if punch() then
            cb_total = cb_total + 20
        end
        if charge() and peanuts() and diddyCryptDoors() then
            cb_total = cb_total + 10
        end
    end
    
    -- Lanky bananas
    if has("lanky") then
        cb_total = cb_total + 30
        
        if castleSlam() then
            cb_total = cb_total + 30
        end
        if castleSlam() and grape() then
            cb_total = cb_total + 20
        end
        if castleSlam() and grape() and trombone() and balloon() then
            cb_total = cb_total + 10
        end
        if grape() and sprint() then
            cb_total = cb_total + 10
        end
    end
    
    -- Tiny bananas
    if has("tiny") then
        cb_total = cb_total + 50
        
        if mini() then
            cb_total = cb_total + 5
        end
        if has("diddy") and castleSlam() then
            cb_total = cb_total + 5
        end
        if has("diddy") and castleSlam() and port() then
            cb_total = cb_total + 15
        end
        if has("diddy") and castleSlam() and port() and feather() then
            cb_total = cb_total + 10
        end
        if feather() then
            cb_total = cb_total + 10
        end
        if mausoleumDoors() then
            cb_total = cb_total + 5
        end
    end
    
    -- Chunky bananas
    if has("chunky") then
        cb_total = cb_total + 30
        
        if punch() and chunkyCryptDoors() then
            cb_total = cb_total + 10
        end
        if punch() and pineapple() then
            cb_total = cb_total + 30
        end
        if castleSlam() and has("barrel") and punch() then
            cb_total = cb_total + 5
        end
        if blast() then
            cb_total = cb_total + 5
        end
        if blast() and punch() and pineapple() then
            cb_total = cb_total + 10
        end
        if castleSlam() and pineapple() then
            cb_total = cb_total + 10
        end
    end
    
    return cb_total >= cb_amount
end