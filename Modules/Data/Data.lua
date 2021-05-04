---@class Data
local Data = ECSLoader:CreateModule("Data")

---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _GetGeneralTalentModifier
local dataFunctionRefs

local _, _, classId = UnitClass("player")

---@param school number
---@return number
function Data:GetSpellDmg(school)
    local spellDmg = GetSpellBonusDamage(school)
    local modifier = _GetGeneralTalentModifier()
    spellDmg = spellDmg * (1 + (modifier / 100))
    return DataUtils:Round(spellDmg, 0)
end

---@return number
_GetGeneralTalentModifier = function()
    local mod = 0

    if classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
        mod = points * 1 -- 0-3% Arcane Instability
    end

    return mod
end

---@return number
function Data:SpellPenetration()
    return DataUtils:Round(GetSpellPenetration(), 2) .. "%"
end

---@return number
function Data:GetHealingPower()
    return GetSpellBonusHealing()
end

---@param refName string
---@return number | string
function Data:GetStatInfo(refName)
    local dataFunction = dataFunctionRefs[refName];
    if dataFunction then
        return dataFunction()
    else
        print("[ECS] Invalid data refName:", refName)
    end
end

dataFunctionRefs = {
    ["MovementSpeed"] = function() return Data:GetMovementSpeed() end,
    -- Melee
    ["MeleeAttackPower"] = function() return Data:GetMeleeAttackPower() end,
    ["MeleeCritChance"] = function() return Data:MeleeCrit() end,
    ["MeleeHitBonus"] = function() return Data:MeleeHitBonus() end,
    ["MeleeHitSameLevel"] = function() return Data:MeleeHitMissChanceSameLevel() end,
    ["MeleeHitBossLevel"] = function() return Data:MeleeHitMissChanceBossLevel() end,
    ["MeleeAttackSpeedMainHand"] = function() return Data:GetMeleeAttackSpeedMainHand() end,
    ["MeleeAttackSpeedOffHand"] = function() return Data:GetMeleeAttackSpeedOffHand() end,
    -- Ranged
    ["RangeAttackpower"] = function() return Data:GetRangeAttackPower() end,
    ["RangedCritChance"] = function() return Data:RangedCrit() end,
    ["RangedHitBonus"] = function() return Data:RangeHitBonus() end,
    ["RangedHitSameLevel"] = function() return Data:RangeMissChanceSameLevel() end,
    ["RangedHitBossLevel"] = function() return Data:RangeMissChanceBossLevel() end,
    -- Defense
    ["Armor"] = function() return Data:GetArmorValue() end,
    ["DefenseValue"] = function() return Data:GetDefenseValue() end,
    ["DodgeChance"] = function() return Data:GetDodgeChance() end,
    ["ParryChance"] = function() return Data:GetParryChance() end,
    ["BlockChance"] = function() return Data:GetBlockChance() end,
    ["BlockValue"] = function() return Data:GetBlockValue() end,
    -- Spell
    ["SpellHitBonus"] = function() return Data:SpellHitBonus() end,
    ["SpellHitSameLevel"] = function() return Data:SpellMissChanceSameLevel() end,
    ["SpellHitBossLevel"] = function() return Data:SpellMissChanceBossLevel() end,
    ["SpellCritChance"] = function() return Data:GetSpellCrit(0) end,
    -- MP5
    ["MP5Items"] = function() return Data:GetMP5FromItems() end,
    ["MP5Spirit"] = function() return Data:GetMP5FromSpirit() end,
    ["MP5Buffs"] = function()
        local _, mp5Buffs = Data:GetMP5FromBuffs()
        return mp5Buffs
    end,
    ["MP5Casting"] = function() return Data:GetMP5WhileCasting() end,
    -- Spell Power by school
    ["PhysicalDmg"] = function() return Data:GetSpellDmg(Data.PHYSICAL_SCHOOL) end,
    ["HolyDmg"] = function() return Data:GetSpellDmg(Data.HOLY_SCHOOL) end,
    ["FireDmg"] = function() return Data:GetSpellDmg(Data.FIRE_SCHOOL) end,
    ["NatureDmg"] = function() return Data:GetSpellDmg(Data.NATURE_SCHOOL) end,
    ["FrostDmg"] = function() return Data:GetSpellDmg(Data.FROST_SCHOOL) end,
    ["ShadowDmg"] = function() return Data:GetSpellDmg(Data.SHADOW_SCHOOL) end,
    ["ArcaneDmg"] = function() return Data:GetSpellDmg(Data.ARCANE_SCHOOL) end,
    ["BonusHealing"] = Data.GetHealingPower,
    -- Spell Crit by school
    ["PhysicalCritChance"] = function() return Data:GetSpellCrit(Data.PHYSICAL_SCHOOL) end,
    ["HolyCritChance"] = function() return Data:GetSpellCrit(Data.HOLY_SCHOOL) end,
    ["FireCritChance"] = function() return Data:GetSpellCrit(Data.FIRE_SCHOOL) end,
    ["NatureCritChance"] = function() return Data:GetSpellCrit(Data.NATURE_SCHOOL) end,
    ["FrostCritChance"] = function() return Data:GetSpellCrit(Data.FROST_SCHOOL) end,
    ["ShadowCritChance"] = function() return Data:GetSpellCrit(Data.SHADOW_SCHOOL) end,
    ["ArcaneCritChance"] = function() return Data:GetSpellCrit(Data.ARCANE_SCHOOL) end,
}
