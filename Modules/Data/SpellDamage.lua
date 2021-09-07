---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _SpellDamage = {}

local _, _, classId = UnitClass("player")

---@param school number
---@return number
function Data:GetSpellDamage(school)
    local spellDmg = GetSpellBonusDamage(school)
    local modifier = _SpellDamage:GetGeneralTalentModifier() + _SpellDamage:GetModifierFromBuffs(school)
    spellDmg = spellDmg * (1 + (modifier / 100)) + _SpellDamage:GetTalentBonus()
    return DataUtils:Round(spellDmg, 0)
end

---@return number
function _SpellDamage:GetGeneralTalentModifier()
    local mod = 0

    if classId == Data.MAGE then
        local aiTalentSlot = ECS.IsTBC and 17 or 15
        local _, _, _, _, arcaneInstability, _, _, _ = GetTalentInfo(1, aiTalentSlot)
        mod = arcaneInstability * 1 -- 0-3% Arcane Instability
    end

    return mod
end

---@return number
function _SpellDamage:GetModifierFromBuffs(school)
    local mod = 0

    if classId == Data.WARLOCK and school == Data.SHADOW_SCHOOL then
        for i = 1, 40 do
            local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
            if spellId == nil then
                break
            end

            if spellId == 18791 then
                mod = 15 -- 15% Shadow damage from Touch of Shadow
            end
        end
    end

    return mod
end

---@return number
function _SpellDamage:GetTalentBonus()
    local bonus = 0

    if classId == Data.MAGE and ECS.IsTBC then
        local _, intValue, _, _ = UnitStat("player", 4)
        local _, _, _, _, mindMastery, _, _, _ = GetTalentInfo(1, 22)
        bonus = intValue * (mindMastery * 5 / 100) -- 5-25% of Int from Mind Mastery
    end

    return bonus
end

---@return number
function Data:SpellPenetration()
    return DataUtils:Round(GetSpellPenetration(), 2) .. "%"
end

---@return number
function Data:GetHealingPower()
    return GetSpellBonusHealing()
end