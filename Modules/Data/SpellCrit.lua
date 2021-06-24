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

    if ECS.IsTBC then
        crit = crit + GetCombatRatingBonus(CR_CRIT_SPELL) + GetSpellCritChanceFromIntellect("player") + itemBonus + setBonus
    else
        crit = crit + GetSpellCritChance() + itemBonus + setBonus
    end

    crit = crit + _SpellCrit:GetSpellCritFromBuffs()

    return DataUtils:Round(crit, 2) .. "%"
end

function _SpellCrit:GetSpellCritFromBuffs()
    local mod = 0

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 30708 then
            mod = mod + 3 -- 3% from Totem of Wrath
        end

        if spellId == 30165 then
            mod = mod + 3 -- 3% from Elemental Devastation Rank 1
        end
        if spellId == 29177 then
            mod = mod + 6 -- 6% from Elemental Devastation Rank 2
        end
        if spellId == 29178 then
            mod = mod + 9 -- 9% from Elemental Devastation Rank 3
        end
        if spellId == 30482 then
            mod = mod + 3 -- 3% from Molten Armor
        end
    end

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
        local talentSlot = ECS.IsTBC and 17 or 15;
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, talentSlot)
        mod = points * 1 -- 0-3% Arcane Instability
    end

    if ECS.IsTBC and classId == Data.WARLOCK then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 21)
        mod = points * 1 -- 0-5% Demonic Tactics
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
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
        mod = points * 1 -- 0-5% Holy Specialization
    end

    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == Data.MAGE then
        local talentSlot = ECS.IsTBC and 14 or 13;
        local _, _, _, _, criticalMassPoints, _, _, _ = GetTalentInfo(2, talentSlot)
        mod = criticalMassPoints * 2 -- 0-6% Critical Mass

        if ECS.IsTBC then
            local _, _, _, _, pyromaniacPoints, _, _, _ = GetTalentInfo(2, 18)
            mod = mod + (pyromaniacPoints * 1) -- 0-3% Pyromaniac
        end
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
    if mainHand == 18608 then
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
