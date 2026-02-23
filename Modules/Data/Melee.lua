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

---@param creature number
---@return string
function Data:GetMeleeAttackPowerVsCreature(creature)
    local dmg = 0
    -- auras
    local j = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", j)
        j = j + 1
        if aura and aura.spellId then
            if creature == Data.UNDEAD then
                dmg = dmg + (Data.buffsUndeadAttackPower[aura.spellId] or 0)
            elseif creature == Data.DEMON then
                if aura.spellId == 11406 then dmg = dmg + 265 end -- Elixir of Demonslaying
            end
        end
    until (not aura)
    for i = 1, 18 do
        -- items
        local id, _ = GetInventoryItemID("player", i)
        if creature == Data.UNDEAD then
            dmg = dmg + (Data.itemsUndeadSlaying[id] or 0)
            dmg = dmg + (Data.itemsUndeadDeamonSlaying[id] or 0)
        elseif creature == Data.DEMON then
            dmg = dmg + (Data.itemsDemonSlaying[id] or 0)
            dmg = dmg + (Data.itemsUndeadDeamonSlaying[id] or 0)
        elseif creature == Data.DRAGONKIN then
            dmg = dmg + (Data.itemsDragonSlaying[id] or 0)
        elseif creature == Data.MECHANICAL then
             if id == 213319 then dmg = dmg + 30 end -- Machinist's Gloves
        end
        -- enchants
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                if creature == Data.UNDEAD then
                    dmg = dmg + (Data.enchantsUndeadSlayer[enchant] or 0)
                    if enchant and enchant == Data.enchantIds.UNDEAD_DEMON_SLAYER_150 then dmg = dmg + 150 end
                elseif creature == Data.DEMON then
                    if enchant and enchant == Data.enchantIds.UNDEAD_DEMON_SLAYER_150 then dmg = dmg + 150 end
                elseif creature == Data.BEAST then
                    dmg = dmg + (Data.enchantsBeastSlayer[enchant] or 0)
                elseif creature == Data.ELEMENTAL then
                    dmg = dmg + (Data.enchantsElementalSlayer[enchant] or 0)
                    if enchant and enchant == Data.enchantIds.LESSER_ELEMENTAL_SLAYER then dmg = dmg + 6 end
                end
            end
        end
    end
    -- sets
    if creature == Data.UNDEAD then
        if Data:HasUndeadSlayer15() then dmg = dmg + 15 end
    elseif creature == Data.DEMON then
        if Data:HasDemonSlaying200() then dmg = dmg + 200 end
    end
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

---If a talent spell has the "Apply Aura: Modifies Hit Chance" effect, then we need to handle it here.
---If the effect is "Apply Aura: Mod Spell Hit Chance %", then GetHitModifier() already accounts for it and we don't need to handle it here.
---@return number
function _Melee:GetHitTalentBonus()
    local mod = 0

    if classId == Data.WARRIOR then
        if ECS.IsWotlk then
            -- precision
            mod = 1 * DataUtils:GetActiveTalentSpell({29590,29591,29592})
        end
    elseif classId == Data.HUNTER then
        if ECS.IsWotlk then
            -- focused aim
            mod = 1 * DataUtils:GetActiveTalentSpell({53620,53621,53622})
        end
    elseif classId == Data.SHAMAN then
        if ECS.IsWotlk then
            -- Dual Wield Specialization
            if Data:GetMeleeAttackSpeedOffHand() > 0 then
                mod = 2 * DataUtils:GetActiveTalentSpell({30816,30818,30819})
            end
        elseif ECS.IsClassic then
            -- Nature's Guidance
            mod = 1 * DataUtils:GetActiveTalentSpell({16180,16196,16198})
        end
    elseif classId == Data.ROGUE then
        if ECS.IsClassic then
            -- precision
            mod = 1 * DataUtils:GetActiveTalentSpell({13705,13832,13843,13844,13845})
        end
    elseif classId == Data.DEATHKNIGHT then
        -- Nerves of Cold Steel
        -- This assumes a DK is dual wielding and not only using a one-hand main hand weapon
        if Data:GetMeleeAttackSpeedOffHand() > 0 then
            mod = 1 * DataUtils:GetActiveTalentSpell({49226,50137,50138})
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

