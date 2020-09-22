---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local function _GetTalentModifierSpellHit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 5 then -- Priest
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 5)
        mod = points * 2 -- 0-10% from Shadow Focus
    end

    if classId == 8 then -- Mage
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
        mod = points * 2 -- 0-6% from Elemental Precision
    end

    return mod
end

function Data:SpellHitBonus()
    local hit = _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        hit = hit + mod
    end

    return DataUtils:Round(hit, 2) .. "%"
end

function Data:SpellMissChanceSameLevel()
    local missChance = 4

    missChance = missChance - _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        missChance = missChance - mod
    end

    if missChance < 1 then
        missChance = 1
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

function Data:SpellMissChanceBossLevel()
    local missChance = 17

    missChance = missChance - _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        missChance = missChance - mod
    end

    if missChance < 1 then
        missChance = 1
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end