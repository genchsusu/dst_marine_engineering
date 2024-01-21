GLOBAL.setfenv(1, GLOBAL)

local tuning = {}

local config = Mod.config

if config.anchor_speed == 1 then
    tuning.ANCHOR_DEPTH_TIMES = {
        LAND = 0,
        SHALLOW = 1,
        BASIC = 2,
        DEEP = 3,
        VERY_DEEP = 4,
    }
elseif config.anchor_speed == 2 then
    tuning.ANCHOR_DEPTH_TIMES = {
        LAND = 0,
        SHALLOW = 1,
        BASIC = 2,
        DEEP = 3,
        VERY_DEEP = 4,
    }
end

for key, value in pairs(tuning) do
    if TUNING[key] then
        print("OVERRIDE: " .. key .. " in TUNING")
    end

    TUNING[key] = value
end

TUNING.BOAT.MAX_HULL_HEALTH_DAMAGE = 0
TUNING.BOAT.WAKE_TEST_TIME = 0.5

if config.power_rudder then
    TUNING.BOAT.RUDDER_TURN_SPEED = 15
end

-- mast speed
if config.power_mast then
    TUNING.BOAT.MAST.BASIC.MAX_VELOCITY = 20
    TUNING.BOAT.MAST.BASIC.SAIL_FORCE = 10
    TUNING.BOAT.MAST.MALBATROSS.MAX_VELOCITY = 20
    TUNING.BOAT.MAST.MALBATROSS.SAIL_FORCE = 10
end

-- anchor power
if config.power_anchor then
    TUNING.BOAT.ANCHOR.BASIC.ANCHOR_DRAG = 5
end

-- -- bumper
-- TUNING.BOAT.BUMPERS.KELP.HEALTH = 2000
-- TUNING.BOAT.BUMPERS.SHELL.HEALTH = 4000