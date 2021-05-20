---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Melee = {}
local _, _, classId = UnitClass("player")

---@return string
function Data:GetMeleeAttackPower()
    local melee, posBuff, negBuff = UnitAttackPower("player")
    return melee + posBuff + negBuff
end

---@return string
function Data:GetMeleeAttackSpeedMainHand()
    local mainHand, _ = UnitAttackSpeed("player")
    return DataUtils:Round(mainHand, 2)
end

---@return string
function Data:GetMeleeAttackSpeedOffHand()
    local _, offHand = UnitAttackSpeed("player")
    return DataUtils:Round(offHand, 2)
end

---@return string
function Data:MeleeCrit()
    return DataUtils:Round(GetCritChance(), 2) .. "%"
end

---@return string
function Data:MeleeHitBonus()
    return DataUtils:Round(_Melee:MeleeHitRating(), 2) .. "%"
end

---@return number
function _Melee:MeleeHitRating()
    if CR_HIT_MELEE then
        return GetCombatRatingBonus(CR_HIT_MELEE) + _Melee:GetTalentModifier()
    end
    return GetHitModifier()
end

function _Melee:GetTalentModifier()
    local mod = 0

    if classId == Data.WARRIOR and ECS.IsTBC then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 17)
        mod = points * 1 -- 0-3% Precision
    end

    return mod
end

---@return string
function Data:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = 6
    else
        missChance = DataUtils:GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitValue = _Melee:MeleeHitRating()
    if hitValue then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitValue
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = 9
    else
        missChance = DataUtils:GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitValue = _Melee:MeleeHitRating()
    if hitValue then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitValue
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data:GetExpertise()
    local expertise, _ = GetExpertise()
    return DataUtils:Round(expertise, 0)
end