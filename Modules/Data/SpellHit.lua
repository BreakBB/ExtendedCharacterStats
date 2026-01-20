---@class Data
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

    if classId == Data.DRUID then
        if C_SpellBook.IsSpellKnown(33596) then
            bonus = bonus + 4 -- Balance of Power Rank 2
        elseif C_SpellBook.IsSpellKnown(33592) then
            bonus = bonus + 2 -- Balance of Power Rank 1
        end
    elseif classId == Data.DEATHKNIGHT then
        if ECS.IsWotlk then
            if C_SpellBook.IsSpellKnown(49568) then
                bonus = bonus + 3 --Virulence Rank 3
            elseif C_SpellBook.IsSpellKnown(49567) then
                bonus = bonus + 2 -- Virulence Rank 2
            elseif C_SpellBook.IsSpellKnown(48962) then
                bonus = bonus + 1 -- Virulence Rank 1
            end
        end
    elseif classId == Data.MAGE then
        if ECS.IsWotlk then
            if C_SpellBook.IsSpellKnown(29440) then
                bonus = bonus + 3 -- Elemental Precision Rank 3
            elseif C_SpellBook.IsSpellKnown(29439) then
                bonus = bonus + 2 -- Elemental Precision Rank 2
            elseif C_SpellBook.IsSpellKnown(29438) then
                bonus = bonus + 1 -- Elemental Precision Rank 1
            end
            if C_SpellBook.IsSpellKnown(12840) then
                bonus = bonus + 3 -- Arcane Focus Rank 3
            elseif C_SpellBook.IsSpellKnown(12839) then
                bonus = bonus + 2 -- Arcane Focus Rank 2
            elseif C_SpellBook.IsSpellKnown(11222) then
                bonus = bonus + 1 -- Arcane Focus Rank 1
            end
        else
            if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL) then
                if C_SpellBook.IsSpellKnown(29440) then
                    bonus = bonus + 6 -- Elemental Precision Rank 3
                elseif C_SpellBook.IsSpellKnown(29439) then
                    bonus = bonus + 4 -- Elemental Precision Rank 2
                elseif C_SpellBook.IsSpellKnown(29438) then
                    bonus = bonus + 2 -- Elemental Precision Rank 1
                end
            elseif school == Data.ARCANE_SCHOOL then
                if C_SpellBook.IsSpellKnown(12842) then
                    bonus = bonus + 10 -- Arcane Focus Rank 5
                elseif C_SpellBook.IsSpellKnown(12841) then
                    bonus = bonus + 8 -- Arcane Focus Rank 4
                elseif C_SpellBook.IsSpellKnown(12840) then
                    bonus = bonus + 6 -- Arcane Focus Rank 3
                elseif C_SpellBook.IsSpellKnown(12839) then
                    bonus = bonus + 4 -- Arcane Focus Rank 2
                elseif C_SpellBook.IsSpellKnown(11222) then
                    bonus = bonus + 2 -- Arcane Focus Rank 1
                end
            end
        end
    elseif classId == Data.PALADIN then
        if ECS.IsTBC then
            if C_SpellBook.IsSpellKnown(20193) then
                bonus = bonus + 3 -- Precision Rank 3
            elseif C_SpellBook.IsSpellKnown(20192) then
                bonus = bonus + 2 -- Precision Rank 2
            elseif C_SpellBook.IsSpellKnown(20189) then
                bonus = bonus + 1 -- Precision Rank 1
            end
        elseif ECS.IsWotlk then
            if C_SpellBook.IsSpellKnown(53557) then
                bonus = bonus + 4 -- Enlightened Judgements Rank 2
            elseif C_SpellBook.IsSpellKnown(53556) then
                bonus = bonus + 2 -- Enlightened Judgements Rank 1
            end
        end
    elseif classId == Data.PRIEST then
        if school == Data.SHADOW_SCHOOL then
            if C_SpellBook.IsSpellKnown(15328) then
                bonus = bonus + (ECS.IsWotlk and 3 or 6) -- Shadow Focus Rank 3
            elseif C_SpellBook.IsSpellKnown(15327) then
                bonus = bonus + (ECS.IsWotlk and 2 or 4) -- Shadow Focus Rank 2
            elseif C_SpellBook.IsSpellKnown(15260) then
                bonus = bonus + (ECS.IsWotlk and 1 or 2) -- Shadow Focus Rank 1
            end
        end
    elseif classId == Data.SHAMAN then
        if (school == Data.FIRE_SCHOOL or school == Data.FROST_SCHOOL or school == Data.NATURE_SCHOOL) then
            if C_SpellBook.IsSpellKnown(30674) then
                bonus = bonus + (ECS.IsWotlk and 3 or 6) -- Elemental Precision Rank 3
            elseif C_SpellBook.IsSpellKnown(30673) then
                bonus = bonus + (ECS.IsWotlk and 2 or 4) -- Elemental Precision Rank 2
            elseif C_SpellBook.IsSpellKnown(30672) then
                bonus = bonus + (ECS.IsWotlk and 1 or 2) -- Elemental Precision Rank 1
            end
        end
        if ECS.IsTBC then
            if C_SpellBook.IsSpellKnown(16198) then
                bonus = bonus + 3 -- Nature's Guidance Rank 3
            elseif C_SpellBook.IsSpellKnown(16196) then
                bonus = bonus + 2 -- Nature's Guidance Rank 2
            elseif C_SpellBook.IsSpellKnown(16180) then
                bonus = bonus + 1 -- Nature's Guidance Rank 1
            end
        end
    elseif classId == Data.WARLOCK then
        if ECS.IsWotlk then
            if C_SpellBook.IsSpellKnown(18176) then
                bonus = bonus + 3 --Suppression Rank 3
            elseif C_SpellBook.IsSpellKnown(18175) then
                bonus = bonus + 2 -- Suppression Rank 2
            elseif C_SpellBook.IsSpellKnown(18174) then
                bonus = bonus + 1 -- Suppression Rank 1
            end
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
