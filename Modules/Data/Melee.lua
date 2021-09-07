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
    return DataUtils:Round(_Melee:GetHitRatingBonus(), 2) .. "%"
end

---@return number
function Data:MeleeHitRating()
    return GetCombatRating(CR_HIT_MELEE)
end

---@return number
function _Melee:GetHitRatingBonus()
    if CR_HIT_MELEE then
        return GetCombatRatingBonus(CR_HIT_MELEE) + _Melee:GetHitTalentBonus() + _Melee:GetHitFromBuffs()
    end
    return GetHitModifier()
end

function _Melee:GetHitTalentBonus()
    local mod = 0

    if classId == Data.WARRIOR and ECS.IsTBC then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 17)
        mod = points * 1 -- 0-3% Precision
    end

    if classId == Data.HUNTER then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 12)
        mod = points * 1 -- 0-3% Surefooted
    end

    if classId == Data.SHAMAN then
        local _, _, _, _, naturesGuidance, _, _, _ = GetTalentInfo(3, 6)
        mod = naturesGuidance * 1 -- 0-3% Nature's Guidance

        if ECS.IsTBC and Data:GetMeleeAttackSpeedOffHand() > 0 then
            local _, _, _, _, dualWielding, _, _, _ = GetTalentInfo(2, 17)
            mod = mod + dualWielding * 2 -- 0-6% Dual Wielding Specialization
        end
    end

    if classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
        mod = points * 1 -- 0-3% Precision
    end

    if classId == Data.ROGUE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 6)
        mod = points * 1 -- 0-5% Precision
    end

    return mod
end

function _Melee:GetHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 6562 then
            mod = mod + 1 -- 1% from Heroic Presence
            otherDraeneiInGroup = true
        end
    end

    if (not otherDraeneiInGroup) and IsSpellKnown(6562) then
        mod = mod + 1
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

    local hitValue = _Melee:GetHitRatingBonus()
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

    local hitValue = _Melee:GetHitRatingBonus()
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

---@return number
function Data:GetExpertise()
    local expertise, _ = GetExpertise()
    return DataUtils:Round(expertise, 0)
end