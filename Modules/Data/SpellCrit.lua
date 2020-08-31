---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _GetTalentModifier, _GetGeneralTalentModifier, _GetTalentModifierBySchool
local _GetTalentModifierHolyCrit, _GetTalentModifierFireCrit
local _GetItemModifierBySchool
local _GetSetBonus

local _, _, classId = UnitClass("player")

---@param school number
---@return string
function Data:GetSpellCrit(school)
    local crit = _GetTalentModifier(school)
    local itemBonus = _GetItemModifierBySchool(school)
    local setBonus = _GetSetBonus(school)
    crit = crit + GetSpellCritChance() + itemBonus + setBonus
    return DataUtils:Round(crit, 2) .. "%"
end

---@param school number
---@return number
_GetTalentModifier = function(school)
    local modifier = _GetGeneralTalentModifier()
    local modifierForSchool = _GetTalentModifierBySchool(school)

    return modifier + modifierForSchool
end

---@return number
_GetGeneralTalentModifier = function()
    local mod = 0

    if classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
        mod = points * 1 -- 0-3% Arcane Instability
    end

    return mod
end

---@param school number
---@return number
_GetTalentModifierBySchool = function(school)
    if school == Data.HOLY_SCHOOL then
        return _GetTalentModifierHolyCrit()
    elseif school == Data.FIRE_SCHOOL then
        return _GetTalentModifierFireCrit()
    else
        return 0
    end
end

---@return number
_GetTalentModifierHolyCrit = function()
    local mod = 0

    if classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 13)
        mod = points * 1 -- 0-5% Holy Power
    elseif classId == Data.PRIEST then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
        mod = points * 1 -- 0-5% Holy Specialization
    end

    return mod
end

---@return number
_GetTalentModifierFireCrit = function()
    local mod = 0

    if classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 13)
        mod = points * 2 -- 0-6% Critical Mass
    end

    return mod
end

_GetItemModifierBySchool = function(school)
    if school == Data.HOLY_SCHOOL then
        return _GetItemModifierHolyCrit()
    end

    return 0
end

_GetItemModifierHolyCrit = function()
    local mainHand, _ = GetInventoryItemID("player", 16)
    if mainHand == 18608 then
        return 2 -- 2% Holy Crit from Benediction
    end
    return 0
end

_GetSetBonus = function(school)
    local bonus = 0

    if school == Data.NATURE_SCHOOL and Data:HasNatureCritBonusModifier() then
        bonus = 3 -- 3% Nature Crit from Shaman T2
    end

    return bonus
end
