GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

Assets = {
	Asset("IMAGE", "images/archor.tex"),
	Asset("ATLAS", "images/archor.xml"),
    Asset("IMAGE", "images/mast.tex"),
	Asset("ATLAS", "images/mast.xml"),
}

GLOBAL.Mod = {
    env = getfenv(1),
    config = {
        anchor_speed = GetModConfigData('anchor_speed'),
        power_anchor = GetModConfigData('power_anchor'),
        mast_speed = GetModConfigData('mast_speed'),
        power_mast = GetModConfigData('power_mast'),
        power_rudder = GetModConfigData('power_rudder'),
        create_fish = GetModConfigData('create_fish'),
        no_boat_leak = GetModConfigData('no_boat_leak'),
    },
}

import = kleiloadlua(MODROOT .. "scripts/import.lua")()
if GetModConfigData("boat_button") then
    import("ui")
end

modimport("custom/tuning")
modimport("custom/prefabs/boat")
if GetModConfigData('power_rudder') then
    modimport("custom/components/boatphysics")
end
if GetModConfigData('show_fish') then
    modimport("custom/show_fish")
end