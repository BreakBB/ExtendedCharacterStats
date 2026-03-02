local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetDebuffDataByIndex = C_UnitAuras.GetDebuffDataByIndex
local pairs = pairs

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


---@return string
function Data:GetMovementSpeed()
    local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")

    local currentSpeed

    if (not ECS.IsClassic) and IsFlying() then
        currentSpeed = flightSpeed
    elseif IsSwimming() then
        currentSpeed = swimSpeed
    else
        currentSpeed = runSpeed
    end

    currentSpeed = currentSpeed / 7 * 100
    return DataUtils:Round(currentSpeed, 0) .. "%"
end

---@return number
function Data:GetInvisibility()
    local inv = 0

    -- buffs
    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            for invisibilityType, Id in pairs(Data.Aura.Invisibility) do
                inv = inv + (Id[aura.spellId] or 0)
            end
        end
        i = i + 1
    until (not aura)

    -- debuffs
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            for invisibilityType, Id in pairs(Data.Aura.Invisibility) do
                inv = inv + (Id[aura.spellId] or 0)
            end
        end
        i = i + 1
    until (not aura)

    return DataUtils:Round(inv, 2)
end