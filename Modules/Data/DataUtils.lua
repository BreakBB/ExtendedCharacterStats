---@class DataUtils
local DataUtils = ECSLoader:CreateModule("DataUtils")
---@type Data
local Data = ECSLoader:ImportModule("Data")

--- Rounds every number down to the given decimal places
---@param num number
---@param decimalPlaces number
---@return number
function DataUtils:Round(num, decimalPlaces)
    if (not num) then
        return 0
    end
    local mult = 10^(decimalPlaces)
    return math.floor(num * mult + 0.5) / mult
end

---@return boolean
function DataUtils:IsShapeshifted()
    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            if Data.Aura.IsFeralForm[aura.spellId] then
                return true
            end
        end
    until (not aura)
    return false
end

---@param weaponSkill number
---@param defenseValue number
---@return number
function DataUtils.GetMissChanceByDifference(weaponSkill, defenseValue)
    local delta = defenseValue - weaponSkill
    if delta <= 10 then
        -- For a difference of 0-10 each point in weapon skill is worth 0.1% miss chance reduction
        return 5 + delta * 0.1
    elseif delta <= 14 then
        -- For a difference of 11-14 each point in weapon skill is worth 0.4% miss chance reduction
        local extraWeaponSkillDifference = ((15 - delta) * 0.2)
        return DataUtils:Round(6 + delta * 0.2 - extraWeaponSkillDifference, 2)
    elseif ECS.IsWotlk then
        -- For a difference of 15+ each point in weapon skill is worth 0.2% miss chance reduction
        return 5 + delta * 0.2
    else
        -- For a difference of 15+ each point in weapon skill is worth 0.2% miss chance reduction
        return 6 + delta * 0.2
    end
end

---@param level number
---@param weaponSkill number
---@param defenseValue number
---@return number
function DataUtils:GetGlancingChanceByDifference(level, weaponSkill, defenseValue)
    local glancingChance = 0.1 + (defenseValue - math.min(level*5, weaponSkill)) * 0.02

    -- Ensure the glancing chance does not exceed 1.0 (100%)
    if glancingChance > 1.0 then
        glancingChance = 1.0
    end
    return glancingChance
end

---@param weaponSkill number
---@param defenseValue number
---@return number
function DataUtils:GetGlancingDamage(weaponSkill, defenseValue)
    local difference = defenseValue - weaponSkill
    local low = math.min(0.91 ,(1.3 - 0.05 * difference))

    -- Ensure low does not go below 0.01
    if low < 0.01 then
        low = 0.01
    end
    local high = 1.2 - (0.03 * difference)

    if high > 0.99 then
        high = 0.99
    elseif high < 0.2 then
        high = 0.2
    end
    local averageDamageFactor = (high + low) / 2

    -- Ensure the average damage factor is not negative (damage reduction is not > 100%)
    if averageDamageFactor < 0 then
        averageDamageFactor = 0
    end
    return averageDamageFactor
end

---@param equipSlot EquipSlot
---@return number|nil
function DataUtils:GetEnchantForEquipSlot(equipSlot)
    local slotId, _ = GetInventorySlotInfo(equipSlot)
    local itemLink = GetInventoryItemLink("player", slotId)

    return DataUtils:GetEnchantFromItemLink(itemLink)
end

---@param itemLink ItemLink
---@return number|nil
function DataUtils:GetEnchantFromItemLink(itemLink)
    if itemLink then
        local _, itemStringLink = GetItemInfo(itemLink)
        if itemStringLink then
            local _, _, enchant = string.find(itemStringLink, "item:%d+:(%d*)")
            return tonumber(enchant)
        end
    end

    return nil
end

---@param equipSlot EquipSlot
---@return number|nil
function DataUtils.GetRuneForEquipSlot(equipSlot)
    local slotId, _ = GetInventorySlotInfo(equipSlot)
    local runeInfo = C_Engraving.GetRuneForEquipmentSlot(slotId)

    if runeInfo then
        return runeInfo.itemEnchantmentID
    else
        return nil
    end
end

---@param itemLink ItemLink
---@return (number, number, number) | nil
function DataUtils:GetSocketedGemsFromItemLink(itemLink)
    if itemLink then
        local _, itemStringLink = GetItemInfo(itemLink)
        if itemStringLink then
            local _, _, gem1, gem2, gem3 = string.find(itemStringLink, "item:%d*:%d*:(%d*):(%d*):(%d*)")
            return gem1, gem2, gem3
        end
    end

    return nil
end

return DataUtils
