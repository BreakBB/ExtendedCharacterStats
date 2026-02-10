---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Melee = {}
local _, _, classId = UnitClass("player")

---@return number
function Data:GetMeleeAttackPower()
    local melee, posBuff, negBuff = UnitAttackPower("player")
    return melee + posBuff + negBuff
end

---@return number
function Data:GetMeleeAttackSpeedMainHand()
    local mainHand, _ = UnitAttackSpeed("player")
    return DataUtils:Round(mainHand, 2)
end

---@return number
function Data:GetMeleeAttackSpeedOffHand()
    local _, offHand = UnitAttackSpeed("player")
    return DataUtils:Round(offHand, 2)
end

---@return string
function Data:MeleeCrit()
    return DataUtils:Round(GetCritChance(), 2) .. "%"
end

---@return string
function Data:MeleeHitBonus()
    return DataUtils:Round(_Melee:GetHitRatingBonus(), 2) .. "%"
end

---@return number
function Data:MeleeHitRating()
    return GetCombatRating(CR_HIT_MELEE)
end

---@return number
function _Melee:GetHitRatingBonus()
    if CR_HIT_MELEE then
        return GetCombatRatingBonus(CR_HIT_MELEE) + _Melee:GetHitTalentBonus() + _Melee:GetHitFromBuffs()
    end
    -- GetHitModifier returns nil on dungeon entering/teleport
    return (GetHitModifier() or 0) + _Melee.GetHitFromRunes()
end

---@return number
function _Melee:GetHitTalentBonus()
    local mod = 0
    local talents = nil
    local talentBonus = nil

    if classId == Data.WARRIOR then
        if ECS.IsWotlk then
            -- precision
            talents = {29592,29591,29590}
            talentBonus = {3,2,1}
        end
    elseif classId == Data.HUNTER then
        if ECS.IsWotlk then
            -- focused aim
            talents = {53622,53621,53620}
            talentBonus = {3,2,1}
        end
    elseif classId == Data.SHAMAN then
        if ECS.IsWotlk then
            -- Dual Wield Specialization
            if Data:GetMeleeAttackSpeedOffHand() > 0 then
                talents = {30819,30818,30816}
                talentBonus = {6,4,2}
            end
        else
            -- Nature's Guidance
            talents = {16198,16196,16180}
            talentBonus = {3,2,1}
        end
    elseif classId == Data.PALADIN then
        if ECS.IsTBC then
            -- precision
            talents = {20193,20192,20189}
            talentBonus = {3,2,1}
        end
    elseif classId == Data.ROGUE then
        -- precision
        talents = {13845,13844,13843,13832,13705}
        talentBonus = {5,4,3,2,1}
    elseif classId == Data.DEATHKNIGHT then
        -- Nerves of Cold Steel
        -- This assumes a DK is dual wielding and not only using a one-hand main hand weapon
        if Data:GetMeleeAttackSpeedOffHand() > 0 then
            talents = {50138,50137,49226}
            talentBonus = {3,2,1}
        end
    end

    if talents and talentBonus then
        mod = DataUtils:GetTalentBonus(talents,talentBonus)
    end

    return mod
end

---@return number
function _Melee:GetHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex ("player", i)
        i = i + 1
        if aura and aura.spellId then

            if aura.spellId == 6562 then
                mod = mod + 1 -- 1% from Heroic Presence
                otherDraeneiInGroup = true
            end
        end
    until (not aura)

    if (not otherDraeneiInGroup) and (C_SpellBook.IsSpellKnown(6562) or C_SpellBook.IsSpellKnown(28878)) then
        mod = mod + 1
    end

    return mod
end

---@return number
function _Melee.GetHitFromRunes()
    local mod = 0

    if (not ECS.IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if classId == Data.DRUID and (finger1Rune == 7520 or finger2Rune == 7520) and DataUtils:IsShapeshifted() then
        mod = mod + 3 -- 3% from Feral Combat Specialization Rune
    end

    return mod
end

---@return string
function Data:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = 5
    else
        missChance = DataUtils.GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    if Data:GetMeleeAttackSpeedOffHand() > 0 then
        missChance = missChance + 19;
    end

    local hitValue = _Melee:GetHitRatingBonus()
    missChance = missChance - hitValue

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = ECS.IsWotlk and 8 or 9
    else
        missChance = DataUtils.GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    if Data:GetMeleeAttackSpeedOffHand() > 0 then
        missChance = missChance + 19;
    end

    local hitValue = _Melee:GetHitRatingBonus()
    missChance = missChance - hitValue

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

function Data:GlanceHitChanceSameLevel()
    return Data:GlanceHitChanceByLevel(0)
end

function Data:GlanceHitChanceBossLevel()
    return Data:GlanceHitChanceByLevel(3)
end

---@return string
function Data:GlanceHitChanceByLevel(level)
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + level) * 5

    local glancingChance = DataUtils:GetGlancingChanceByDifference(playerLevel, mainBase + mainMod, enemyDefenseValue)

    return DataUtils:Round(glancingChance*100, 2) .. "%"
end

---@return string
function Data:GlanceDamageSameLevel()
    return Data:GlanceDamageByLevel(0)
end

---@return string
function Data:GlanceDamageBossLevel()
    return Data:GlanceDamageByLevel(3)
end
---@return string
function Data:GlanceDamageByLevel(level)
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + level) * 5

    local glancePenalty = DataUtils:GetGlancingDamage(mainBase + mainMod, enemyDefenseValue)

    return DataUtils:Round(glancePenalty*100, 2) .. "%"
end
---@return number
function Data:GetExpertise()
    local expertise, _ = GetExpertise()
    return DataUtils:Round(expertise, 0)
end

---@return number
function Data:GetExpertiseRating()
    local expertiseRating = GetCombatRating(CR_EXPERTISE)
    return DataUtils:Round(expertiseRating, 0)
end

---@return string
function Data:GetArmorPenetration()
    local armorPenetration = GetArmorPenetration()

    if ECS.IsWotlk and classId == Data.WARRIOR then
        local _, isActive = GetShapeshiftFormInfo(1)
        if isActive then
            armorPenetration = armorPenetration + 10 -- 10% from Battle Stance
        end
    end

    if classId == Data.DEATHKNIGHT then
        armorPenetration = armorPenetration + DataUtils:GetTalentBonus({61278,61277,61276,61275,61274},{10,8,6,4,2}) -- Blood Gorged
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return number
function Data:GetArmorPenetrationRating()
    local armorPenetrationRating = GetCombatRating(CR_ARMOR_PENETRATION)
    return DataUtils:Round(armorPenetrationRating, 0)
end

---@return number
function Data:GetMeleeHasteRating()
    local hasteRating = GetCombatRating(CR_HASTE_MELEE)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetMeleeHasteBonus()
    local hasteBonus = GetCombatRatingBonus(CR_HASTE_MELEE)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

