---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _Ranged = {}

local _, _, classId = UnitClass("player")

---@return string
function Data:GetRangeAttackPower()
    if not _Ranged:IsRangeAttackClass() then
        return 0
    end

    local melee, posBuff, negBuff = UnitRangedAttackPower("player")
    return melee + posBuff + negBuff
end

---@param creature number
---@return string
 function Data:GetRangedAttackPowerVsCreature(creature)
     local dmg = 0
     if creature == Data.UNDEAD then
         -- enchants
         for i = 1, 18 do
             local itemLink = GetInventoryItemLink("player", i)
             if itemLink then
                 local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                 if enchant and enchant == Data.enchantIds.UNDEAD_SLAYER_100 then dmg = dmg + 100 end
             end
         end
         -- sets
         if Data:HasUndeadSlayer15() then dmg = dmg + 15 end
         -- items
         for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_30) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 30 end
         end
         for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_45) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 45 end
         end
         for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_60) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 60 end
         end
         for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_81) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 81 end
         end
         if C_Item.IsEquippedItem(13209) then dmg = dmg + 81 end -- Seal of the Dawn
         -- weapons
         for _, i in pairs(weaponsId) do
             if i and i == 13017 then dmg = dmg + 66 end -- Hellslayer Battle Axe
         end
         --
         if ECS.IsSod then
             -- enchants
             for i = 1, 18 do
                 local itemLink = GetInventoryItemLink("player", i)
                 if itemLink then
                     local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                     if enchant and enchant == Data.enchantIds.UNDEAD_SLAYER_200 then dmg = dmg + 200 end
                 end
             end
             -- items
             for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_45_SOD) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 45 end
             end
             for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_60_SOD) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 60 end
             end
             for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_81_SOD) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 81 end
             end
             for _, i in pairs(Data.itemIds.UNDEAD_SLAYER_108_SOD) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 108 end
             end
             if C_Item.IsEquippedItem(209574) then dmg = dmg + 15 end -- Discarded Tenets of the Silver Hand
             -- weapons
             for _, i in pairs(weaponsId) do
                 if i then
                     if i == 220575 then dmg = dmg + 39 -- Eater of the Damned
                     elseif i == 228030 then dmg = dmg + 30 end -- Malicious Axe
                 end
             end
         elseif ECS.IsWotlk then
             -- enchants
             for i = 1, 18 do
                 local itemLink = GetInventoryItemLink("player", i)
                 if itemLink then
                     local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                     if enchant then
                         if enchant == Data.enchantIds.UNDEAD_SLAYER then dmg = dmg + 140
                         elseif enchant == Data.enchantIds.UNDEAD_SLAYER_170 then dmg = dmg + 170 end
                     end
                 end
             end
             -- auras
             if C_UnitAuras.GetPlayerAuraBySpellID(58026) then dmg = dmg + 12000 end -- Blessing of the Crusade
         end
     elseif creature == Data.DEMON then
         -- items
         for _, i in pairs(Data.itemIds.DEMON_SLAYING_33) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 33 end
         end
         for _, i in pairs(Data.itemIds.DEMON_SLAYING_45) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 45 end
         end
         -- weapons
         for _, i in pairs(weaponsId) do
             if i then
                 if i == 10698 then dmg = dmg + 78 -- Enchanted Azsharite Felbane Staff
                 elseif i == 13044 then dmg = dmg + 99 -- Demonslayer
                 elseif i == 19963 then dmg = dmg + 117 end -- Pitchfork of Madness
             end
         end
         --
         if ECS.IsSod then
             -- items
             for _, i in pairs(Data.itemIds.DEMON_SLAYING_141) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 141 end
             end
             -- weapons
             for _, i in pairs(weaponsId) do
                 if i and i == 228332 then dmg = dmg + 45 end -- Lok'delar, Stave of the Ancient Keepers
             end
         elseif ECS.IsTbc or ECS.IsWotlk then
             -- sets
             if Data:HasDemonSlaying200() then dmg = dmg + 200 end
             -- items
             if C_Item.IsEquippedItem(29398) then dmg = dmg + 39 end -- Circle of Banishing (ring but unique)
             -- weapons
             for _, i in pairs(weaponsId) do
                 if i then
                     if i == 220575 then dmg = dmg + 150 -- Illidari-Bane Claymore
                     elseif i ==  30788 or i == 31745 then dmg = dmg + 93 end -- Illidari-Bane Dagger and Broadsword
                 end
             end
         end
     elseif creature == Data.BEAST then
         -- enchants
         for i = 1, 18 do
             local itemLink = GetInventoryItemLink("player", i)
             if itemLink then
                 local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                 if enchant then
                     if enchant == Data.enchantIds.BEASTSLAYER then dmg = dmg + 2
                     elseif enchant == Data.enchantIds.LESSER_BEAST_SLAYER then dmg = dmg + 6
                     elseif enchant == Data.enchantIds.MINOR_BEAST_SLAYER then dmg = dmg + 2
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_2 then dmg = dmg + 2
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_4 then dmg = dmg + 4
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_6 then dmg = dmg + 6
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_8 then dmg = dmg + 8
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_10 then dmg = dmg + 10
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_12 then dmg = dmg + 12
                     elseif enchant == Data.enchantIds.INCREASED_DAMAGE_BEAST_14 then dmg = dmg + 14
                    end
                 end
             end
         end
         -- items
         for _, i in pairs(Data.itemIds.BEAST_SLAYING_24) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 24 end
         end
         for _, i in pairs(Data.itemIds.BEAST_SLAYING_30) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 30 end
         end
         for _, i in pairs(Data.itemIds.BEAST_SLAYING_33) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 33 end
         end
         for _, i in pairs(Data.itemIds.BEAST_SLAYING_60) do
             if C_Item.IsEquippedItem(i) then dmg = dmg + 60 end
         end
         if C_Item.IsEquippedItem(16658) then dmg = dmg + 18 end -- Wildhunter Cloak
         if C_Item.IsEquippedItem(13212) then dmg = dmg + 48 end -- Halycon's Spiked Collar
         -- weapons
         for _, i in pairs(weaponsId) do
             if i then
                if i == 11907 then dmg = dmg + 72 -- Beastslayer
                elseif i == 12709 then dmg = dmg + 45 -- pip's skinner
                elseif i == 1465 then dmg = dmg + 18 end -- tigerbane
             end
         end
         --
         if ECS.IsSod then
             -- items
             for _, i in pairs(Data.itemIds.BEAST_SLAYING_99) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 99 end
             end
         elseif ECS.IsWotlk then
             -- items
             if C_Item.IsEquippedItem(37018) then dmg = dmg - 40 end -- G.E.H.T.A.
         end
     elseif creature == Data.DRAGONKIN then
         -- weapons
         for _, i in pairs(weaponsId) do
             if i then
                 if i == 19961 then dmg = dmg + 48 -- Gri'lek's Grinder
                 elseif i == 19962 then dmg = dmg + 117 end -- Gri'lek's Carver
             end
         end
         --
         if ECS.IsSod then
             -- items
              if C_Item.IsEquippedItem(221457) then
                 dmg = dmg + 36 -- Libram of Draconic Destruction
             end
             for _, i in pairs(Data.itemIds.DRAGON_SLAYING_60) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 60 end
             end
             for _, i in pairs(Data.itemIds.DRAGON_SLAYING_141) do
                 if C_Item.IsEquippedItem(i) then dmg = dmg + 141 end
             end
             -- weapons
             for _, i in pairs(weaponsId) do
                 if i and i == 220965 then dmg = dmg + 117 end -- Scalebane Greataxe
             end
         end
     elseif creature == Data.ELEMENTAL then
         -- enchants
         for i = 1, 18 do
             local itemLink = GetInventoryItemLink("player", i)
             if itemLink then
                 local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                 if enchant and enchant == Data.enchantIds.LESSER_ELEMENTAL_SLAYER then dmg = dmg + 6 end
             end
         end
         -- weapons
         for _, i in pairs(weaponsId) do
             if i and i == 18310 then dmg = dmg + 36 end -- Fiendish Machete
         end
         --
         if ECS.IsSod then
             -- weapons
             for _, i in pairs(weaponsId) do
                 if i then
                     if i == 228056 then dmg = dmg + 36 -- Fiendish Machete
                     elseif i == 228486 then dmg = dmg + 75 end -- Treant's Bane
                 end
             end
         end
     elseif creature == Data.MECHANICAL then
         if ECS.IsSod then
             -- items
             if C_Item.IsEquippedItem(213319) then dmg = dmg + 30 end -- Machinist's Gloves
         end
     end
     if creature == Data.UNDEAD or creature == Data.DEMON then
         -- items
         if C_Item.IsEquippedItem(29113) then dmg = dmg + 150 end -- Champion of the Dawn
         if ECS.IsSod and C_Item.IsEquippedItem(1219522) then dmg = dmg + 157 end -- Champion of the Dawn
         if ECS.IsTbc or ECS.IsWotlk then
             -- enchants
             for i = 1, 18 do
                 local itemLink = GetInventoryItemLink("player", i)
                 if itemLink then
                     local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
                     if enchant and enchant == Data.enchantIds.UNDEAD_DEMON_SLAYER_150 then dmg = dmg + 150 end
                 end
             end
         end
     end
     return dmg
 end


