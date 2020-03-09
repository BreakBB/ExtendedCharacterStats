------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Data
local Data = ECSLoader:CreateModule("Data")

------------------------------------------------------------------
-- Statics
------------------------------------------------------------------

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
function Data:Round(num, decimalPlaces)
    if not num then
        return 0
    end
    local mult = 10^(decimalPlaces)
    return math.floor(num * mult + 0.5) / mult
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
    if (defenseValue - weaponSkill) <= 10 then
        return 5 + (defenseValue - weaponSkill) * 0.1
    else
        return 7 + (defenseValue - weaponSkill - 10) * 0.4
    end
end

-- Gets the current bonus hit chance
function Data:MeleeHitBonus()
    return Data:Round(GetHitModifier(), 2) .. "%"
end

-- Gets the hit chance against enemies on the player level
function Data:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = 0
    if _IsShapeshifted() then
        missChance = 6
    else
        missChance = _GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitFromItems
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return Data:Round(missChance, 2) .. "%"
end

-- Gets the hit chance against enemies 3 level above the player level
function Data:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = 0
    if _IsShapeshifted() then
        missChance = 9
    else
        missChance = _GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        missChance = missChance - hitFromItems
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return Data:Round(missChance, 2) .. "%"
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
    local hitFromItems = GetHitModifier()
    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        hitValue = hitValue + hitFromItems
    end

    return hitValue
end

-- Gets the current bonus hit chance
function Data:RangeHitBonus()
    return Data:Round(_GetRangeHitBonus(), 2) .. "%"
end

-- Gets the range hit chance against enemies on the player level
function Data:RangeMissChanceSameLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance = _GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return Data:Round(missChance, 2) .. "%"
end

-- Gets the range hit chance against enemies 3 level above the player level
function Data:RangeMissChanceBossLevel()
    local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance = _GetMissChanceByDifference(rangedAttackBase + rangedAttackMod, enemyDefenseValue)
    missChance = missChance - _GetRangeHitBonus()

    return Data:Round(missChance, 2) .. "%"
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

    return mod
end

function Data:SpellHitBonus()
    local hit = _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        hit = hit + mod
    end

    return Data:Round(hit, 2) .. "%"
end

function Data:SpellMissChanceSameLevel()
    local missChance = 3

    missChance = missChance - _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        missChance = missChance - mod
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return Data:Round(missChance, 2) .. "%"
end

function Data:SpellMissChanceBossLevel()
    local missChance = 16

    missChance = missChance - _GetTalentModifierSpellHit()
    local mod = GetSpellHitModifier()
    if mod then
        missChance = missChance - mod
    end

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return Data:Round(missChance, 2) .. "%"
end

-- Get MP5 from items
function Data:MP5FromItems()
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
function Data:MP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return Data:Round(base, 0) * 5
end

local function _GetTalentModifierMP5()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 5 then -- Priest
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 8)
        mod = points * 0.05 -- 0-15% from Meditation
    elseif classId == 8 then -- Mage
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12)
        mod = points * 0.05 -- 0-15% Arcane Meditation
    elseif classId == 11 then -- Druid
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 0.05 -- 0-15% from Reflection
    end

    return mod
end

local function _HasSetBonusModifierMP5()
    local _, _, classId = UnitClass("player")
    local hasSetBonus = false
    local setCounter = 0

    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))

            if itemName then
                if classId == 5 then -- Priest
                    if string.sub(itemName, -13) == "Transcendence" or string.sub(itemName, -11) == "Erhabenheit" or string.sub(itemName, -13) == "Trascendencia" or string.sub(itemName, -13) == "transcendance" or string.sub(itemName, -14) == "Transcendência" then
                        setCounter = setCounter + 1
                    end
                elseif classId == 11 then -- Druid
                    if string.sub(itemName, 1, 9) == "Stormrage" or string.sub(itemName, -9) == "Stormrage" or string.sub(itemName, -10) == "Tempestira" or string.sub(itemName, -11) == "Tempesfúria" then
                        setCounter = setCounter + 1
                    end
                end
            end
        end
    end

    if setCounter >= 3 then
        hasSetBonus = true
    end

    return hasSetBonus
end

-- Get manaregen while casting
function Data:MP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = lastManaReg
    end
    lastManaReg = casting

    local mod = _GetTalentModifierMP5()
    if _HasSetBonusModifierMP5() then
        mod = mod + 0.15
    end
    if mod > 0 then
        casting = casting * mod
    end

    local mp5Items = Data:MP5FromItems()
    casting = (casting * 5) + mp5Items

    return Data:Round(casting, 2)
end

-- Get melee crit chance
function Data:MeleeCrit()
    return Data:Round(GetCritChance(), 2) .. "%"
end

local function _GetTalentModifierSpellCrit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 8 then -- Mage
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 15)
        mod = points * 1 -- 0-3% Arcane Instability
    end

    return mod
end

-- Get spell crit chance
function Data:SpellCrit()
    local crit = _GetTalentModifierSpellCrit()
    crit = crit + GetSpellCritChance()
    return Data:Round(crit, 2) .. "%"
end

-- Get ranged crit chance
function Data:RangedCrit()
    return Data:Round(GetRangedCritChance(), 2) .. "%"
end

-- Get spell penetration %
function Data:SpellPenetration()
    return Data:Round(GetSpellPenetration(), 2) .. "%"
end

function Data:Armor()
    local _, effectiveArmor = UnitArmor("player")
    return Data:Round(effectiveArmor, 2)
end

local function _GetTalentModifierDefense()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 1 then -- Warrior
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
    return Data:Round(GetDodgeChance(), 2) .. "%"
