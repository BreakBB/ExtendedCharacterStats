---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _GetTalentModifierDefense


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


    skillModifier = skillModifier + _GetTalentModifierDefense()

    return skillRank .. " + " .. skillModifier
end

---@return number
_GetTalentModifierDefense = function()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == Data.WARRIOR then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 2)
        mod = points * 2 -- 0-10 Anticipation
    end

    return mod
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
    return DataUtils:Round(GetShieldBlock(), 2)
end
