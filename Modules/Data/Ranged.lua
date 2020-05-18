---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


-- Get ranged crit chance
function Data:RangedCrit()
    return DataUtils:Round(GetRangedCritChance(), 2) .. "%"
end

local function _GetRangeHitBonus()
    local hitValue = 0
    -- From Enchant
    local slotId, _ = GetInventorySlotInfo(Utils.CHAR_EQUIP_SLOTS["Range"])
    local itemLink = GetInventoryItemLink("player", slotId)
    if itemLink then
        local _, itemStringLink = GetItemInfo(itemLink)
        if itemStringLink then
            local _, _, _, _, _, Enchant, _, _, _, _, _, _, _, _ = string.find(itemStringLink,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
            if (Enchant == "2523") then -- 3% Hit from Biznicks 247x128 Accurascope
                hitValue = hitValue + 3
            end
        end
    end
    -- From Items
    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        hitValue = hitValue + hitFromItems
    end

    return hitValue
end

-- Gets the current bonus hit chance
function Data:RangeHitBonus()
    return DataUtils:Round(_GetRangeHitBonus(), 2) .. "%"
end

-- Gets the range hit chance against enemies on the player level
function Data:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = DataUtils:GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

-- Gets the range hit chance against enemies 3 level above the player level
function Data:RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = DataUtils:GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    return DataUtils:Round(missChance, 2) .. "%"
end