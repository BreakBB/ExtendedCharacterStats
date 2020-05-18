---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


function Data:Armor()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

local function _GetTalentModifierDefense()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == Data.WARRIOR then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 2)
        mod = points * 2 -- 0-10 Anticipation
    end

    return mod
end

function Data:Defense()
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

-- Get dodge chance
function Data:Dodge()
    return DataUtils:Round(GetDodgeChance(), 2) .. "%"
end

-- Get parry chance
function Data:Parry()
    return DataUtils:Round(GetParryChance(), 2) .. "%"
end

-- Get block chance
function Data:Block()
    return DataUtils:Round(GetBlockChance(), 2) .. "%"
end
