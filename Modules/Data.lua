------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------

local _, core = ...
core.ECSData = { }

local ECSData = core.ECSData

local CHAR_EQUIP_SLOTS = {
    ["Head"] = "HeadSlot",
    ["Neck"] = "NeckSlot",
    ["Shoulder"] = "ShoulderSlot",
    ["Back"] = "BackSlot",
    ["Chest"] = "ChestSlot",
    ["Shirt"] = "ShirtSlot",
    ["Tabard"] = "TabardSlot",
    ["Wrist"] = "WristSlot",
    ["Hands"] = "HandsSlot",
    ["Wairst"] = "WaistSlot",
    ["Legs"] = "LegsSlot",
    ["Feet"] = "FeetSlot",
    ["Finger1"] = "Finger0Slot",
    ["Finger2"] = "Finger1Slot",
    ["Trinket1"] = "Trinket0Slot",
    ["Trinket2"] = "Trinket1Slot",
    ["MainHand"] = "MainHandSlot",
    ["OffHand"]  = "SecondaryHandSlot",
    ["Range"] = "RangedSlot",
}

------------------------------------------------------------------
-- Data functions
------------------------------------------------------------------

--- Rounds every number down to the given decimal places
function ECSData:Round(num, decimalPlaces)
    if not num then
        return 0
    end
    local mult = 10^(decimalPlaces)
    return math.floor(num * mult + 0.5) / mult
end

local function _GetTalentModifierMeleeHit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 4 then -- Rogue
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 6)
        mod = points * 1 -- 0-5% from Precision
    end

    if classId == 7 then -- Shaman
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 1 -- 0-3% from Nature's Guidance
    end

    return mod
end

local function _IsShapeshifted()
    for i = 0, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL", "PLAYER")
        if spellId == 5487 or spellId == 9634 or spellId == 768 then
            return true
        end
    end
    return false
end

local function _GetMissChanceByDifference(weaponSkill, defenseValue)
    if defenseValue - (weaponSkill) <= 10 then
        return 5 + (defenseValue - weaponSkill) * 0.1
    else
        return 6 + (defenseValue - weaponSkill - 10) * 0.4
    end
end

-- Gets the current bonus hit chance
function ECSData:MeleeHitBonus()
    local hit = _GetTalentModifierMeleeHit()
    hit = hit + GetHitModifier()

    return ECSData:Round(hit, 2) .. "%"
end

-- Gets the hit chance against enemies on the player level
function ECSData:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = 0
    if _IsShapeshifted() then
        missChance = 6
    else
        missChance = _GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end
    missChance = missChance - GetHitModifier() - _GetTalentModifierMeleeHit()

    return ECSData:Round(missChance, 2) .. "%"
end

-- Gets the hit chance against enemies 3 level above the player level
function ECSData:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = 0
    if _IsShapeshifted() then
        missChance = 9
    else
        missChance = _GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end
    missChance = missChance - GetHitModifier() - _GetTalentModifierMeleeHit()

    return ECSData:Round(missChance, 2) .. "%"
end

local function _GetRangeHitBonus()
    local hitValue = 0
    -- From Enchant
    local slotId, _ = GetInventorySlotInfo(CHAR_EQUIP_SLOTS["Range"])
    local itemLink = GetInventoryItemLink("player", slotId)
    if itemLink then
        local _, itemStringLink = GetItemInfo(itemLink)
        if itemStringLink then
            local _, _, _, _, _, Enchant, _, _, _, _, _, _, _, _ = string.find(itemStringLink,
            "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
            if (Enchant == "2523") then -- 3% Hit from Biznicks 247x128 Accurascope
                hitValue = hitValue + 3
            end
        end
    end
    -- From Items
    hitValue = hitValue + GetHitModifier()

    return hitValue
end

-- Gets the current bonus hit chance
function ECSData:RangeHitBonus()
    return ECSData:Round(_GetRangeHitBonus(), 2) .. "%"
end

-- Gets the range hit chance against enemies on the player level
function ECSData:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = _GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    return ECSData:Round(missChance, 2) .. "%"
end

-- Gets the range hit chance against enemies 3 level above the player level
function ECSData:RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = _GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    return ECSData:Round(missChance, 2) .. "%"
end

local function _GetTalentModifierSpellHit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 5 then -- Priest
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 5)
        mod = points * 2 -- 0-10% from Shadow Focus
    end

    if classId == 8 then -- Mage
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 3)
        mod = points * 2 -- 0-6% from Elemental Precision
    end

    if classId == 7 then -- Shaman
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 1 -- 0-3% from Nature's Guidance
    end

    return mod
