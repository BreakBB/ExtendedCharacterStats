---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Defense = {}

local _, _, classId = UnitClass("player")
local MAX_SKILL_LINES = 75 -- Something high, because we stop if we are too far

local LEVEL_70_MAX_SKILL = 350
-- A tank needs to reduce the chance to be critically hit by 5.6% to achieve crit immunity
local CRIT_IMMUNITY_CAP = 5.6
-- Every 25 defense reduce the chance to be critically hit by 1 %
local DEFENSE_FOR_CRIT_REDUCTION = 25
-- Every 39.4231 resilience reduce the chance to be critically hit by 1 %
local RESILIENCE_FOR_CRIT_REDUCTION = 39.4231


---@return number
function Data:GetArmorValue()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

---@return number
function _Defense:GetCritReduction()
    local defSkillRank, defSkillModifier = _Defense:GetDefenseValues()
    local resilience = Data:GetResilienceRating()

    local defBonus = defSkillRank + defSkillModifier

    local talentBonus = 0
    if classId == Data.DRUID then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 16)
        talentBonus = points * 1 -- 0-3% from Survival of the Fittest
    end

    -- Only the defense value above 350 counts towards crit immunity
    local critReductionFromDefense =  (defBonus - LEVEL_70_MAX_SKILL) / DEFENSE_FOR_CRIT_REDUCTION
    if critReductionFromDefense < 0 then
        critReductionFromDefense = 0
    end
    local critReducingFromResilience = resilience / RESILIENCE_FOR_CRIT_REDUCTION

    return critReductionFromDefense + critReducingFromResilience + talentBonus
end

---@return string
function Data:GetCritImmunity()
    local critReduction = _Defense:GetCritReduction()
    local critImmunity = critReduction / CRIT_IMMUNITY_CAP * 100

    if critImmunity < 0 then
        critImmunity = 0
    end

    return DataUtils:Round(critImmunity, 2) .. "%"
end

---@return string
function Data:GetCritReduction()
    return DataUtils:Round(_Defense:GetCritReduction(), 2) .. "%"
end

---@return string
function Data:GetAvoidance()
    local defenseRank, defenseModifier = _Defense:GetDefenseValues()
    local enemyAttackRating = (UnitLevel("player") + 3) * 5
    local enemyMissChance = 5 + (((defenseRank + defenseModifier) - enemyAttackRating) * .04)
    local avoidance = enemyMissChance + GetDodgeChance() + GetParryChance() + GetBlockChance()
    return DataUtils:Round(avoidance, 2) .. "%"
end

---@return number
function Data:GetDefenseRating()
    return DataUtils:Round(GetCombatRating(CR_DEFENSE_SKILL), 2)
end

---@return table<number, number>
function _Defense:GetDefenseValues()
    local skillRank = 0
    local skillModifier = 0

    for i = 1, MAX_SKILL_LINES do
        local skillName, isHeader, _, rank, _, modifier  = GetSkillLineInfo(i)
        if (not skillName) then
            -- We exceeded the available skill lines
            break
        end

        if (not isHeader) and (skillName == DEFENSE) then
            skillRank = rank
            skillModifier = modifier
            break
        end
    end

    if ECS.IsWotlk then
        skillModifier = skillModifier + math.floor(GetCombatRatingBonus(CR_DEFENSE_SKILL))
    end

    return skillRank, skillModifier
end

---@return string
function Data:GetDefenseValueString()
    local skillRank, skillModifier = _Defense:GetDefenseValues()
    return skillRank .. " + " .. skillModifier
end


---@return string
function Data:GetDodgeChance()
    return DataUtils:Round(GetDodgeChance(), 2) .. "%"
end

---@return string
function Data:GetParryChance()
    return DataUtils:Round(GetParryChance(), 2) .. "%"
end

---@return string
function Data:GetBlockChance()
    return DataUtils:Round(GetBlockChance(), 2) .. "%"
end

---@return number
function Data:GetBlockValue()
    local setBonus = _Defense:GetItemModifierBlockValue()
    local blockValue = GetShieldBlock() + setBonus

    return DataUtils:Round(blockValue, 2)
end

---@return number
function Data:GetResilienceRating()
    return DataUtils:Round(GetCombatRating(15), 2)
end

function _Defense:GetItemModifierBlockValue()
    local mod = 0

    if Data:HasSetBonusModifierBlockValue() then
        mod = mod + 30
    end

    return mod
end