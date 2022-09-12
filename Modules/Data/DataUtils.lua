---@class DataUtils
local DataUtils = ECSLoader:CreateModule("DataUtils")

--- Rounds every number down to the given decimal places
function DataUtils:Round(num, decimalPlaces)
    if (not num) then
        return 0
    end
    local mult = 10^(decimalPlaces)
    return math.floor(num * mult + 0.5) / mult
end

function DataUtils:IsShapeshifted()
    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL", "PLAYER")
        if spellId == nil then
            break
        end
        if spellId == 5487 or spellId == 9634 or spellId == 768 then
            return true
        end
    end
    return false
end

function DataUtils:GetMissChanceByDifference(weaponSkill, defenseValue)
    if (defenseValue - weaponSkill) <= 10 then
        return 5 + (defenseValue - weaponSkill) * 0.1
    elseif ECS.IsWotlk then
        return 5 + (defenseValue - weaponSkill) * 0.2
    else
        return 6 + (defenseValue - weaponSkill) * 0.2
    end
end

function DataUtils:GetEnchantForEquipSlot(equipSlot)
    local slotId, _ = GetInventorySlotInfo(equipSlot)
    local itemLink = GetInventoryItemLink("player", slotId)

    return DataUtils:GetEnchantFromItemLink(itemLink)
end

function DataUtils:GetEnchantFromItemLink(itemLink)
    if itemLink then
        local _, itemStringLink = GetItemInfo(itemLink)
        if itemStringLink then
            local _, _, enchant = string.find(itemStringLink, "item:%d+:(%d*)")
            return enchant
        end
    end

    return nil
end

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
