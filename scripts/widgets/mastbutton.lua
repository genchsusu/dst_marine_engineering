-- scripts\widgets\mastbutton.lua
local BaseButton = require "widgets/basebutton"
local BoatUtils = require "utils/BoatUtils"

MastButton = Class(BaseButton, function(self)
    local name = "mastbutton"
    -- atlas, normal, focus, disabled, down, selected, scale, offset
    BaseButton._ctor(self , "images/mast.xml", "mast.tex")

    self:SetDraggable(true)
    self:SetInitPosition(Vector3(110, 80, 0))
    self.boat_utils = BoatUtils()
    self.key_position = name .. "_position"
    self.check_fn = function(inst) return self.boat_utils:IsMast(inst) end

    self:SetOnClick(function() self:OnClickfn() end)
end)

function MastButton:OnClickfn()
    print(self.name .. " clicked")

    local masts = self.boat_utils:FindSpecificEntities(ThePlayer, self.boat_utils.boat_control_range, self.check_fn)
    local raise_all = self.boat_utils:CalculateRaiseAll(masts, function(mast)
        return self.boat_utils:IsMastRaised(mast)
    end)

    for _, mast in ipairs(masts) do
        local sail_raised = self.boat_utils:IsMastRaised(mast)
    
        if raise_all and not sail_raised then
            print("Raising sail for mast")
            if mast.prefab == "mast_malbatross" then
                self.boat_utils:PerformActionOnEntity(mast, ACTIONS.LOWER_SAIL_BOOST, 4.5)
            else
                mast.components.mast:UnfurlSail() -- Do the action without agent
            end
        elseif not raise_all and sail_raised then
            print("Lowering sail for mast")
            if mast.prefab == "mast_malbatross" then
                mast.components.mast:UnfurlSail() -- Do the action without agent
            else
                self.boat_utils:PerformActionOnEntity(mast, ACTIONS.LOWER_SAIL_BOOST, 4.5)
            end
        end
    end
end

function MastButton:IsVisible()
    return FindEntity(ThePlayer, self.boat_utils.boat_control_range, self.check_fn) ~= nil
end

return MastButton



