-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_HORIZONTAL = variant:find("horizontal")

print("-- DK64 Poptracker --")
print("Loaded variant: ", variant)
if ENABLE_DEBUG_LOG then
    print("Debug logging is enabled!")
end


-- Logic
ScriptHost:LoadScript("scripts/logic/logic.lua")


-- Items
Tracker:AddItems("items/kongs.json")
Tracker:AddItems("items/moves.jsonc")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/keys.json")
Tracker:AddItems("items/settinglist.json")
Tracker:AddItems("items/hints.json")


-- Locations
Tracker:AddMaps("maps/maps.json")
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
Tracker:AddLocations("locations/hints.json")
Tracker:AddLocations("locations/overview.json")


-- Default Layout
Tracker:AddLayouts("layouts/moves.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.jsonc")
Tracker:AddLayouts("layouts/world_maps.json")
Tracker:AddLayouts("layouts/tabs.json")
Tracker:AddLayouts("layouts/shared.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/level_order.json")
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/barriers.json")

-- Horizontal Layout
if IS_HORIZONTAL then
    Tracker:AddLayouts("horizontal/layouts/moves.json")
    Tracker:AddLayouts("horizontal/layouts/tracker.json")
    Tracker:AddLayouts("horizontal/layouts/shared.json")
    Tracker:AddLayouts("horizontal/layouts/items.json")
end

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
