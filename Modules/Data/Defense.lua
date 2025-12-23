---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Defense = {}

local _, _, classId = UnitClass("player")

local MAX_SKILL = (UnitLevel("player")) * 5
-- Every 25 defense reduce the chance to be critically hit by 1 %
local DEFENSE_FOR_CRIT_REDUCTION = 25


---@return number
function Data:GetArmorValue()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

---@return (number, number, number)
function _Defense:GetCritReduction()
    local defBonus = Data:GetDefenseValue()

    local buffBonus = 0
    local meleeCritReduction = 0
    local rangedCritReduction = 0
    local spellCritReduction = 0
    local i = 1
    repeat
        local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
        i = i + 1
        if aura and aura.spellId then
            buffBonus = buffBonus + (Data.Aura.CritReductionAll[aura.spellId] or 0)
            meleeCritReduction = meleeCritReduction + (Data.Aura.CritReductionMelee[aura.spellId] or 0)
        end
    until (not aura)
    i = 1
    repeat
        local aura = C_UnitAuras.GetAuraDataByIndex("player", i, "HARMFUL")
        i = i + 1
        if aura and aura.spellId then
            buffBonus = buffBonus + (Data.Aura.CritReductionAll[aura.spellId] or 0)
            meleeCritReduction = meleeCritReduction + (Data.Aura.CritReductionMelee[aura.spellId] or 0)
            spellCritReduction = spellCritReduction + (Data.Aura.CritReductionSpell[aura.spellId] or 0)
            if ECS.IsWotlk and aura.spellId == 12579 then
                spellCritReduction = spellCritReduction - 1 * aura.applications -- Winter's Chill
            end
        end
    until (not aura)

    -- Only the defense value above 350 counts towards crit immunity
    local critReductionFromDefense =  (defBonus - MAX_SKILL) / DEFENSE_FOR_CRIT_REDUCTION
    if critReductionFromDefense < 0 then
        critReductionFromDefense = 0
    end
    local critReducingFromResilience = GetCombatRatingBonus(15)

    if classId == Data.DRUID then
        if ECS.IsWotlk then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 18)
            meleeCritReduction = meleeCritReduction + points * 2 -- 0-6% from Survival of the Fittest
        elseif ECS.IsTBC then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 16)
            meleeCritReduction = meleeCritReduction + points * 1 -- 0-3% from Survival of the Fittest
        end
    elseif classId == Data.PRIEST then
        if ECS.IsTBC then
            if IsPlayerSpell(33371) then -- Shadow Resilience 2/2
                spellCritReduction = spellCritReduction + 4
            elseif IsPlayerSpell(14910) then -- Shadow Resilience 1/2
                spellCritReduction = spellCritReduction + 2
            end
        end
    elseif classId == Data.ROGUE then
        if IsPlayerSpell(30893) then -- Sleight of Hand 2/2
            meleeCritReduction = meleeCritReduction + 2
            rangedCritReduction = rangedCritReduction + 2
        elseif IsPlayerSpell(30892) then -- Sleight of Hand 1/2
            meleeCritReduction = meleeCritReduction + 1
            rangedCritReduction = rangedCritReduction + 1
        end
    elseif classId == Data.WARLOCK then
        if ECS.IsTBC or ECS.IsWotlk then
            if IsPlayerSpell(30321) then -- Demonic Resilience 3/3
                meleeCritReduction = meleeCritReduction + 3
                spellCritReduction = spellCritReduction + 3
            elseif IsPlayerSpell(30320) then --  Demonic Resilience 2/3
                meleeCritReduction = meleeCritReduction + 2
                spellCritReduction = spellCritReduction + 2
            elseif IsPlayerSpell(30319) then -- Demonic Resilience 1/3
                meleeCritReduction = meleeCritReduction + 1
                spellCritReduction = spellCritReduction + 1
            end
        end
    end

    if ECS.IsSoD then
        if classId == Data.DRUID or classId == Data.ROGUE then
            local chestRune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Chest)
            if chestRune and (chestRune == 6710 or chestRune == 6972) then
                meleeCritReduction = meleeCritReduction + 6 -- survival of the fittest / Just a Flesh Wound
            end
        end
    end

    meleeCritReduction = meleeCritReduction + critReductionFromDefense + critReducingFromResilience + buffBonus
    rangedCritReduction = rangedCritReduction + critReductionFromDefense + critReducingFromResilience + buffBonus
    spellCritReduction = spellCritReduction + critReducingFromResilience + buffBonus

    return meleeCritReduction, rangedCritReduction, spellCritReduction
