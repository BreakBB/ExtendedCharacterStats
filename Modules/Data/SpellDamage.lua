---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _SpellDamage = {}
local _, _, classId = UnitClass("player")

---@param school number
---@return number
function Data:GetSpellDamage(school)
    local spellDmg = GetSpellBonusDamage(school)
    return DataUtils:Round(spellDmg, 0)
end

---@param creature number
---@return number
function Data:GetSpellPowerVsCreature(creature)
    local spellDmg = 0
    -- auras
    local j = 1
    repeat
        local aura = C_UnitAuras.GetAuraDataByIndex("player", j, "HELPFUL")
        j = j + 1
        if aura and aura.spellId then
            if creature == Data.UNDEAD then
                spellDmg = spellDmg + (Data.buffsUndeadSpellPower[aura.spellId] or 0)
            end
        end
    until (not aura)
    for i = 1, 18 do
        -- items
        local id, _ = GetInventoryItemID("player", i)
        if creature == Data.UNDEAD then
            spellDmg = spellDmg + (Data.itemsIncreaseSpellDamageUndead[id] or 0)
            spellDmg = spellDmg + (Data.itemsIncreaseSpellDamageUndeadDemon[id] or 0)
        elseif creature == Data.DEMON then
            if id == 30787 then spellDmg = spellDmg + 185 end -- Illidari-Bane Mageblade
            spellDmg = spellDmg + (Data.itemsIncreaseSpellDamageUndeadDemon[id] or 0)
        end
        -- enchants
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                if creature == Data.UNDEAD then
                    spellDmg = spellDmg + (Data.enchantsUndeadSlayer[enchant] or 0)
                    spellDmg = spellDmg + (Data.enchantsIncreaseSpellDamageUndead[enchant] or 0)
                elseif creature == Data.BEAST then
                    spellDmg = spellDmg + (Data.enchantsBeastSlayer[enchant] or 0)
                elseif creature == Data.ELEMENTAL then
                    spellDmg = spellDmg + (Data.enchantsElementalSlayer[enchant] or 0)
                end
            end
        end
    end

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
