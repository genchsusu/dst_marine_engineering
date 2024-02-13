-- scripts\utils\boatutils.lua
local BoatUtils = Class(function(self, name)
    -- Base utilities initialization
    name = name or "boatutils"
    self.name = name
    self.boat_control_range = 5
end)

function BoatUtils:IsAnchor(inst)
    return inst.prefab == "anchor"
end

function BoatUtils:IsAnchorRaised(inst)
    return inst:HasTag("anchor_raised")
end

function BoatUtils:IsMast(inst)
    return inst.prefab == "mast" or inst.prefab == "mast_malbatross"
end

function BoatUtils:IsMastRaised(inst)
    local is_raised = inst:HasTag("sailraised")
    if inst.prefab == "mast_malbatross" then
        is_raised = not is_raised
    end
    return is_raised
end

function BoatUtils:FindSpecificEntities(inst, radius, fn)
    local x, y, z = inst.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x, y, z, radius)

    local valid_ents = {}
    for _, ent in ipairs(ents) do
        if ent ~= inst and ent.entity:IsVisible() and (fn == nil or fn(ent, inst)) then
            table.insert(valid_ents, ent)
        end
    end
    return valid_ents
end

function BoatUtils:CalculateRaiseAll(entities, checkRaisedFn)
    local total_count = #entities
    local raised_count = 0

    for _, entity in ipairs(entities) do
        if checkRaisedFn(entity) then
            raised_count = raised_count + 1
        end
    end

    return raised_count <= total_count / 2
end

function BoatUtils:PerformActionOnEntity(target, action, remove_time)
    if target:HasTag("managed_by_agent") then
        print(target.prefab .. " is already being processed by an agent.")
        return
    end

    target:AddTag("managed_by_agent")
    -- create an agent
    local agent = SpawnPrefab(ThePlayer.prefab)
    -- make the agent invisible
    agent.AnimState:SetMultColour(1, 1, 1, 0)
    -- remove the agent's physics
    if agent.Physics then agent.Physics:SetActive(false) end
    -- set the agent's position to the target's position
    agent.Transform:SetPosition(target.Transform:GetWorldPosition())

    agent:DoTaskInTime(0, function()
        local act = BufferedAction(agent, target, action)
        agent.components.locomotor:PushAction(act, true)
    end)

    print("Removing " .. target.prefab .. " in " .. remove_time .. " seconds.")
    if remove_time then
        agent:DoTaskInTime(remove_time, function() 
            agent:Remove()
            target:RemoveTag("managed_by_agent")
        end)
    end
end

return BoatUtils