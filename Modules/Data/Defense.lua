---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Defense = {}

local _, _, classId = UnitClass("player")

local MAX_SKILL = (UnitLevel("player")) * 5
-- A tank needs to reduce the chance to be critically hit by 5.6% to achieve crit immunity
local CRIT_IMMUNITY_CAP = 5.6
-- Every 25 defense reduce the chance to be critically hit by 1 %
local DEFENSE_FOR_CRIT_REDUCTION = 25


---@return number
function Data:GetArmorValue()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

---@return number
function _Defense:GetCritReduction()
    local defBonus = Data:GetDefenseValue()

    local talentBonus = 0
    if classId == Data.DRUID then
        if ECS.IsWotlk then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 18)
            talentBonus = points * 2 -- 0-6% from Survival of the Fittest
        elseif ECS.IsTBC then
            local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 16)
            talentBonus = points * 1 -- 0-3% from Survival of the Fittest
        end
    end

    -- Only the defense value above 350 counts towards crit immunity
    local critReductionFromDefense =  (defBonus - MAX_SKILL) / DEFENSE_FOR_CRIT_REDUCTION
    if critReductionFromDefense < 0 then
        critReductionFromDefense = 0
    end
    local critReducingFromResilience = GetCombatRatingBonus(15)

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

---@return number
function _Defense:GetEnemyMissChance()
    local enemyAttackRating = (UnitLevel("player")) * 5

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

---@return number
function _Defense:GetAvoidance()
    return _Defense:GetEnemyMissChance() + _Defense:GetBlockChance() + _Defense:GetParryChance() + _Defense:GetDodgeChance()
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

---@return string
function Data:GetAvoidance()
    return DataUtils:Round(_Defense:GetAvoidance(), 2) .. "%"
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
