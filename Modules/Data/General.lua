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

---@return string
function Data:GetArmorPenetrationFlat()
    local armorPenetration = 0

    if classId == Data.ROGUE and not ECS.IsWotlk then
        if C_SpellBook.IsSpellKnown(14173) then -- Serrated Blades 3/3
            armorPenetration = armorPenetration + playerLevel * 5
        elseif C_SpellBook.IsSpellKnown(14172) then -- Serrated Blades 2/3
            armorPenetration = armorPenetration + playerLevel * 3.4
        elseif C_SpellBook.IsSpellKnown(14171) then -- Serrated Blades 1/3
            armorPenetration = armorPenetration + playerLevel * 1.6
        end
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

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return string
function Data:GetArmorPenetrationPercentage()
    local armorPenetration = GetArmorPenetration()

    if ECS.IsWotlk then
        if classId == Data.WARRIOR then
            local _, isActive = GetShapeshiftFormInfo(1)
            if isActive then
                armorPenetration = armorPenetration + 10 -- 10% from Battle Stance
            end
            -- TODO: mace specialization
        elseif classId == Data.ROGUE then
            if C_SpellBook.IsSpellKnown(14173) then -- Serrated Blades 3/3
                armorPenetration = armorPenetration + 9
            elseif C_SpellBook.IsSpellKnown(14172) then -- Serrated Blades 2/3
                armorPenetration = armorPenetration + 6
            elseif C_SpellBook.IsSpellKnown(14171) then -- Serrated Blades 1/3
                armorPenetration = armorPenetration + 3
            end
            -- TODO: mace specialization
        elseif classId == Data.DEATHKNIGHT then
            if C_SpellBook.IsSpellKnown(61278) then -- Blood Gorged 5/5
                armorPenetration = armorPenetration + 10
            elseif C_SpellBook.IsSpellKnown(61277) then -- Blood Gorged 4/5
                armorPenetration = armorPenetration + 8
            elseif C_SpellBook.IsSpellKnown(61276) then -- Blood Gorged 3/5
                armorPenetration = armorPenetration + 6
            elseif C_SpellBook.IsSpellKnown(61275) then -- Blood Gorged 2/5
                armorPenetration = armorPenetration + 4
            elseif C_SpellBook.IsSpellKnown(61274) then -- Blood Gorged 1/5
                armorPenetration = armorPenetration + 2
            end
        end
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return number
function Data:GetArmorPenetrationRating()
    local armorPenetrationRating = GetCombatRating(CR_ARMOR_PENETRATION)
    return DataUtils:Round(armorPenetrationRating, 0)
end