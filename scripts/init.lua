-- entry point for all lua code of the pack
-- more info on the lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
ENABLE_DEBUG_LOG = true
-- get current variant
local variant = Tracker.ActiveVariantUID
-- check variant info
IS_HORIZONTAL = variant:find("horizontal")
IS_NEWICONS = variant:find("var_icons")

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
Tracker:AddLocations("locations/isles.json")
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
Tracker:AddLocations("locations/islesdropsanity.json")
Tracker:AddLocations("locations/japesdropsanity.json")
Tracker:AddLocations("locations/aztecdropsanity.json")
Tracker:AddLocations("locations/factorydropsanity.json")
Tracker:AddLocations("locations/galleondropsanity.json")
Tracker:AddLocations("locations/forestdropsanity.json")
Tracker:AddLocations("locations/cavesdropsanity.json")
Tracker:AddLocations("locations/castledropsanity.json")
Tracker:AddLocations("locations/helmdropsanity.json")

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
Tracker:AddLayouts("layouts/glitch.json")
Tracker:AddLayouts("layouts/popup.json")

-- Horizontal Layout
if IS_HORIZONTAL then
    Tracker:AddLayouts("horizontal/layouts/moves.json")
    Tracker:AddLayouts("horizontal/layouts/tracker.json")
    Tracker:AddLayouts("horizontal/layouts/shared.json")
    Tracker:AddLayouts("horizontal/layouts/items.json")
end

if IS_NEWICONS then
    Tracker:AddItems("var_icons/items/moves.jsonc")
end

-- AutoTracking for Poptracker
if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
