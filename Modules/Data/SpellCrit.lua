local ECSLoader = ECSLoader
local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetInventoryItemID = GetInventoryItemID
local GetSpellCritChance = GetSpellCritChance
local IsClassic = ECS.IsClassic
local IsWotlk = ECS.IsWotlk

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _SpellCrit = {}

local _, _, classId = UnitClass("player")

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
        local aura = GetBuffDataByIndex("player", i)
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

    if classId == Data.MAGE then
        if not IsClassic then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({15058,15059,15060}) -- Arcane Instability
        end
    elseif classId == Data.DRUID then
        if IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({33881,33882,33883}) -- Natural Perfection
        end
    elseif classId == Data.WARLOCK then
        if IsWotlk then
            mod = mod + 2 * DataUtils:GetActiveTalentSpell({30242,30245,30246,30247,30248}) -- Demonic Tactics
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({34935,34938,34939}) -- Backlash
        end

        mod = mod + 1 * DataUtils:GetActiveTalentSpell({18130,18131,18132,18133,18134}) -- Devastation
    elseif classId == Data.SHAMAN then
        if IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({16255,16302,16303,16304,16305}) -- Thundering Strikes
        end
    elseif classId == Data.PALADIN then
        if IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({20117,20118,20119,20120,20121}) -- Conviction
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({32043,35396,35397}) -- Sanctity of Battle
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

    if classId == Data.PRIEST then
        -- Holy Specialization
        mod = 1 * DataUtils:GetActiveTalentSpell({14889,15008,15009,15010,15011})
    elseif classId == Data.PALADIN then
        -- Holy Power
        mod = 1 * DataUtils:GetActiveTalentSpell({5923,5924,5925,5926,25829})
    end
    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == Data.MAGE then
        mod = mod + 2 * DataUtils:GetActiveTalentSpell({11115,11367,11368}) -- Critical Mass

        if IsWotlk then
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({34293,34295,34296}) -- Pyromaniac
        end
    elseif classId == Data.WARLOCK then
        if IsClassic then
            -- Devastation (while this increases the crit chance of "Destruction spells" there are no fire spells, which are not destruction spells)
            mod = mod + 1 * DataUtils:GetActiveTalentSpell({18130,18131,18132,18133,18134})
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
    if IsClassic and mainHand == 18608 then
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