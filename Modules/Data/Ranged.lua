---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Ranged = {}

local _, _, classId = UnitClass("player")

---@return string
function Data:GetRangeAttackPower()
    if not _Ranged:IsRangeAttackClass() then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@return boolean
function _Ranged:IsRangeAttackClass()
    return classId == Data.WARRIOR or classId == Data.ROGUE or classId == Data.HUNTER
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

---@return string
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
    if (not ECS.IsWotlk) then
        local rangedEnchant = DataUtils:GetEnchantForEquipSlot(Utils.CHAR_EQUIP_SLOTS["Range"])
        if rangedEnchant and rangedEnchant == Data.Enchant.Ids.BIZNICK_SCOPE then
            hitValue = hitValue + 3
        end
    end

    local hitFromItems
    if CR_HIT_RANGED then
        hitFromItems = GetCombatRatingBonus(CR_HIT_RANGED)
    else
        hitFromItems = GetHitModifier()
    end

    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        hitValue = hitValue + hitFromItems + _Ranged:GetHitTalentBonus()
    end

    return hitValue
end

function _Ranged:GetHitTalentBonus()
    local bonus = 0

    if ECS.IsWotlk and classId == Data.HUNTER then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 27)
        bonus = points * 1 -- 0-3% Focused Aim
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

return Data
