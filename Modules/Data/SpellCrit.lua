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
    local itemBonus = _SpellCrit:GetItemModifierBySchool(school)
    local setBonus = _SpellCrit:GetSetBonus(school)

    if ECS.IsWotlk then
        crit = crit + GetCombatRatingBonus(CR_CRIT_SPELL) + GetSpellCritChanceFromIntellect("player") + itemBonus + setBonus
    else
        crit = crit + GetSpellCritChance(school) + itemBonus + setBonus
    end

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
        mod = mod + DataUtils:GetTalentBonus({15060,15059,15058},{3,2,1}) -- Arcane Instability
    elseif classId == Data.DRUID then
        if ECS.IsWotlk then
            mod = mod + DataUtils:GetTalentBonus({33883,33882,33881},{3,2,1}) -- Natural Perfection
        end
    elseif classId == Data.WARLOCK then
        if ECS.IsWotlk then
            mod = mod + DataUtils:GetTalentBonus({30248,30247,30246,30245,30242},{10,8,6,4,2}) -- Demonic Tactics
            mod = mod + DataUtils:GetTalentBonus({34939,34938,34935},{3,2,1}) -- Backlash
        end

        mod = mod + DataUtils:GetTalentBonus({18134,18133,18132,18131,18130},{5,4,3,2,1}) -- Devastation
    elseif classId == Data.SHAMAN then
        if ECS.IsWotlk then
            mod = mod + DataUtils:GetTalentBonus({16305,16304,16303,16302,16255},{5,4,3,2,1}) -- Thundering Strikes
        end
    elseif classId == Data.PALADIN then
        if ECS.IsWotlk then
            mod = mod + DataUtils:GetTalentBonus({20121,20120,20119,20118,20117},{5,4,3,2,1}) -- Conviction
            mod = mod + DataUtils:GetTalentBonus({35397,35396,32043},{3,2,1}) -- Sanctity of Battle
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
    local talents = nil
    local talentBonus = nil

    if classId == Data.PRIEST then
        -- Holy Specialization
        talents = {15011,15010,15009,15008,14889}
        talentBonus = {5,4,3,2,1}
    elseif classId == Data.PALADIN then
        -- Holy Power
        talents = {25829,5926,5925,5924,5923}
        talentBonus = {5,4,3,2,1}
    end

    if talents and talentBonus then
        mod = DataUtils:GetTalentBonus(talents,talentBonus)
    end

    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == Data.MAGE then
        mod = mod + DataUtils:GetTalentBonus({11368,11367,11115},{6,4,2}) -- Critical Mass

        if ECS.IsWotlk then
            mod = mod + DataUtils:GetTalentBonus({34296,34295,34293},{3,2,1}) -- Pyromaniac
        end
    elseif classId == Data.WARLOCK then
        if ECS.IsClassic then
            -- Devastation (while this increases the crit chance of "Destruction spells" there are no fire spells, which are not destruction spells)
            mod = mod + DataUtils:GetTalentBonus({18134,18133,18132,18131,18130},{5,4,3,2,1})
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
