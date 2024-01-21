-- scripts\widgets\archorbutton.lua
local BaseButton = require "widgets/basebutton"
local BoatUtils = require "utils/BoatUtils"

ArchorButton = Class(BaseButton, function(self)
    local name = "archorbutton"
    -- atlas, normal, focus, disabled, down, selected, scale, offset
    BaseButton._ctor(self , "images/archor.xml", "archor.tex")

    self:SetDraggable(true)
    self:SetInitPosition(Vector3(210, 80, 0))
    self.boat_utils = BoatUtils()
    self.key_position = name .. "_position"
    self.check_fn = function(inst) return self.boat_utils:IsAnchor(inst) end

    self:SetOnClick(function() self:OnClickfn() end)
end)

function ArchorButton:OnClickfn()
    print(self.name .. " clicked")

    local anchors = self.boat_utils:FindSpecificEntities(ThePlayer, self.boat_utils.boat_control_range, self.check_fn)
    local raise_all = self.boat_utils:CalculateRaiseAll(anchors, function(anchor)
        return self.boat_utils:IsAnchorRaised(anchor)
    end)

    for _, anchor in ipairs(anchors) do
        if raise_all and (not anchor:HasTag("anchor_raised") or anchor:HasTag("anchor_transitioning")) then
            local remove_time = anchor.components.anchor:GetCurrentDepth()
            self.boat_utils:PerformActionOnEntity(anchor, ACTIONS.RAISE_ANCHOR, remove_time)
        elseif not raise_all and anchor:HasTag("anchor_raised") and not anchor:HasTag("anchor_transitioning") then
            anchor.components.anchor:StartLoweringAnchor() -- Do the action without agent
        end
    end
end

function ArchorButton:IsVisible()
    return FindEntity(ThePlayer, self.boat_utils.boat_control_range, self.check_fn) ~= nil
end

return ArchorButton