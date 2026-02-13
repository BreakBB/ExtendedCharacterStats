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
    local minimumMissChance = ECS.IsWotlk and 0 or 1
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

---@param school number
---@return number
function _SpellHit:GetTalentSpellHitBonus(school)
    local bonus = 0

    if classId == Data.DRUID then
            bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({33592,33596}) -- Balance of Power
    elseif classId == Data.DEATHKNIGHT then
        if ECS.IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({48962,49567,49568}) -- Virulence
        end
    elseif classId == Data.MAGE then
        if ECS.IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({29438,29439,29440}) -- Elemental Precision
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({11222,12839,12840}) -- Arcane Focus
        else
            if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL) then
                local coeff = ECS.IsClassic and 2 or 1
                bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({29438,29439,29440}) -- Elemental Precision
            elseif school == Data.ARCANE_SCHOOL then
                bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({11222,12839,12840,12841,12842}) -- Arcane Focus
            end
        end
    elseif classId == Data.PALADIN then
        if ECS.IsTBC then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({20189,20192,20193}) -- precision
        elseif ECS.IsWotlk then
            bonus = bonus + 2 * DataUtils:GetActiveTalentSpell({53556,53557}) -- Enlightened Judgements
        end
    elseif classId == Data.PRIEST then
        if school == Data.SHADOW_SCHOOL then
            local coeff = ECS.IsWotlk and 1 or 2
            bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({15260,15327,15328}) -- Shadow Focus
        end
    elseif classId == Data.SHAMAN then
        if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL or school == Data.NATURE_SCHOOL) then
            local coeff = ECS.IsWotlk and 1 or 2
            bonus = bonus + coeff * DataUtils:GetActiveTalentSpell({30672,30673,30674}) -- Elemental Precision
        end
        if ECS.IsTBC then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({16180,16196,16198}) -- Nature's Guidance
        end
    elseif classId == Data.WARLOCK then
        if ECS.IsWotlk then
            bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({18174,18175,18176}) -- Suppression
        end
    end

    return bonus
end

---@return number
function _SpellHit:GetSpellHitBonus(school)
    local hit = _SpellHit:GetTalentSpellHitBonus(school) + _SpellHit:GetSpellHitFromBuffs() +_SpellHit.GetSpellHitFromRunes(school)
    if CR_HIT_SPELL then
        hit = hit + GetCombatRatingBonus(CR_HIT_SPELL)
    end
    -- GetSpellHitModifier returns nil on dungeon entering/teleport
    return hit + (GetSpellHitModifier() or 0)
end

---@return number
function _SpellHit:GetSpellHitFromBuffs()
    local mod = 0

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex ("player", i)
        i = i + 1
        if aura and aura.spellId then
            if aura.spellId == 30708 then
                mod = mod + (ECS.IsTBC and 3 or 0) -- Totem of Wrath
            end
        end
    until (not aura)

    if C_UnitAuras.GetPlayerAuraBySpellID(28878) or C_SpellBook.IsSpellKnown(28878) or ( -- Inspiring Presence
        (C_SpellBook.IsSpellKnown(6562) or C_UnitAuras.GetPlayerAuraBySpellID(6562)) and ECS.IsWotlk -- Heroic Presence
    ) then
        mod = mod + 1
    end

    return mod
end

---@param school number
---@return number
function _SpellHit.GetSpellHitFromRunes(school)
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
    local hit = _SpellHit:GetSpellHitBonus(school)
    return DataUtils:Round(hit, 2) .. "%"
end

---@return number
function Data:SpellHitRating()
    return GetCombatRating(CR_HIT_SPELL)
end
