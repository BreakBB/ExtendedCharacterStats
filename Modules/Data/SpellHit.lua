---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _SpellHit = {}
local _, _, classId = UnitClass("player")

---@param school number
---@return string
function Data:SpellMissChanceSameLevel(school)
    local missChance = ECS.IsWotlk and 3 or 4

    missChance = missChance - _SpellHit:GetTalentSpellHitBonus(school)
    local mod = _SpellHit:GetSpellHitBonus(school)
    missChance = missChance - mod

    if ECS.IsWotlk and missChance < 0 then
        missChance = 0
    elseif (not ECS.IsWotlk) and missChance < 1 then
        missChance = 1
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@param school number
---@return string
function Data:SpellMissChanceBossLevel(school)
    local missChance = 17

    missChance = missChance - _SpellHit:GetTalentSpellHitBonus(school)
    local mod = _SpellHit:GetSpellHitBonus(school)
    missChance = missChance - mod

    if ECS.IsWotlk and missChance < 0 then
        missChance = 0
    elseif (not ECS.IsWotlk) and missChance < 1 then
        missChance = 1
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@param school number
---@return number
function _SpellHit:GetTalentSpellHitBonus(school)
    local bonus = 0

    if classId == Data.PRIEST then
        if ECS.IsWotlk then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
            bonus = points -- 0-3% from Shadow Focus
        elseif school == Data.SHADOW_SCHOOL then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
            bonus = points * 2 -- 0-10% from Shadow Focus
        end
    end

    if ECS.IsTBC and classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
        bonus = points * 1 -- 0-3% Precision
    end

    if classId == Data.MAGE then
        if ECS.IsWotlk then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 17)
            bonus = points * 1 -- 0-3% from Elemental Precision
        elseif school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 17)
            bonus = points * 2 -- 0-6% from Elemental Precision
        elseif school == Data.ARCANE_SCHOOL then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 3)
            bonus = points * 2 -- 0-10% from Arcane Focus
        end
    end

    if ECS.IsWotlk and classId == Data.SHAMAN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 16)
        bonus = points -- 0-3% from Elemental Precision
    end

    if ECS.IsWotlk and classId == Data.DRUID then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 13)
        bonus = points * 2 -- 0-4% from Balance of Power
    end

    if ECS.IsWotlk and classId == Data.WARLOCK then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 5)
        bonus = points -- 0-3% from Suppression
    end

    return bonus
end

---@return number
function _SpellHit:GetSpellHitBonus(school)
    if CR_HIT_SPELL then
        return GetCombatRatingBonus(CR_HIT_SPELL) + _SpellHit:GetSpellHitFromBuffs()
    end
    -- GetSpellHitModifier returns nil on dungeon entering/teleport
    return (GetSpellHitModifier() or 0) + _SpellHit.GetHitFromRunes(school)
end

function _SpellHit:GetSpellHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex ("player", i)
        i = i + 1
        if aura and aura.spellId then

            if aura.spellId == 28878 then
                mod = mod + 1 -- 1% from Inspiring Presence
                otherDraeneiInGroup = true
            end

            if aura.spellId == 30708 then
                mod = mod + 3 -- 3% from Totem of Wrath
            end
        end
    until (not aura)

    if (not otherDraeneiInGroup) and (IsSpellKnown(28878) or IsSpellKnown(6562)) then
        mod = mod + 1
    end

    return mod
end

---@param school number
---@return number
function _SpellHit.GetHitFromRunes(school)
    local mod = 0

    if (not ECS.IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if school == Data.ARCANE_SCHOOL and (finger1Rune == 7514 or finger2Rune == 7514) then
        mod = mod + 6 -- 6% from Arcane Combat Specialization Rune
    elseif school == Data.FIRE_SCHOOL and (finger1Rune == 7515 or finger2Rune == 7515) then
        mod = mod + 6 -- 6% from Fire Specialization Rune
    elseif school == Data.FROST_SCHOOL and (finger1Rune == 7516 or finger2Rune == 7516) then
        mod = mod + 6 -- 6% from Frost Specialization Rune
    elseif school == Data.NATURE_SCHOOL and (finger1Rune == 7517 or finger2Rune == 7517) then
        mod = mod + 6 -- 6% from Frost Specialization Rune
    elseif school == Data.SHADOW_SCHOOL and (finger1Rune == 7518 or finger2Rune == 7518) then
        mod = mod + 6 -- 6% from Shadow Specialization Rune
    elseif school == Data.HOLY_SCHOOL and (finger1Rune == 7519 or finger2Rune == 7519) then
        mod = mod + 6 -- 6% from Holy Specialization Rune
    end

    return mod
end

---@param school number
---@return string
function Data.SpellHitBonus(school)
    local hit = _SpellHit:GetTalentSpellHitBonus(school)
    local mod = _SpellHit:GetSpellHitBonus(school)
    hit = hit + mod

    return DataUtils:Round(hit, 2) .. "%"
end

---@return number
function Data:SpellHitRating()
    return GetCombatRating(CR_HIT_SPELL)
end
