---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _IsRangeAttackClass


---@return string
function Data:GetRangeAttackPower()
    if not _IsRangeAttackClass() then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@return boolean
_IsRangeAttackClass = function()
    local _, _, classId = UnitClass("player")

    return classId == Data.WARRIOR or classId == Data.ROGUE or classId == Data.HUNTER
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
local function _GetRangeHitBonus()
    local hitValue = 0

    local rangedEnchant = DataUtils:GetEnchantForEquipSlot(Utils.CHAR_EQUIP_SLOTS["Range"])
    if rangedEnchant and rangedEnchant == Data.enchantIds.BIZNIK_SCOPE then
        hitValue = hitValue + 3
    end

    local hitFromItems
    if CR_HIT_RANGED then
        hitFromItems = GetCombatRatingBonus(CR_HIT_RANGED)
    else
        hitFromItems = GetHitModifier()
    end

    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        hitValue = hitValue + hitFromItems
    end

    return hitValue
end

---@return string
function Data:RangeHitBonus()
    return DataUtils:Round(_GetRangeHitBonus(), 2) .. "%"
end

---@return string
function Data:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = DataUtils:GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data:RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local rangedWeaponSkill = rangedAttackBase + rangedAttackMod
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = DataUtils:GetMissChanceByDifference(rangedWeaponSkill, enemyDefenseValue)
    local hitBonus = _GetRangeHitBonus()
    if rangedWeaponSkill < 305 and hitBonus >= 1 then
        hitBonus = hitBonus - 1
    end
    missChance = missChance - hitBonus

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end