local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local pairs = pairs

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Melee = {}
local _, _, classId = UnitClass("player")
local DEMON = Data.CreatureType.DEMON
local UNDEAD = Data.CreatureType.UNDEAD

---@return number
function Data:GetMeleeAttackPower()
    local melee, posBuff, negBuff = UnitAttackPower("player")
    return melee + posBuff + negBuff
end

---@return table<CreatureType,number>
function Data:GetMeleeAttackPowerVsCreature()
    local dmg = {0,0,0,0,0,0,0,0,0}

    -- auras
    local j = 1
    repeat
        local aura = GetBuffDataByIndex("player", j)
        j = j + 1
        if aura and aura.spellId then
            for _,type in pairs(Data.CreatureType) do
                if Data.Aura.AttackPowerVsCreature[type] then
                    dmg[type] = dmg[type] + (Data.Aura.AttackPowerVsCreature[type][aura.spellId] or 0)
                end
                if Data.Aura.PhysicalDamageVsCreature[type] then
                    dmg[type] = dmg[type] + (Data.Aura.PhysicalDamageVsCreature[type][aura.spellId] or 0)
                end
            end
        end
    until (not aura)
    for i = 1, 18 do
        -- items
        local id, _ = GetInventoryItemID("player", i)
        for _,type in pairs(Data.CreatureType) do
            if Data.Item.PhysicalDamageVsCreature[type] then
                dmg[type] = dmg[type] + (Data.Item.PhysicalDamageVsCreature[type][id] or 0)
            end
        end
        -- enchants
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                for _,type in pairs(Data.CreatureType) do
                    if Data.Enchant.PhysicalDamageVsCreature[type] then
                        dmg[type] = dmg[type] + (Data.Enchant.PhysicalDamageVsCreature[type][enchant] or 0)
                    end
                end
            end
        end
    end
    -- sets
    if Data:HasUndeadSlayer15() then dmg[UNDEAD] = dmg[UNDEAD] + 15 end
    if Data:HasDemonSlaying200() then dmg[DEMON] = dmg[DEMON] + 200 end

    return dmg
end

---@return string
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
    if (not CR_HIT_MELEE) then
        return 0
    end

    return GetCombatRating(CR_HIT_MELEE)
end

---@return number
function _Melee:GetHitRatingBonus()
    local hit = _Melee:GetHitTalentBonus() + _Melee.GetHitFromRunes()
    if CR_HIT_MELEE then
        hit = hit + GetCombatRatingBonus(CR_HIT_MELEE)
    end
    -- GetHitModifier returns nil on dungeon entering/teleport
    return hit + (GetHitModifier() or 0)
end

---In TBC and WotLK clients, if a talent spell has the "Apply Aura: Mod Melee & Ranged Hit Chance %", then GetHitModifier() already accounts for it and we don't need to handle it here.
---@return number
function _Melee:GetHitTalentBonus()
    local mod = 0
    if ECS.IsClassic then
        if classId == Data.SHAMAN then
            -- Nature's Guidance
            mod = 1 * DataUtils:GetActiveTalentSpell({16180,16196,16198})
        elseif classId == Data.ROGUE then
            -- precision
            mod = 1 * DataUtils:GetActiveTalentSpell({13705,13832,13843,13844,13845})
        end
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
    if (not CR_EXPERTISE) then
        return 0
    end

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
        armorPenetration = armorPenetration + 2 * DataUtils:GetActiveTalentSpell({61274,61275,61276,61277,61278}) -- Blood Gorged
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return number
function Data:GetArmorPenetrationRating()
    if (not CR_ARMOR_PENETRATION) then
        return 0
    end

    local armorPenetrationRating = GetCombatRating(CR_ARMOR_PENETRATION)
    return DataUtils:Round(armorPenetrationRating, 0)
end

---@return number
function Data:GetMeleeHasteRating()
    if (not CR_HASTE_MELEE) then
        return 0
    end

    local hasteRating = GetCombatRating(CR_HASTE_MELEE)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetMeleeHasteBonus()
    if (not CR_HASTE_MELEE) then
        return "0%"
    end

    local hasteBonus = GetCombatRatingBonus(CR_HASTE_MELEE)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

