-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_ITEMS_ONLY = variant:find("itemsonly")

print("-- DK64 Poptracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end

-- Utility Script for helper functions etc.
ScriptHost:LoadScript("scripts/utils.lua")

-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")


-- Items
Tracker:AddItems("items/kongs.json")
Tracker:AddItems("items/moves.jsonc")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/settings.json")

if not IS_ITEMS_ONLY then -- <--- use variant info to optimize loading
    -- Maps
    Tracker:AddMaps("maps/maps.json")
    -- Locations
    Tracker:AddLocations("locations/isles.jsonc")
    Tracker:AddLocations("locations/aztec.json")
    Tracker:AddLocations("locations/castle.json")
    Tracker:AddLocations("locations/caves.json")
    Tracker:AddLocations("locations/forest.json")
    Tracker:AddLocations("locations/helm.json")
    Tracker:AddLocations("locations/japes.json")
    Tracker:AddLocations("locations/galleon.json")
    Tracker:AddLocations("locations/factory.json")
    Tracker:AddLocations("locations/shops.json")
end

-- Layout
Tracker:AddLayouts("layouts/moves.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.jsonc")
Tracker:AddLayouts("layouts/world_maps.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/keys.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/barriers.json")

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
