---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _SpellHit = {}

function Data:SpellMissChanceSameLevel()
    local missChance = 4

    missChance = missChance - _SpellHit:GetTalentModifierSpellHit()
    local mod = _SpellHit:GetSpellHitRating()
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

    missChance = missChance - _SpellHit:GetTalentModifierSpellHit()
    local mod = _SpellHit:GetSpellHitRating()
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

function _SpellHit:GetTalentModifierSpellHit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == Data.PRIEST then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 5)
        mod = points * 2 -- 0-10% from Shadow Focus
    end

    if classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
        if ECS.IsTBC then
            mod = points * 1 -- 0-3% from Elemental Precision
        else
            mod = points * 2 -- 0-6% from Elemental Precision
        end
    end

    if classId == Data.SHAMAN and ECS.IsTBC then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
        mod = points * 2 -- 0-6% from Elemental Precision
    end

    return mod
end

---@return number
function _SpellHit:GetSpellHitRating()
    if CR_HIT_SPELL then
        return GetCombatRatingBonus(CR_HIT_SPELL) + _SpellHit:GetSpellHitFromBuffs()
    end
    return GetSpellHitModifier()
end

function _SpellHit:GetSpellHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 28878 then
            mod = mod + 1 -- 1% from Inspiring Presence
            otherDraeneiInGroup = true
        end

        if spellId == 30708 then
            mod = mod + 3 -- 3% from Totem of Wrath
        end
    end

    if (not otherDraeneiInGroup) and IsSpellKnown(28878) then
        mod = mod + 1
    end

    return mod
end

function Data:SpellHitBonus()
    local hit = _SpellHit:GetTalentModifierSpellHit()
    local mod = _SpellHit:GetSpellHitRating()
    if mod then
        hit = hit + mod
    end

    return DataUtils:Round(hit, 2) .. "%"
end