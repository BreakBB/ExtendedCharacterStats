---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

-- keep-sorted start case=no
local _, _, classId = UnitClass("player")
local _SpellCrit = {}
local DRUID = Data.DRUID
local MAGE = Data.MAGE
local PALADIN = Data.PALADIN
local PRIEST = Data.PRIEST
local SHAMAN = Data.SHAMAN
local WARLOCK = Data.WARLOCK
-- keep-sorted end

---@param school number
---@return string
function Data:GetSpellCrit(school)
    local crit = _SpellCrit:GetTalentModifier(school)
    crit = crit + _SpellCrit:GetItemModifierBySchool(school)
    crit = crit + _SpellCrit:GetSetBonus(school)
    crit = crit + GetSpellCritChance(school)
    crit = crit + _SpellCrit:GetSpellCritFromBuffs(school)

    return DataUtils:Round(crit, 2) .. "%"
end

---@return number
function _SpellCrit:GetSpellCritFromBuffs(school)
    local mod = 0
    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            mod = mod + (Data.Aura.SpellCrit[aura.spellId] or 0)
            if school == Data.FIRE_SCHOOL then
                if aura.spellId == 28682 then
                    mod = mod + (aura.applications * 10) -- 10% for each stack from Combustion
                elseif aura.spellId == 1213317 then
                    mod = mod + 50 -- Fire Blast
                end
            end
        end
    until (not aura)
    return mod
end

---@param school number
---@return number
function _SpellCrit:GetTalentModifier(school)
    local modifier = _SpellCrit:GetGeneralTalentModifier()
    local modifierForSchool = _SpellCrit:GetTalentModifierBySchool(school)

    return modifier + modifierForSchool
end

---@return number
function _SpellCrit:GetGeneralTalentModifier()
    local mod = 0

    if classId == MAGE then
        if ECS.IsClassic then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[MAGE].ARCANE_INSTABILITY)
        end
    elseif classId == DRUID then
        if ECS.IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[DRUID].NATURAL_PERFECTION)
        end
    elseif classId == WARLOCK then
        if ECS.IsWotlk then
            mod = mod + 2 * DataUtils:GetActiveTalentSpell(Data.Talent[WARLOCK].DEMONIC_TACTICS)
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[WARLOCK].BACKLASH)
        end
    elseif classId == Data.SHAMAN then
        if ECS.IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[SHAMAN].THUNDERING_STRIKES)
        end
    elseif classId == PALADIN then
        if ECS.IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[PALADIN].CONVICTION)
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[PALADIN].SANCTITY_OF_BATTLE)
        end
    end

    return mod
end

---@param school number
---@return number
function _SpellCrit:GetTalentModifierBySchool(school)
    if school == Data.HOLY_SCHOOL then
        return _SpellCrit:GetTalentModifierHolyCrit()
    elseif school == Data.FIRE_SCHOOL then
        return _SpellCrit:GetTalentModifierFireCrit()
    else
        return 0
    end
end

---@return number
function _SpellCrit:GetTalentModifierHolyCrit()
    local mod = 0
    if ECS.IsClassic then
      if classId == PRIEST then
          mod = 1 * DataUtils:GetActiveTalentSpell(Data.Talent[PRIEST].HOLY_SPECIALIZATION)
      elseif classId == PALADIN then
          mod = 1 * DataUtils:GetActiveTalentSpell(Data.Talent[PALADIN].HOLY_POWER)
      end
    end
    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == MAGE then
        if ECS.IsClassic then
          mod = mod + 2 * DataUtils:GetActiveTalentSpell(Data.Talent[MAGE].CRITICAL_MASS)
        elseif ECS.IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[MAGE].PYROMANIAC)
        end
    elseif classId == WARLOCK then
        if ECS.IsClassic then
            -- Devastation (while this increases the crit chance of "Destruction spells" there are no fire spells, which are not destruction spells)
            mod = mod + 1 * DataUtils:GetActiveTalentSpell(Data.Talent[WARLOCK].DEVASTATION)
        end
    end

    return mod
end

---@return number
function _SpellCrit:GetItemModifierBySchool(school)
    if school == Data.HOLY_SCHOOL then
        return _SpellCrit:GetItemModifierHolyCrit()
    end

    return 0
end

---@return number
function _SpellCrit:GetItemModifierHolyCrit()
    local mainHand, _ = GetInventoryItemID("player", 16)
    if ECS.IsClassic and mainHand == 18608 then
        return 2 -- 2% Holy Crit from Benediction
    end
    return 0
end

---@return number
function _SpellCrit:GetSetBonus(school)
    local bonus = 0

    if school == Data.NATURE_SCHOOL and Data:HasNatureCritBonusModifier() then
        bonus = 3 -- 3% Nature Crit from Shaman T2
    end

    return bonus
end

---@return number
function Data:GetSpellPenetration()
    return DataUtils:Round(GetSpellPenetration(), 2)
end

---@return number
function Data:GetSpellCritRating()
    local critRating = 0
    if CR_CRIT_SPELL then
        critRating = GetCombatRating(CR_CRIT_SPELL)
    end
    return DataUtils:Round(critRating, 0)
end