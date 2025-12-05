---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _MP5 = {}

---@return number
function Data:GetValueFromAuraTooltip(i,type)
    ECS.scanningTooltip:ClearLines()
    ECS.scanningTooltip:SetUnitAura("player",i,type)
    local region = select(5,ECS.scanningTooltip:GetRegions())
    local tooltip = region:GetText()
    return tonumber(string.match(tooltip, '%d[%d,.]*'))
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
                mp5 = mp5 + (Data.enchantsMP5[enchant] or 0)
            end
            -- Check for socketed gems (TODO: check for socket bonus)
            local gem1, gem2, gem3 = DataUtils:GetSocketedGemsFromItemLink(itemLink)
            if gem1 then
                mp5 = mp5 + (Data.gemsMP5[gem1] or 0)
            end
            if gem2 then
                mp5 = mp5 + (Data.gemsMP5[gem2] or 0)
            end
            if gem3 then
                mp5 = mp5 + (Data.gemsMP5[gem3] or 0)
            end
        end
    end

    -- Check weapon enchants (e.g. Mana Oil)
    local hasMainEnchant, _, _, mainHandEnchantID = GetWeaponEnchantInfo()
    mainHandEnchantID = tostring(mainHandEnchantID)
    if (hasMainEnchant) then
        mp5 = mp5 + (Data.enchantsMP5[mainHandEnchantID] or 0)
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

    local _, mp5BuffBonus = Data:GetMP5FromBuffs()
    local mp5Items = Data:GetMP5FromItems()
    casting = (casting * 5) + mp5Items + mp5BuffBonus

    return DataUtils:Round(casting, 2)
end

function Data:GetMP5OutsideCasting()
    local mp5FromSpirit = Data:GetMP5FromSpirit()
    local _, mp5BuffBonus = Data:GetMP5FromBuffs()
    local mp5FromItems = Data:GetMP5FromItems()

    local totalMP5 = mp5FromSpirit + mp5FromItems + mp5BuffBonus
    return DataUtils:Round(totalMP5, 2)
end

---@return number, number
function Data:GetMP5FromBuffs()
    local mod = 0
    local bonus = 0

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            bonus = bonus + (Data.BuffsMP5[aura.spellId] or 0)
            if Data.BuffsIsLightningShield[aura.spellId] and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
                bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
            end
            if Data.BuffsIsMageArmor[aura.spellId] then
                mod = mod + 0.3 -- 30% from Mage Armor
            elseif Data.BuffsMP5Tooltip[aura.spellId] then
                bonus = bonus + Data:GetValueFromAuraTooltip(i,"HELPFUL")
            end
            if ECS.IsWotlk then
                if aura.spellId == 64999 then
                    bonus = bonus + 85 * aura.applications -- Meteoric Inspiration
                end
            end
        end
    until (not aura)

    return mod, bonus
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
