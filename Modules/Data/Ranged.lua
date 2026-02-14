---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Ranged = {}

local _, _, classId = UnitClass("player")

---@return number
function Data:GetRangeAttackPower()
    if UnitHasRelicSlot("player") then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@return number
function Data:GetRangedHasteRating()
    local hasteRating = GetCombatRating(CR_HASTE_RANGED)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetRangedHasteBonus()
    local hasteBonus = GetCombatRatingBonus(CR_HASTE_RANGED)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

---@return number
function Data:GetRangedAttackSpeed()
    local speed, _ = UnitRangedDamage("player")
    return DataUtils:Round(speed, 2)
end

---@return string
function Data:RangedCrit()
    return DataUtils:Round(GetRangedCritChance(), 2) .. "%"
end

---@return number
function Data:RangeHitRating()
    return GetCombatRating(CR_HIT_RANGED)
end

---@return string
function Data:RangeHitBonus()
    return DataUtils:Round(_Ranged:GetHitBonus(), 2) .. "%"
end

---@return number
function _Ranged:GetHitBonus()
    local hitValue = 0

    -- Biznick Scope awards Hit rating in TBC and is part of CR_HIT_RANGED
    if ECS.IsClassic then
        local rangedEnchant = DataUtils:GetEnchantForEquipSlot(Utils.CHAR_EQUIP_SLOTS["Range"])
        if rangedEnchant and rangedEnchant == Data.Enchant.Ids.BIZNICK_SCOPE then
            hitValue = hitValue + 3
        end
    end

    if CR_HIT_RANGED then
        hitValue = hitValue + GetCombatRatingBonus(CR_HIT_RANGED)
    end

    return hitValue + (GetHitModifier() or 0) + _Ranged:GetHitTalentBonus()
end

---@return number
function _Ranged:GetHitTalentBonus()
    local bonus = 0

    if ECS.IsWotlk and classId == Data.HUNTER then
        bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({53620,53621,53622}) -- Focused Aim
    end

    return bonus
end

---@return string
function Data:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = DataUtils.GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _Ranged:GetHitBonus()

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data.RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local rangedWeaponSkill = rangedAttackBase + rangedAttackMod
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = DataUtils.GetMissChanceByDifference(rangedWeaponSkill, enemyDefenseValue)
    local hitBonus = _Ranged:GetHitBonus()

    missChance = missChance - hitBonus
    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return number
function Data:GetRangedCritRating()
    local critRating = GetCombatRating(CR_CRIT_RANGED)
    return DataUtils:Round(critRating, 0)
end

return Data
