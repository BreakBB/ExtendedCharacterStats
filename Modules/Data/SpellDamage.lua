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

---@param creature number
---@return number
function Data:GetSpellDamageVsCreature(creature)
    local spellDmg = 0
    if creature == Data.UNDEAD then
        -- enchants
        for i = 1, 18 do
            local itemLink = GetInventoryItemLink("player", i)
            if itemLink then
                local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                if enchant and enchant == Data.enchantIds.INCREASE_SPELL_DAM_UNDEAD_60 then spellDmg = spellDmg + 60 end
            end
        end
        -- auras
        if C_UnitAuras.GetPlayerAuraBySpellID(24833) then spellDmg = spellDmg + 400 end -- holy mightstone
        -- items
        if C_Item.IsEquippedItem(23091) then spellDmg = spellDmg + 26 end -- Bracers of Undead Cleansing
        for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_35) do
            if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 35 end
        end
        for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_48) do
            if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 48 end
        end
        --
        if ECS.IsSod then
            -- items
            for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_62) do
                if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 65 end -- name is different from bonus
            end
            for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_26) do
                if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 26 end
            end
            for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_35_SOD) do
                if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 35 end
            end
            for _, i in pairs(Data.itemIds.INCREASE_SPELL_DAM_UNDEAD_48_SOD) do
                if C_Item.IsEquippedItem(i) then spellDmg = spellDmg + 48 end
            end
        elseif ECS.IsWotlk then
            -- enchants
            for i = 1, 18 do
                local itemLink = GetInventoryItemLink("player", i)
                if itemLink then
                    local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                    if enchant and enchant == Data.enchantIds.INCREASE_SPELL_DAM_UNDEAD_100 then spellDmg = spellDmg + 100 end
                end
            end
            -- auras
            if C_UnitAuras.GetPlayerAuraBySpellID(60597) then spellDmg = spellDmg + 12000 end -- Blessing of the Crusade
        end
        if ECS.IsTbc or ECS.IsWotlk then
            -- auras
            if C_UnitAuras.GetPlayerAuraBySpellID(28488) then spellDmg = spellDmg + 15 end -- Scourgebane Infusion
        end
    elseif creature == Data.DEMON then
        if ECS.IsTbc or ECS.IsWotlk then
            -- items
            if C_Item.IsEquippedItem(30787) then spellDmg = spellDmg + 185 end -- Illidari-Bane Mageblade
        end
    elseif creature == Data.BEAST then
        -- enchants
        for i = 1, 18 do
            local itemLink = GetInventoryItemLink("player", i)
            if itemLink then
                local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                if enchant then
                    if enchant == Data.enchantIds.BEASTSLAYER then spellDmg = spellDmg + 2
                    elseif enchant == Data.enchantIds.LESSER_BEAST_SLAYER then spellDmg = spellDmg + 6
                    elseif enchant == Data.enchantIds.MINOR_BEAST_SLAYER then spellDmg = spellDmg + 2
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_2 then spellDmg = spellDmg + 2
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_4 then spellDmg = spellDmg + 4
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_6 then spellDmg = spellDmg + 6
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_8 then spellDmg = spellDmg + 8
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_10 then spellDmg = spellDmg + 10
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_12 then spellDmg = spellDmg + 12
                    elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_14 then spellDmg = spellDmg + 14
                end
            end
        end
    elseif creature == Data.ELEMENTAL then
        -- enchants
        for i = 1, 18 do
            local itemLink = GetInventoryItemLink("player", i)
            if itemLink then
                local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                if enchant and enchant == Data.enchantIds.LESSER_ELEMENTAL_SLAYER then spellDmg = spellDmg + 6 end
            end
        end
    end
    if creature == Data.UNDEAD or creature == Data.DEMON then
        -- items
        if C_Item.IsEquippedItem(29113) then spellDmg = spellDmg + 85 end -- Champion of the Dawn
        if ECS.IsSod and C_Item.IsEquippedItem(1219522) then spellDmg = spellDmg + 89 end -- Champion of the Dawn
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
    local hasteBonus = GetCombatRatingBonus(CR_HASTE_SPELL)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end
