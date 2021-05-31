---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Defense = {}


---@return number
function Data:GetArmorValue()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

---@return string
function Data:GetDefenseValue()
    local numSkills = GetNumSkillLines()
    local skillIndex = 0

    for i = 1, numSkills do
        local skillName = select(1, GetSkillLineInfo(i))
        local isHeader = select(2, GetSkillLineInfo(i))

        if (isHeader == nil or (not isHeader)) and (skillName == DEFENSE) then
            skillIndex = i
            break;
        end
    end

    local skillRank = 0
    local skillModifier = 0
    if (skillIndex > 0) then
        skillRank = select(4, GetSkillLineInfo(skillIndex))
        skillModifier = select(6, GetSkillLineInfo(skillIndex))
    end

    if ECS.IsTBC then
        skillModifier = skillModifier + math.floor(GetCombatRatingBonus(CR_DEFENSE_SKILL))
    end

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
function Data:GetResilienceValue()
    return DataUtils:Round(GetCombatRating(15), 2)
end

function _Defense:GetItemModifierBlockValue()
    local mod = 0

    if Data:HasSetBonusModifierBlockValue() then
        mod = mod + 30
    end

    return mod
end