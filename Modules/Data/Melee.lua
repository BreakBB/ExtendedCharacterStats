---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Melee = {}
local _, _, classId = UnitClass("player")

local w1Id, _ = GetInventoryItemID("player", 16)
local w2Id, _ = GetInventoryItemID("player", 17)
local weaponsId = {w1Id, w2Id}

---@return string
function Data:GetMeleeAttackPower()
    local melee, posBuff, negBuff = UnitAttackPower("player")
    return melee + posBuff + negBuff
end

---@param creature number
---@return string
function Data:GetMeleeAttackPowerVsCreature(creature)
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
        -- auras
        if C_UnitAuras.GetPlayerAuraBySpellID(24833) then dmg = dmg + 300 end -- holy mightstone
        if C_UnitAuras.GetPlayerAuraBySpellID(17352) then dmg = dmg + 200 end -- Argent Avenger
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
        if ECS.IsTbc or ECS.IsWotlk then
            -- auras
            if C_UnitAuras.GetPlayerAuraBySpellID(28486) then dmg = dmg + 30 end -- Scourgebane Draught
        end
    elseif creature == Data.DEMON then
        -- auras
        if C_UnitAuras.GetPlayerAuraBySpellID(11406) then dmg = dmg + 265 end -- Elixir of Demonslaying
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
                elseif i == 12709 then dmg = dmg + 45 end -- pip's skinner
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

---@return string
function Data:GetMeleeAttackSpeedMainHand()
    local mainHand, _ = UnitAttackSpeed("player")
    return DataUtils:Round(mainHand, 2)
end

---@return string
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

function _Melee:GetHitTalentBonus()
    local mod = 0

    if classId == Data.WARRIOR and ECS.IsWotlk then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 18)
        mod = points * 1 -- 0-3% Precision
    end

    if ECS.IsWotlk and classId == Data.HUNTER then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 27)
        mod = points * 1 -- 0-3% Focused Aim
    end

    if classId == Data.SHAMAN then
        if ECS.IsWotlk then
            if Data:GetMeleeAttackSpeedOffHand() > 0 then
                local _, _, _, _, dualWielding, _, _, _ = GetTalentInfo(2, 19)
                mod = mod + dualWielding * 2 -- 0-6% Dual Wielding Specialization
            end
        else
            local _, _, _, _, naturesGuidance, _, _, _ = GetTalentInfo(3, 3)
            mod = naturesGuidance * 1 -- 0-3% Nature's Guidance
        end
    end

    if ECS.IsTBC and classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 15)
        mod = points * 1 -- 0-3% Precision
    end

    if classId == Data.ROGUE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 1)
        mod = points * 1 -- 0-5% Precision
    end

    -- This assumes a DK is dual wielding and not only using a one-hand main hand weapon
    if classId == Data.DEATHKNIGHT and Data:GetMeleeAttackSpeedOffHand() > 0 then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 16)
        mod = points * 1 -- 0-3% Nerves of Cold Steel
    end

    return mod
end

function _Melee:GetHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 6562 then
            mod = mod + 1 -- 1% from Heroic Presence
            otherDraeneiInGroup = true
        end
    end

    if (not otherDraeneiInGroup) and (IsSpellKnown(6562) or IsSpellKnown(28878)) then
        mod = mod + 1
    end

    return mod
end

function _Melee.GetHitFromRunes()
    local mod = 0

    if (not ECS.IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if classId == Data.DRUID and (finger1Rune == 51245 or finger2Rune == 51245) and DataUtils:IsShapeshifted() then
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

function Data:GlanceDamageSameLevel()
    return Data:GlanceDamageByLevel(0)
end

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
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 24)
        armorPenetration = armorPenetration + points * 2 -- 0-10% Blood Gorged
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return string
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

