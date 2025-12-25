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
    local modifier = _SpellDamage:GetGeneralTalentModifier()
    spellDmg = spellDmg * (1 + (modifier / 100))
    return DataUtils:Round(spellDmg, 0)
end

---@return number
function _SpellDamage:GetGeneralTalentModifier()
    local mod = 0

    if classId == Data.MAGE then
        local talentSlot = ECS.IsWotlk and 17 or 14
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, talentSlot)
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

---@return number
function Data:GetSpellHasteRating()
    local hasteRating = GetCombatRating(CR_HASTE_SPELL)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetSpellHasteBonus()
    local hasteBonus = GetHaste()

    local timeworn = DataUtils:CountTimewornItems()

    for i = 1, 18 do
        local id, _ = GetInventoryItemID("player", i)
        hasteBonus = hasteBonus + (Data.Item.SpellHaste[id] or 0)
        hasteBonus = hasteBonus + hasteBonus * (Data.Item.TimewornSpellHaste[id] or 0)
    end

    return DataUtils:Round(hasteBonus, 2) .. "%"
end