end

-- Get parry chance
function Data:Parry()
    return Data:Round(GetParryChance(), 2) .. "%"
end

-- Get block chance
function Data:Block()
    return Data:Round(GetBlockChance(), 2) .. "%"
end

-- Get phys dmg bonus
function Data:PhysicalDmg()
    return GetSpellBonusDamage(1)
end

-- Get phys crit chance
function Data:PhysicalCrit()
    return Data:Round(GetSpellCritChance(1), 2) .. "%"
end

-- Get holy bonus dmg
function Data:HolyDmg()
    return GetSpellBonusDamage(2)
end

local function _GetTalentModifierHolyCrit()
    local _, _, classId = UnitClass("player")
    local mod = 0

    if classId == 2 then -- Paladin
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 13)
        mod = points * 1 -- 0-5% Holy Power
    elseif classId == 5 then -- Priest
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 3)
        mod = points * 1 -- 0-5% Holy Specialization
    end

    return mod
end

-- Get holy crit chance
function Data:HolyCrit()
    local crit = _GetTalentModifierHolyCrit()
    crit = crit + GetSpellCritChance(2)
    return Data:Round(crit, 2) .. "%"
end

-- Get fire bonus dmg
function Data:FireDmg()
    return GetSpellBonusDamage(3)
end

-- Get fire crit chance
function Data:FireCrit()
    return Data:Round(GetSpellCritChance(3), 2) .. "%"
end

-- Get nature bonus dmg
function Data:NatureDmg()
    return GetSpellBonusDamage(4)
end

-- Get nature crit chance
function Data:NatureCrit()
    return Data:Round(GetSpellCritChance(4), 2) .. "%"
end

-- Get frost bonus dmg
function Data:FrostDmg()
    return GetSpellBonusDamage(5)
end

-- Get frost crit chance
function Data:FrostCrit()
    return Data:Round(GetSpellCritChance(5), 2) .. "%"
end

-- Get shadow bonus dmg
function Data:ShadowDmg()
    return GetSpellBonusDamage(6)
end

-- Get shadow crit chance
function Data:ShadowCrit()
    return Data:Round(GetSpellCritChance(6), 2) .. "%"
end

-- Get arcane bonus dmg
function Data:ArcaneDmg()
    return GetSpellBonusDamage(7)
end

-- Get arcane crit chance
function Data:ArcaneCrit()
    return Data:Round(GetSpellCritChance(7), 2) .. "%"
end

-- Get bonus healing power
function Data:HealingBonus()
    return GetSpellBonusHealing()
end

function Data:GetStatInfo(refName)

    if refName == "RangedHitBonus" then
       return Data:RangeHitBonus()
    end
    if refName == "RangedHitSameLevel" then
        return Data:RangeMissChanceSameLevel()
    end
    if refName == "RangedHitBossLevel" then
        return Data:RangeMissChanceBossLevel()
    end
    if refName == "RangedCritChance" then
        return Data:RangedCrit()
    end

    if refName == "MeleeHitBonus" then
       return Data:MeleeHitBonus()
    end
    if refName == "MeleeHitSameLevel" then
        return Data:MeleeHitMissChanceSameLevel()
    end
    if refName == "MeleeHitBossLevel" then
        return Data:MeleeHitMissChanceBossLevel()
    end
    if refName == "MeleeCritChance" then
        return Data:MeleeCrit()
    end

    if refName == "Armor" then
        return Data:Armor()
    end
    if refName == "DefenseValue" then
        return Data:Defense()
    end
    if refName == "DodgeChance" then
        return Data:Dodge()
    end
    if refName == "ParryChance" then
        return Data:Parry()
    end
    if refName == "BlockChance" then
        return Data:Block()
    end

    if refName == "SpellHitBonus" then
       return Data:SpellHitBonus()
    end
    if refName == "SpellHitSameLevel" then
        return Data:SpellMissChanceSameLevel()
    end
    if refName == "SpellHitBossLevel" then
        return Data:SpellMissChanceBossLevel()
    end
    if refName == "SpellCritChance" then
        return Data:SpellCrit()
    end

    if refName == "MP5Items" then
        return Data:MP5FromItems()
    end
    if refName == "MP5Spirit" then
        return Data:MP5FromSpirit()
    end
    if refName == "MP5Casting" then
        return Data:MP5WhileCasting()
    end

    if refName == "PhysicalCritChance" then
        return Data:PhysicalCrit()
    end
    if refName == "ArcaneCritChance" then
        return Data:ArcaneCrit()
    end
    if refName == "NatureDmg" then
        return Data:NatureDmg()
    end
    if refName == "HolyDmg" then
        return Data:HolyDmg()
    end
    if refName == "FrostCritChance" then
        return Data:FrostCrit()
    end
    if refName == "FireDmg" then
        return Data:FireDmg()
    end
    if refName == "BonusHealing" then
        return Data:HealingBonus()
    end
    if refName == "FireCritChance" then
        return Data:FireCrit()
    end
    if refName == "ShadowDmg" then
        return Data:ShadowDmg()
    end
    if refName == "FrostDmg" then
        return Data:FrostDmg()
    end
    if refName == "HolyCritChance" then
        return Data:HolyCrit()
    end
    if refName == "PhysicalDmg" then
        return Data:PhysicalDmg()
    end
    if refName == "ShadowCritChance" then
        return Data:ShadowCrit()
    end
    if refName == "ArcaneDmg" then
        return Data:ArcaneDmg()
    end
    if refName == "NatureCritChance" then
        return Data:NatureCrit()
    end
end
