---@class Data
local Data = ECSLoader:CreateModule("Data")

---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


---@param school number
---@return number
function Data:GetSpellDmg(school)
    return GetSpellBonusDamage(school)
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

    if refName == "MeleeAttackpower" then
        return Data:GetMeleeAttackPower()
    end
    if refName == "MeleeCritChance" then
        return Data:MeleeCrit()
    end
    if refName == "MeleeHitBonus" then
       return Data:MeleeHitBonus()
    end
    if refName == "MeleeHitSameLevel" then
        return Data:MeleeHitMissChanceSameLevel()
    end
    if refName == "MeleeHitBossLevel" then
        return Data:MeleeHitMissChanceBossLevel()
    end

    if refName == "RangeAttackpower" then
        return Data:GetRangeAttackPower()
    end
    if refName == "RangedCritChance" then
        return Data:RangedCrit()
    end
    if refName == "RangedHitBonus" then
       return Data:RangeHitBonus()
    end
    if refName == "RangedHitSameLevel" then
        return Data:RangeMissChanceSameLevel()
    end
    if refName == "RangedHitBossLevel" then
        return Data:RangeMissChanceBossLevel()
    end

    if refName == "Armor" then
        return Data:GetArmorValue()
    end
    if refName == "DefenseValue" then
        return Data:GetDefenseValue()
    end
    if refName == "DodgeChance" then
        return Data:GetDodgeChance()
    end
    if refName == "ParryChance" then
        return Data:GetParryChance()
    end
    if refName == "BlockChance" then
        return Data:GetBlockChance()
    end
    if refName == "BlockValue" then
        return Data:GetBlockValue()
    end

    if refName == "SpellHitBonus" then
       return Data:SpellHitBonus()
    end
    if refName == "SpellHitSameLevel" then
        return Data:SpellMissChanceSameLevel()
    end
    if refName == "SpellHitBossLevel" then
        return Data:SpellMissChanceBossLevel()
    end
    if refName == "SpellCritChance" then
        return Data:GetSpellCrit(0)
    end

    if refName == "MP5Items" then
        return Data:GetMP5FromItems()
    end
    if refName == "MP5Spirit" then
        return Data:GetMP5FromSpirit()
    end
    if refName == "MP5Casting" then
        return Data:GetMP5WhileCasting()
    end

    if refName == "PhysicalDmg" then
        return Data:GetSpellDmg(Data.PHYSICAL_SCHOOL)
    end
    if refName == "HolyDmg" then
        return Data:GetSpellDmg(Data.HOLY_SCHOOL)
    end
    if refName == "FireDmg" then
        return Data:GetSpellDmg(Data.FIRE_SCHOOL)
    end
    if refName == "NatureDmg" then
        return Data:GetSpellDmg(Data.NATURE_SCHOOL)
    end
    if refName == "FrostDmg" then
        return Data:GetSpellDmg(Data.FROST_SCHOOL)
    end
    if refName == "ShadowDmg" then
        return Data:GetSpellDmg(Data.SHADOW_SCHOOL)
    end
    if refName == "ArcaneDmg" then
        return Data:GetSpellDmg(Data.ARCANE_SCHOOL)
    end

    if refName == "PhysicalCritChance" then
        return Data:GetSpellCrit(Data.PHYSICAL_SCHOOL)
    end
    if refName == "HolyCritChance" then
        return Data:GetSpellCrit(Data.HOLY_SCHOOL)
    end
    if refName == "FireCritChance" then
        return Data:GetSpellCrit(Data.FIRE_SCHOOL)
    end
    if refName == "NatureCritChance" then
        return Data:GetSpellCrit(Data.NATURE_SCHOOL)
    end
    if refName == "FrostCritChance" then
        return Data:GetSpellCrit(Data.FROST_SCHOOL)
    end
    if refName == "ShadowCritChance" then
        return Data:GetSpellCrit(Data.SHADOW_SCHOOL)
    end
    if refName == "ArcaneCritChance" then
        return Data:GetSpellCrit(Data.ARCANE_SCHOOL)
    end

    if refName == "BonusHealing" then
        return Data:GetHealingPower()
    end
end
