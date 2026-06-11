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
            return tonumber(string.match(tooltip, '%d[%d,.]*'))
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
        end
    end

    -- Check weapon enchants (e.g. Mana Oil)
    local hasMainEnchant, _, _, mainHandEnchantID = GetWeaponEnchantInfo()
    if (hasMainEnchant) then
        mp5 = mp5 + (Data.Enchant.MP5[mainHandEnchantID] or 0)
    end

    return mp5
end

---@return number
function Data:GetMP5FromSpirit()
    local regen
    if ECS.IsClassic then
        -- GetUnitManaRegenRateFromSpirit uses TBC formula in classic
        local _, spirit, _, _ = UnitStat("player", LE_UNIT_STAT_SPIRIT)
        if spirit < 50 then
            regen = 0.25 * spirit
        else
            if classId == Data.PRIEST or classId == Data.MAGE then
                regen = (12.5 + spirit/4)/2
            elseif classId == Data.DRUID and (not DataUtils:IsShapeshifted()) then
                regen = (15 + spirit/4.5)/2
            else
                regen = (15 + spirit/5)/2
            end
        end
    else
        regen = GetUnitManaRegenRateFromSpirit("player")
    end
    return DataUtils:Round(regen * 5, 1)
end

-- Get mana regen while casting
---@return number
function Data:GetMP5CastingModifier()
    local _, castingModifier, _, _ = Data:GetMP5FromBuffs()
    castingModifier = min(1,castingModifier + _MP5:GetTalentModifier() + Data:GetSetBonusModifierMP5()) -- capped at 100%
    return DataUtils:Round(castingModifier, 2)
end

-- Get mana regen while casting
---@return number
function Data:GetMP5WhileCasting()
    -- Returns mana reg per 1 second (including talent and buff casting modifiers)
    local _, casting = GetManaRegen()
    local modifier, _, mp5BuffBonus, periodicMan = Data:GetMP5FromBuffs()
    casting = casting * 5
    if ECS.IsClassic then
        -- in classic GetManaRegen doesn't account for mp5 from items nor buffs
        casting = casting + Data:GetMP5FromItems() + mp5BuffBonus
    end
    casting = casting * modifier + mp5BuffBonus + periodicMana
    return DataUtils:Round(casting, 1)
end

---@return number
function Data:GetMP5OutsideCasting()
    local base, _ = GetManaRegen()
    local modifier, mp5BuffBonus, periodicMana = Data:GetMP5FromBuffs()
    local totalMP5 = base * 5
    if ECS.IsClassic then
        -- in classic GetManaRegen doesn't account for mp5 from items nor buffs
        totalMP5 = totalMP5 + Data:GetMP5FromItems() + mp5BuffBonus
    end
    totalMP5 = totalMP5 * modifier + periodicMana
    return DataUtils:Round(totalMP5, 1)
end

---@return number, number, number
function Data:GetMP5FromBuffs()
    local mod = 1
    local castingMod = 0
    local bonus = 0
    local periodic = 0
    local maxmana = UnitPowerMax("player", Enum.PowerType.Mana)

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            bonus = bonus + (Data.Aura.MP5[aura.spellId] or 0)
            bonus = bonus + (Data.Aura.PercentageMp5[aura.spellId] or 0) * maxmana
            periodic = periodic + (Data.Aura.PeriodicallyGiveMana[aura.spellId] or 0)
            castingMod = castingMod + (Data.Aura.AllowCastingManaRegeneration[aura.spellId] or 0)
            mod = mod + (Data.Aura.PowerRegenPercentModifier[Enum.PowerType.Mana][aura.spellId] or 0)
            if Data.Aura.IsLightningShield[aura.spellId] and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
                bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
            end
            if Data.Aura.MP5Tooltip[aura.spellId] then
                bonus = bonus + Data.Aura.MP5Tooltip[aura.spellId] * Data:GetValueFromAuraTooltip(i, "HELPFUL")
            end
            if Data.Aura.PeriodicallyGiveManaTooltip[aura.spellId] then
                periodic = periodic + Data.Aura.PeriodicallyGiveManaTooltip[aura.spellId] * Data:GetValueFromAuraTooltip(i, "HELPFUL")
            end
            if ECS.IsWotlk then
                if aura.spellId == 64999 then
                    bonus = bonus + 85 * aura.applications -- Meteoric Inspiration
                end
            end
        end
        i = i + 1
    until (not aura)
    i = 1
    repeat
        local aura = C_UnitAuras.GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            bonus = bonus + (Data.Aura.PercentageMp5[aura.spellId] or 0) * maxmana
        end
        i = i + 1
    until (not aura)
    return max(mod,0), min(castingMod,1), bonus, periodic
end

---@return number
function _MP5.GetMP5FromRunes()
    local mod = 0

    if (not ECS.IsSoD) then
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
        local coeff = ECS.IsTBC and 0.1 or (ECS.IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({14521,14776,14777}) -- meditation
    elseif classId == Data.MAGE then
        local coeff = ECS.IsTBC and 0.1 or (ECS.IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({14521,18463,18464}) -- arcane meditation

        if ECS.IsWotlk then
            mod = mod + 0.5/3 * DataUtils:GetActiveTalentSpell({34293,34295,34296}) -- pyromaniac
        end
    elseif classId == Data.DRUID then
        local coeff = ECS.IsTBC and 0.1 or (ECS.IsWotlk and 0.5/3 or 0.05)
        mod = mod + coeff * DataUtils:GetActiveTalentSpell({17106,17107,17108}) -- intensity/reflection
    end
    return mod
end
