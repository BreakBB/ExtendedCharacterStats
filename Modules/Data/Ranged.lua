---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _IsRangeAttackClass


---@return string
function Data:GetRangeAttackPower()
    if not _IsRangeAttackClass() then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@return boolean
_IsRangeAttackClass = function()
    local _, _, classId = UnitClass("player")

    return classId == Data.WARRIOR or classId == Data.ROGUE or classId == Data.HUNTER
end


---@return string
function Data:RangedCrit()
    return DataUtils:Round(GetRangedCritChance(), 2) .. "%"
end

---@return number
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

---@return string
function Data:RangeHitBonus()
    return DataUtils:Round(_GetRangeHitBonus(), 2) .. "%"
end

---@return string
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

---@return string
function Data:RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = DataUtils:GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    return DataUtils:Round(missChance, 2) .. "%"
end