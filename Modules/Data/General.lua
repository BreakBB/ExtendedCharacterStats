---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _, _, classId = UnitClass("player")
local playerLevel = UnitLevel("player")

---@return string
function Data:GetMovementSpeed()
    local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")

    local currentSpeed

    if (not ECS.IsClassic) and IsFlying() then
        currentSpeed = flightSpeed
    elseif IsSwimming() then
        currentSpeed = swimSpeed
    else
        currentSpeed = runSpeed
    end

    currentSpeed = currentSpeed / 7 * 100
    return DataUtils:Round(currentSpeed, 0) .. "%"
end

---@return number
function Data:GetArmorPenetrationFlat()
    local armorPenetration = 0

    if classId == Data.ROGUE and not ECS.IsWotlk then
        armorPenetration = armorPenetration + playerLevel * 5/3 * DataUtils:GetActiveTalentSpell({14171,14172,14173}) -- Serrated Blades
    end

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            armorPenetration = armorPenetration + (Data.Aura.ReduceTargetArmor[aura.spellId] or 0)
            if not ECS.IsWotlk then
                if aura.spellId == 26481 then
                    armorPenetration = armorPenetration + 200 * aura.applications -- Insight of the Qiraji
                elseif aura.spellId == 21153 then
                    armorPenetration = armorPenetration + 700 * aura.applications -- Bonereaver's Edge
                elseif aura.spellId == 38307 then
                    armorPenetration = armorPenetration + 435 * aura.applications -- The Dark of Night
                end
            end
        end
        i = i + 1
    until (not aura)

    return DataUtils:Round(armorPenetration, 2)
end

---@return string
function Data:GetArmorPenetrationPercentage()
    local armorPenetration = 0

    if ECS.IsWotlk then
        armorPenetration = GetArmorPenetration()
        if classId == Data.WARRIOR then
            local _, isActive = GetShapeshiftFormInfo(1)
            if isActive then
                armorPenetration = armorPenetration + 10 -- 10% from Battle Stance
            end
            -- TODO: mace specialization
        elseif classId == Data.ROGUE then
            armorPenetration = armorPenetration + 3 * DataUtils:GetActiveTalentSpell({14171,14172,14173}) -- Serrated Blades
            -- TODO: mace specialization
        elseif classId == Data.DEATHKNIGHT then
            armorPenetration = armorPenetration + 2 * DataUtils:GetActiveTalentSpell({61274,61275,61276,61277,61278}) -- Blood Gorged
        end
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return number
function Data:GetArmorPenetrationRating()
    local arpen = 0
    if ECS.IsWotlk then
        arpen = GetCombatRating(CR_ARMOR_PENETRATION)
    end
    return arpen
end