end

---@return string
function Data:GetMeleeCritReduction()
    local melee, _, _ = _Defense:GetCritReduction()
    return DataUtils:Round(melee, 2) .. "%"
end

---@return string
function Data:GetRangedCritReduction()
    local _, ranged, _ = _Defense:GetCritReduction()
    return DataUtils:Round(ranged, 2) .. "%"
end

---@return string
function Data:GetSpellCritReduction()
    local _, _, spell = _Defense:GetCritReduction()
    return DataUtils:Round(spell, 2) .. "%"
end

---@param enemyLevel number
---@return number
function _Defense:GetEnemyMissChance(enemyLevel)
    local enemyAttackRating = enemyLevel * 5

    local miss
    if ECS.IsWotlk then
        local defense = math.floor(GetCombatRatingBonus(CR_DEFENSE_SKILL));
        local enemyMissCoef = classId == Data.DRUID and 0.972 or 0.956; -- 0.972 for bears
        local baseMissChance = 5 - (enemyAttackRating - select(1, UnitDefense("player"))) * 0.04; -- vs lvl 80
        if defense > 0 then -- avoid possible division by 0
            local enemyMissChance = baseMissChance + 1 / (0.0625 + enemyMissCoef / (defense * 0.04))
            miss = enemyMissChance
        else
            miss = baseMissChance
        end
    else
        local defense = Data:GetDefenseValue()
        local enemyMissChance = 5 + (((defense) - enemyAttackRating) * .04)
        miss = enemyMissChance
    end
    return miss
end

---@return number
function _Defense:GetBlockChance()
    local block = 0
    if IsPlayerSpell(107) and C_PaperDollInfo.OffhandHasShield() then
       block = GetBlockChance()
    end
    return block
end

---@return number
function _Defense:GetParryChance()
    local parry = 0
    if IsPlayerSpell(3127) or IsPlayerSpell(18848) or IsPlayerSpell(3124) then
        parry = GetParryChance()
    end
    return parry
end

---@return number
function _Defense:GetDodgeChance()
    local dodge = 0
    if IsPlayerSpell(81) then
        dodge = GetDodgeChance()
    end
    return dodge
end

---@param enemyLevel number
---@return number
function _Defense:GetAvoidance(enemyLevel)
    return _Defense:GetEnemyMissChance(enemyLevel) + _Defense:GetBlockChance() + _Defense:GetParryChance() + _Defense:GetDodgeChance()
end

---@return number
function Data:GetDefenseRating()
    return DataUtils:Round(GetCombatRating(CR_DEFENSE_SKILL), 2)
end

---@return number
function Data:GetDefenseValue()
    local skillRank, skillModifier = UnitDefense("player")
    return skillRank + skillModifier
end

---@return string
function Data:GetDodgeChance()
    return DataUtils:Round(_Defense:GetDodgeChance(), 2) .. "%"
end

---@return string
function Data:GetParryChance()
    return DataUtils:Round(_Defense:GetParryChance(), 2) .. "%"
end

---@return string
function Data:GetBlockChance()
    return DataUtils:Round(_Defense:GetBlockChance(), 2) .. "%"
end

---@param enemyLevel number
---@return string
function Data:GetAvoidance(enemyLevel)
    return DataUtils:Round(_Defense:GetAvoidance(enemyLevel), 2) .. "%"
end

---@return number
function Data:GetBlockValue()
    local blockValue = 0
    if C_SpellBook.IsSpellKnown(107) and C_PaperDollInfo.OffhandHasShield() then
        blockValue = blockValue + GetShieldBlock() + _Defense:GetEnchantsBlockValue()
    end
    return DataUtils:Round(blockValue, 2)
end

---@return number
function Data:GetResilienceRating()
    return DataUtils:Round(GetCombatRating(15), 2)
end

---@return number
function _Defense:GetEnchantsBlockValue()
    local mod = 0
    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                mod = mod + (Data.Enchant.BlockValue[itemLink] or 0)
            end
        end
    end
    return mod
end
