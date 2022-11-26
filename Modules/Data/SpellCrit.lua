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

        if spellId == 24907 then
            mod = mod + 5 -- 5% from Moonkin Aura
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
        if (not ECS.IsWotlk) and spellId == 30482 then
            mod = mod + 3 -- 3% from Molten Armor
        end
        if (ECS.IsWotlk and spellId == 51466) then
            mod = mod + 3 -- 3% from Elemental Oath Rank 1
        end
        if (ECS.IsWotlk and spellId == 51470) then
            mod = mod + 5 -- 5% from Elemental Oath Rank 2
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
        local talentSlot = ECS.IsWotlk and 17 or 15;
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
    if classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
        mod = points * 1 -- 0-5% Holy Power
    end

    return mod
end

---@return number
function _SpellCrit:GetTalentModifierFireCrit()
    local mod = 0

    if classId == Data.MAGE then
        local talentSlot = ECS.IsWotlk and 11 or 13;
        local _, _, _, _, criticalMassPoints, _, _, _ = GetTalentInfo(2, talentSlot)
        mod = criticalMassPoints * 2 -- 0-6% Critical Mass

        if ECS.IsWotlk then
            local _, _, _, _, pyromaniacPoints, _, _, _ = GetTalentInfo(2, 20)
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
