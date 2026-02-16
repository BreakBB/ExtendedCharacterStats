---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

---@param school number
---@return number
function Data:GetSpellDamage(school)
    local spellDmg = GetSpellBonusDamage(school)
    return DataUtils:Round(spellDmg, 0)
end

---@return string
function Data:SpellPenetration()
    return DataUtils:Round(GetSpellPenetration(), 2) .. "%"
end

---@return number
function Data:GetHealingPower()
    return GetSpellBonusHealing()
end

---@return number
function Data:GetSpellHasteRating()
    if (not CR_HASTE_SPELL) then
        return 0
    end

    local hasteRating = GetCombatRating(CR_HASTE_SPELL)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetSpellHasteBonus()
    local hasteBonus = GetHaste()

    -- items
    if ECS.IsSoD then
        local timeworn = DataUtils:CountTimewornItems()
        for i = 1, 18 do
            local id, _ = GetInventoryItemID("player", i)
            hasteBonus = hasteBonus + (Data.Item.SpellHaste[id] or 0)
            hasteBonus = hasteBonus + timeworn * (Data.Item.TimewornSpellHaste[id] or 0)
        end
    end

    -- buffs
    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            hasteBonus = hasteBonus + (Data.Aura.SpellHaste[aura.spellId] or 0)
        end
        i = i + 1
    until (not aura)

    -- debuffs
    i = 1
    repeat
        local aura = C_UnitAuras.GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            hasteBonus = hasteBonus + (Data.Aura.SpellHaste[aura.spellId] or 0)
        end
        i = i + 1
    until (not aura)

    -- not stacking buffs
    if ECS.IsSoD then
        local aura = C_UnitAuras.GetPlayerAuraBySpellID(1219557) -- Power of the Guardian
        if aura then
            hasteBonus = hasteBonus + 2
        end
    end

    return DataUtils:Round(hasteBonus, 2) .. "%"
end