end

function ECSData:SpellHitBonus()
    local hit = _GetTalentModifierSpellHit()
    hit = hit + GetSpellHitModifier()

    return ECSData:Round(hit, 2) .. "%"
end

function ECSData:SpellMissChanceSameLevel()
    local missChance = 3

    missChance = missChance - _GetTalentModifierSpellHit()
    missChance = missChance - GetSpellHitModifier()

    return ECSData:Round(missChance, 2) .. "%"
end

function ECSData:SpellMissChanceBossLevel()
    local missChance = 16

    missChance = missChance - _GetTalentModifierSpellHit()
    missChance = missChance - GetSpellHitModifier()

    return ECSData:Round(missChance, 2) .. "%"
end

-- Get MP5 from items
function ECSData:MP5FromItems()
    local mp5 = 0
    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local stats = GetItemStats(itemLink)
            if stats then
                local statMP5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"]
                if statMP5 then
                    mp5 = mp5 + statMP5 + 1
                end
            end
        end
    end
    return mp5
end

local lastManaReg = 0

-- Get MP5 from spirit
function ECSData:MP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return ECSData:Round(base, 0) * 5
end

local function _GetTalentModifierMP5()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 5 then -- Priest
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 8)
        mod = points * 0.05 -- 0-15% from Meditation
    end

    if classId == 8 then -- Mage
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12)
        mod = points * 0.05 -- 0-15% Arcane Meditation
    end

    if classId == 11 then -- Druid
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 0.05 -- 0-15% from Reflection
    end

    return mod
end

-- Get manaregen while casting
function ECSData:MP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = lastManaReg
    end
    lastManaReg = casting

    local mod = _GetTalentModifierMP5()
    if mod > 0 then
        casting = casting * mod
    end

    local mp5Items = ECSData:MP5FromItems()
    casting = (casting * 5) + mp5Items

    return ECSData:Round(casting, 2)
end

-- Get melee crit chance
function ECSData:MeleeCrit()
    return ECSData:Round(GetCritChance(), 2) .. "%"
end

-- Get spell crit chance
function ECSData:SpellCrit()
    return ECSData:Round(GetSpellCritChance(), 2) .. "%"
end

-- Get ranged crit chance
function ECSData:RangedCrit()
    return ECSData:Round(GetRangedCritChance(), 2) .. "%"
end

-- Get spell penetration %
function ECSData:SpellPenetration()
    return ECSData:Round(GetSpellPenetration(), 2) .. "%"
end

-- Get dodge chacne
function ECSData:Dodge()
    return ECSData:Round(GetDodgeChance(), 2) .. "%"
end

-- Get parry chance
function ECSData:Parry()
    return ECSData:Round(GetParryChance(), 2) .. "%"
end

-- Get block chance
function ECSData:Block()
    return ECSData:Round(GetBlockChance(), 2) .. "%"
end

-- Get phys dmg bonus
function ECSData:PhysicalDmg()
    return GetSpellBonusDamage(1)
end

-- Get phys crit chance
function ECSData:PhysicalCrit()
    return ECSData:Round(GetSpellCritChance(1), 2) .. "%"
end

-- Get holy bonus dmg
function ECSData:HolyDmg()
    return GetSpellBonusDamage(2)
end

-- Get holy crit chance
function ECSData:HolyCrit()
    return ECSData:Round(GetSpellCritChance(2), 2) .. "%"
end

-- Get fire bonus dmg
function ECSData:FireDmg()
    return GetSpellBonusDamage(3)
end

-- Get fire crit chance
function ECSData:FireCrit()
    return ECSData:Round(GetSpellCritChance(3), 2) .. "%"
end

-- Get nature bonus dmg
function ECSData:NatureDmg()
    return GetSpellBonusDamage(4)
