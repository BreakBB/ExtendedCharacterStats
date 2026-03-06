local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Ranged = {}

local _, _, classId = UnitClass("player")
local DEMON = Data.CreatureType.DEMON
local UNDEAD = Data.CreatureType.UNDEAD

---@return number
function Data:GetRangeAttackPower()
    if UnitHasRelicSlot("player") then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@return table<CreatureType,number>
function Data:GetRangedAttackPowerVsCreature()
    local dmg = {0,0,0,0,0,0,0,0,0}

    -- auras
    local j = 1
    repeat
        local aura = GetBuffDataByIndex("player", j)
        j = j + 1
        if aura and aura.spellId then
            for _,type in pairs(Data.CreatureType) do
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

---@return number
function Data:GetRangedHasteRating()
    if (not CR_HASTE_RANGED) then
        return 0
    end

    local hasteRating = GetCombatRating(CR_HASTE_RANGED)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetRangedHasteBonus()
    if (not CR_HASTE_RANGED) then
        return "0%"
    end

    local hasteBonus = GetCombatRatingBonus(CR_HASTE_RANGED)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

---@return number
function Data:GetRangedAttackSpeed()
    local speed, _ = UnitRangedDamage("player")
    return DataUtils:Round(speed, 2)
end

---@return string
function Data:RangedCrit()
    return DataUtils:Round(GetRangedCritChance(), 2) .. "%"
end

---@return number
function Data:RangeHitRating()
    if (not CR_HIT_RANGED) then
        return 0
    end

    return GetCombatRating(CR_HIT_RANGED)
end

---@return string
function Data:RangeHitBonus()
    return DataUtils:Round(_Ranged:GetHitBonus(), 2) .. "%"
end

---@return number
function _Ranged:GetHitBonus()
    local hitValue = 0

    -- Biznick Scope awards Hit rating in TBC and is part of CR_HIT_RANGED
    if ECS.IsClassic then
        local rangedEnchant = DataUtils:GetEnchantForEquipSlot(Utils.CHAR_EQUIP_SLOTS["Range"])
        if rangedEnchant and rangedEnchant == Data.Enchant.Ids.BIZNICK_SCOPE then
            hitValue = hitValue + 3
        end
    end

    if CR_HIT_RANGED then
        hitValue = hitValue + GetCombatRatingBonus(CR_HIT_RANGED)
    end

    return hitValue + (GetHitModifier() or 0) + _Ranged:GetHitTalentBonus()
end

---If a talent spell has the "Apply Aura: Modifies Hit Chance" effect, then we need to handle it here.
---If the effect is "Apply Aura: Mod Spell Hit Chance %", then GetHitModifier() already accounts for it and we don't need to handle it here.
---@return number
function _Ranged:GetHitTalentBonus()
    local bonus = 0

    if ECS.IsWotlk and classId == Data.HUNTER then
        bonus = bonus + 1 * DataUtils:GetActiveTalentSpell({53620,53621,53622}) -- Focused Aim
    end

    return bonus
end

---@return string
function Data:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = DataUtils.GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _Ranged:GetHitBonus()

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data.RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local rangedWeaponSkill = rangedAttackBase + rangedAttackMod
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = DataUtils.GetMissChanceByDifference(rangedWeaponSkill, enemyDefenseValue)
    local hitBonus = _Ranged:GetHitBonus()

    missChance = missChance - hitBonus
    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

return Data
