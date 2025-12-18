---@type Data
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
        local talentSlot = ECS.IsWotlk and 17 or 14;
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, talentSlot)
        mod = points * 1 -- 0-3% Arcane Instability
    end

    if classId == Data.DRUID and ECS.IsWotlk then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 18)
        mod = points * 1 -- 0-3% Natural Perfection
    end

    if classId == Data.WARLOCK then
        if ECS.IsWotlk then
            local _, _, _, _, demonicTactics, _, _, _ = GetTalentInfo(2, 21)
            local _, _, _, _, backlash, _, _, _ = GetTalentInfo(3, 17)
            mod = demonicTactics * 1 -- 0-5% Demonic Tactics
            mod = mod + backlash * 1 -- 0-3% Backlash
        end

        local _, _, _, _, devastation, _, _, _ = GetTalentInfo(3, 7)
        mod = mod + devastation * 1 -- 0-5% Devastation
    end

    if ECS.IsWotlk and classId == Data.SHAMAN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 8)
        mod = points * 1 -- 0-5% Thundering Strikes
    end

    if ECS.IsWotlk and classId == Data.PALADIN then
        local _, _, _, _, convictionPoints, _, _, _ = GetTalentInfo(3, 6)
        mod = convictionPoints * 1 -- 0-5% Conviction

        local _, _, _, _, sanctityPoints, _, _, _ = GetTalentInfo(3, 19)
        mod = mod + sanctityPoints * 1 -- 0-3% Sanctity of Battle
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
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 2)
        mod = points * 1 -- 0-5% Holy Specialization
    end
    if classId == Data.PALADIN then
        if ECS.IsClassic then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 13)
            mod = points * 1 -- 0-5% Holy Power
        end
        if ECS.IsTBC then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
            mod = points * 1 -- 0-5% Holy Power
        end
    end

    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == Data.MAGE then
        local _, _, _, _, criticalMassPoints, _, _, _ = GetTalentInfo(2, 11)
        mod = criticalMassPoints * 2 -- 0-6% Critical Mass

        if ECS.IsWotlk then
            local _, _, _, _, pyromaniacPoints, _, _, _ = GetTalentInfo(2, 20)
            mod = mod + (pyromaniacPoints * 1) -- 0-3% Pyromaniac
        end
    end

    if classId == Data.WARLOCK and ECS.IsClassic then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 11)
        mod = points * 1 -- 0-5% Devastation (while this increases the crit chance of "Destruction spells" there are no fire spells, which are not destruction spells)
    end

    return mod
end

function _SpellCrit:GetItemModifierBySchool(school)
    if school == Data.HOLY_SCHOOL then
        return _SpellCrit:GetItemModifierHolyCrit()
    end

    return 0
end

function _SpellCrit:GetItemModifierHolyCrit()
    local mainHand, _ = GetInventoryItemID("player", 16)
    if ECS.IsClassic and mainHand == 18608 then
        return 2 -- 2% Holy Crit from Benediction
    end
    return 0
end

function _SpellCrit:GetSetBonus(school)
    local bonus = 0

    if school == Data.NATURE_SCHOOL and Data:HasNatureCritBonusModifier() then
        bonus = 3 -- 3% Nature Crit from Shaman T2
    end

    return bonus
end

function Data:GetSpellPenetration()
    return DataUtils:Round(GetSpellPenetration(), 2)
end
