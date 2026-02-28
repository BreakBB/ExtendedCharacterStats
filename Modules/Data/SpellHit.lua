local CR_HIT_SPELL = CR_HIT_SPELL
local ECSLoader = ECSLoader
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetSpellHitModifier = GetSpellHitModifier
local IsClassic = ECS.IsClassic
local IsSoD = ECS.IsSoD
local IsWotlk = ECS.IsWotlk
local max = math.max
local min = math.min
local UnitClass = UnitClass

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _SpellHit = {}
local _, _, classId = UnitClass("player")

---@param school number
---@param levelDifference number
---@param IsPvP boolean
---@return number
function Data:SpellMissChance(school,levelDifference,IsPvP)
    -- https://royalgiraffe.github.io/resist-guide
    local missChance = 0
    local minimumMissChance = IsWotlk and 0 or 1
    local maximumMissChance = 90 -- uncertain, may be different for PvP

    if levelDifference >= -3 and levelDifference <= 2 then
        missChance = 4 + levelDifference
    elseif levelDifference >= 3 then
        missChance = 6 + (IsPvP and 7 or 11)*(levelDifference - 2)
    end

    missChance = missChance - _SpellHit:GetSpellHitBonus(school)
    missChance = max(missChance,minimumMissChance)
    missChance = min(missChance,maximumMissChance)

    return missChance
end

---@param school number
---@return string
function Data:SpellMissChanceSameLevel(school)
    return DataUtils:Round(Data:SpellMissChance(school,0,false), 2) .. "%"
end

---@param school number
---@return string
function Data:SpellMissChanceBossLevel(school)
    return DataUtils:Round(Data:SpellMissChance(school,3,false), 2) .. "%"
end

---If a talent spell has the "Apply Aura: Modifies Hit Chance" effect, then we need to handle it here.
---If the effect is "Apply Aura: Mod Spell Hit Chance %", then GetSpellHitModifier() already accounts for it and we don't need to handle it here.
---@param school number
---@return number
function _SpellHit:GetTalentSpellHitBonus(school)
    local bonus = 0

    if classId == Data.DRUID then
            bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({33592,33596}) -- Balance of Power
    elseif classId == Data.DEATHKNIGHT then
        if IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({48962,49567,49568}) -- Virulence
        end
    elseif classId == Data.MAGE then
        if IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({29438,29439,29440}) -- Elemental Precision
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({11222,12839,12840}) -- Arcane Focus
        else
            if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL) then
                local coeff = IsClassic and 2 or 1
                bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({29438,29439,29440}) -- Elemental Precision
            elseif school == Data.ARCANE_SCHOOL then
                bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({11222,12839,12840,12841,12842}) -- Arcane Focus
            end
        end
    elseif classId == Data.PALADIN then
        if IsWotlk then
            bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({53556,53557}) -- Enlightened Judgements
        end
    elseif classId == Data.PRIEST then
        if school == Data.SHADOW_SCHOOL then
            local coeff = IsWotlk and 1 or 2
            bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({15260,15327,15328}) -- Shadow Focus
        end
    elseif classId == Data.SHAMAN then
        if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL or school == Data.NATURE_SCHOOL) then
            local coeff = IsWotlk and 1 or 2
            bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({30672,30673,30674}) -- Elemental Precision
        end
        if IsClassic then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({16180,16196,16198}) -- Nature's Guidance
        end
    elseif classId == Data.WARLOCK then
        if IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({18174,18175,18176}) -- Suppression
        end
    end

    return bonus
end

---@return number
function _SpellHit:GetSpellHitBonus(school)
    local hit = _SpellHit:GetTalentSpellHitBonus(school) +_SpellHit.GetSpellHitFromRunes(school)
    if CR_HIT_SPELL then
        hit = hit + GetCombatRatingBonus(CR_HIT_SPELL)
    end
    -- GetSpellHitModifier returns nil on dungeon entering/teleport
    return hit + (GetSpellHitModifier() or 0)
end

---@param school number
---@return number
function _SpellHit.GetSpellHitFromRunes(school)
    local mod = 0

    if (not IsSoD) then
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
    local hit = _SpellHit:GetSpellHitBonus(school)
    return DataUtils:Round(hit, 2) .. "%"
end

---@return number
function Data:SpellHitRating()
    if (not CR_HIT_SPELL) then
        return 0
    end

    return GetCombatRating(CR_HIT_SPELL)
end