end

-- Get nature crit chance
function ECSData:NatureCrit()
    return ECSData:Round(GetSpellCritChance(4), 2) .. "%"
end

-- Get frost bonus dmg
function ECSData:FrostDmg()
    return GetSpellBonusDamage(5)
end

-- Get frost crit chance
function ECSData:FrostCrit()
    return ECSData:Round(GetSpellCritChance(5), 2) .. "%"
end

-- Get shadow bonus dmg
function ECSData:ShadowDmg()
    return GetSpellBonusDamage(6)
end

-- Get shadow crit chance
function ECSData:ShadowCrit()
    return ECSData:Round(GetSpellCritChance(6), 2) .. "%"
end

-- Get arcane bonus dmg
function ECSData:ArcaneDmg()
    return GetSpellBonusDamage(7)
end

-- Get arcane crit chance
function ECSData:ArcaneCrit()
    return ECSData:Round(GetSpellCritChance(7), 2) .. "%"
end

-- Get bonus healing power
function ECSData:HealingBonus()
    return GetSpellBonusHealing()
end

function ECSData:GetStatInfo(refName)

    if refName == "RangedHitBonus" then
       return ECSData:RangeHitBonus()
    end
    if refName == "RangedHitSameLevel" then
        return ECSData:RangeMissChanceSameLevel()
    end
    if refName == "RangedHitBossLevel" then
        return ECSData:RangeMissChanceBossLevel()
    end
    if refName == "RangedCritChance" then
        return ECSData:RangedCrit()
    end

    if refName == "MeleeHitBonus" then
       return ECSData:MeleeHitBonus()
    end
    if refName == "MeleeHitSameLevel" then
        return ECSData:MeleeHitMissChanceSameLevel()
    end
    if refName == "MeleeHitBossLevel" then
        return ECSData:MeleeHitMissChanceBossLevel()
    end
    if refName == "MeleeCritChance" then
        return ECSData:MeleeCrit()
    end

    if refName == "DodgeChance" then
        return ECSData:Dodge()
    end
    if refName == "ParryChance" then
        return ECSData:Parry()
    end
    if refName == "BlockChance" then
        return ECSData:Block()
    end

    if refName == "SpellHitBonus" then
       return ECSData:SpellHitBonus()
    end
    if refName == "SpellHitSameLevel" then
        return ECSData:SpellMissChanceSameLevel()
    end
    if refName == "SpellHitBossLevel" then
        return ECSData:SpellMissChanceBossLevel()
    end
    if refName == "SpellCritChance" then
        return ECSData:SpellCrit()
    end

    if refName == "MP5Items" then
        return ECSData:MP5FromItems()
    end
    if refName == "MP5Spirit" then
        return ECSData:MP5FromSpirit()
    end
    if refName == "MP5Casting" then
        return ECSData:MP5WhileCasting()
    end

    if refName == "PhysicalCritChance" then
        return ECSData:PhysicalCrit()
    end
    if refName == "ArcaneCritChance" then
        return ECSData:ArcaneCrit()
    end
    if refName == "NatureDmg" then
        return ECSData:NatureDmg()
    end
    if refName == "HolyDmg" then
        return ECSData:HolyDmg()
    end
    if refName == "FrostCritChance" then
        return ECSData:FrostCrit()
    end
    if refName == "FireDmg" then
        return ECSData:FireDmg()
    end
    if refName == "BonusHealing" then
        return ECSData:HealingBonus()
    end
    if refName == "FireCritChance" then
        return ECSData:FireCrit()
    end
    if refName == "ShadowDmg" then
        return ECSData:ShadowDmg()
    end
    if refName == "FrostDmg" then
        return ECSData:FrostDmg()
    end
    if refName == "HolyCritChance" then
        return ECSData:HolyCrit()
    end
    if refName == "PhysicalDmg" then
        return ECSData:PhysicalDmg()
    end
    if refName == "ShadowCritChance" then
        return ECSData:ShadowCrit()
    end
    if refName == "ArcaneDmg" then
        return ECSData:ArcaneDmg()
    end
    if refName == "NatureCritChance" then
        return ECSData:NatureCrit()
    end
end