---@return boolean
function _Ranged:IsRangeAttackClass()
    return classId == Data.WARRIOR or classId == Data.ROGUE or classId == Data.HUNTER
end

---@return number
function Data:GetRangedHasteRating()
    local hasteRating = GetCombatRating(CR_HASTE_RANGED)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetRangedHasteBonus()
    local hasteBonus = GetCombatRatingBonus(CR_HASTE_RANGED)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

---@return string
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
    if (not ECS.IsWotlk) then
        local rangedEnchant = DataUtils:GetEnchantForEquipSlot(Utils.CHAR_EQUIP_SLOTS["Range"])
        if rangedEnchant and rangedEnchant == Data.enchantIds.BIZNICK_SCOPE then
            hitValue = hitValue + 3
        end
    end

    local hitFromItems
    if CR_HIT_RANGED then
        hitFromItems = GetCombatRatingBonus(CR_HIT_RANGED)
    else
        hitFromItems = GetHitModifier()
    end

    if hitFromItems then -- This needs to be checked because on dungeon entering it becomes nil
        hitValue = hitValue + hitFromItems + _Ranged:GetHitTalentBonus()
    end

    return hitValue
end

function _Ranged:GetHitTalentBonus()
    local bonus = 0

    if ECS.IsWotlk and classId == Data.HUNTER then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 27)
        bonus = points * 1 -- 0-3% Focused Aim
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
