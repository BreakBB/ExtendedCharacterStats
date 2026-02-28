local ECSLoader = ECSLoader
local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetDebuffDataByIndex = C_UnitAuras.GetDebuffDataByIndex
local GetInventoryItemLink = GetInventoryItemLink
local GetManaRegen = GetManaRegen
local GetWeaponEnchantInfo = GetWeaponEnchantInfo
local IsSoD = ECS.IsSoD
local IsTBC = ECS.IsTBC
local IsWotlk = ECS.IsWotlk
local match = string.match
local min = math.min
local tonumber = tonumber
local UnitClass = UnitClass
local UnitPowerMax = UnitPowerMax

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _MP5 = {}

local _, _, classId = UnitClass("player")

---@return number
function Data:GetValueFromAuraTooltip(index,type)
    if not ECS.scanningTooltip then
        ECS.scanningTooltip = CreateFrame("GameTooltip", "scanningTooltip", nil, "GameTooltipTemplate")
        ECS.scanningTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    end

    ECS.scanningTooltip:ClearLines()
    ECS.scanningTooltip:SetUnitAura("player",index, type)
    local region = select(5,ECS.scanningTooltip:GetRegions())
    if region and region:GetObjectType() == "FontString" then
        local tooltip = region:GetText()
        if tooltip then
            return tonumber(match(tooltip, '%d[%d,.]*'))
        end
    end
    return 0
end

-- Get MP5 from items
---@return number
function Data:GetMP5FromItems()
    return _MP5:GetMP5ValueOnItems() + Data:GetSetBonusValueMP5() + _MP5.GetMP5FromRunes()
end

---@return number
function _MP5:GetMP5ValueOnItems()
    local mp5 = 0
    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local stats = GetItemStats(itemLink)
            if stats then
                local statMP5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"]
                if statMP5 then
                    mp5 = mp5 + statMP5 + 1
                end
            end
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                mp5 = mp5 + (Data.Enchant.MP5[enchant] or 0)
            end
            -- Check for socketed gems (TODO: check for socket bonus)
            local gem1, gem2, gem3 = DataUtils:GetSocketedGemsFromItemLink(itemLink)
            if gem1 then
                mp5 = mp5 + (Data.Gem.MP5[tonumber(gem1)] or 0)
            end
            if gem2 then
                mp5 = mp5 + (Data.Gem.MP5[tonumber(gem2)] or 0)
            end
            if gem3 then
                mp5 = mp5 + (Data.Gem.MP5[tonumber(gem3)] or 0)
            end
        end
    end

    -- Check weapon enchants (e.g. Mana Oil)
    local hasMainEnchant, _, _, mainHandEnchantID = GetWeaponEnchantInfo()
    if (hasMainEnchant) then
        mp5 = mp5 + (Data.Enchant.MP5[mainHandEnchantID] or 0)
    end

    return mp5
end

local lastManaReg = 0

---@return number
function Data:GetMP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second (including talent and buff modifiers)
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base

    return DataUtils:Round(base * 5, 2)
end

-- Get mana regen while casting
---@return number
function Data:GetMP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second (including talent and buff modifiers)
    if casting < 0.1 then
        casting = 0
    end

    local castingModifier, mp5BuffBonus, periodicMana = Data:GetMP5FromBuffs()
    castingModifier = min(1,castingModifier + _MP5:GetTalentModifier() + Data:GetSetBonusModifierMP5()) -- capped at 100%
    local mp5Items = Data:GetMP5FromItems()
    casting = (casting * 5) + mp5Items + mp5BuffBonus * castingModifier + periodicMana

    return DataUtils:Round(casting, 2)
end

---@return number
function Data:GetMP5OutsideCasting()
    local mp5FromSpirit = Data:GetMP5FromSpirit()
    local _, mp5BuffBonus, periodicMana = Data:GetMP5FromBuffs()
    local mp5FromItems = Data:GetMP5FromItems()

    local totalMP5 = mp5FromSpirit + mp5FromItems + mp5BuffBonus + periodicMana
    return DataUtils:Round(totalMP5, 2)
end

---@return number, number, number
function Data:GetMP5FromBuffs()
    local mod = 0
    local bonus = 0
    local periodic = 0
    local maxmana = UnitPowerMax("player", Enum.PowerType.Mana)

    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            bonus = bonus + (Data.Aura.MP5[aura.spellId] or 0)
            bonus = bonus + (Data.Aura.PercentageMp5[aura.spellId] or 0) * maxmana
            periodic = periodic + (Data.Aura.PeriodicallyGiveMana[aura.spellId] or 0)
            mod = mod + (Data.Aura.AllowCastingManaRegeneration[aura.spellId] or 0) -- assuming buffs stacking, to be investigated
            if Data.Aura.IsLightningShield[aura.spellId] and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
                bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
            end
            if Data.Aura.MP5Tooltip[aura.spellId] then
                bonus = bonus + Data.Aura.MP5Tooltip[aura.spellId] * Data:GetValueFromAuraTooltip(i, "HELPFUL")
            end
            if Data.Aura.PeriodicallyGiveManaTooltip[aura.spellId] then
                periodic = periodic + Data.Aura.PeriodicallyGiveManaTooltip[aura.spellId] * Data:GetValueFromAuraTooltip(i, "HELPFUL")
            end
            if IsWotlk then
                if aura.spellId == 64999 then
                    bonus = bonus + 85 * aura.applications -- Meteoric Inspiration
                end
            end
        end
        i = i + 1
    until (not aura)
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            bonus = bonus + (Data.Aura.PercentageMp5[aura.spellId] or 0) * maxmana
        end
        i = i + 1
    until (not aura)
    return min(mod,1), bonus, periodic
end

---@return number
function _MP5.GetMP5FromRunes()
    local mod = 0

    if (not IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if (finger1Rune == 7639 or finger2Rune == 7639) then
        mod = mod + 5 -- 5 MP5 from Meditation Specialization Rune
    end

    return mod
end

---@return number
function _MP5:GetTalentModifier()
    local mod = 0

    if classId == Data.PRIEST then
        local coeff = IsTBC and 0.1 or (IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({14521,14776,14777}) -- meditation
    elseif classId == Data.MAGE then
        local coeff = IsTBC and 0.1 or (IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({14521,18463,18464}) -- arcane meditation

        if IsWotlk then
            mod = mod + 0.5/3 * DataUtils:GetActiveTalentSpell({34293,34295,34296}) -- pyromaniac
        end
    elseif classId == Data.DRUID then
        local coeff = IsTBC and 0.1 or (IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({17106,17107,17108}) -- intensity/reflection
    end
    return mod
end
