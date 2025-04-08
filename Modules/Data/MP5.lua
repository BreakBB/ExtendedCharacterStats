---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _MP5 = {}

local _, _, classId = UnitClass("player")

-- Get MP5 from items
---@return number
function Data:GetMP5FromItems()
    return _MP5:GetMP5ValueOnItems() + Data:GetSetBonusValueMP5() + _MP5.GetMP5FromRunes()
end

---@return number
function _MP5:GetMP5ValueOnItems()
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
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant and enchant == Data.enchantIds.BRACER_MANA_REGENERATION then
                mp5 = mp5 + 4
            end
            -- Priest ZG Enchant
            if enchant and enchant == Data.enchantIds.PROPHETIC_AURA then
                mp5 = mp5 + 4
            end
            -- Sapphiron Enchant
            if enchant and enchant == Data.enchantIds.RESILIENCE_OF_THE_SCOURGE then
                mp5 = mp5 + 5
            end
            -- Honor Hold/Thrallmar enchant
            if enchant and enchant == Data.enchantIds.GLYPH_OF_RENEWAL then
                mp5 = mp5 + 7
            end
            -- aldor enchant
            if enchant and enchant == Data.enchantIds.INSCRIPTION_OF_FAITH then
                mp5 = mp5 + 4
            end
            -- aldor enchant
            if enchant and enchant == Data.enchantIds.RESTORE_MANA_PRIME then
                mp5 = mp5 + 6
            end
            -- Check for socketed gems (TODO: check for socket bonus)
            local gem1, gem2, gem3 = DataUtils:GetSocketedGemsFromItemLink(itemLink)
            if gem1 then
                mp5 = mp5 + _MP5:GetGemBonusMP5(gem1)
            end
            if gem2 then
                mp5 = mp5 + _MP5:GetGemBonusMP5(gem2)
            end
            if gem3 then
                mp5 = mp5 + _MP5:GetGemBonusMP5(gem3)
            end
        end
    end

    -- Check weapon enchants (e.g. Mana Oil)
    local hasMainEnchant, _, _, mainHandEnchantID = GetWeaponEnchantInfo()
    mainHandEnchantID = tostring(mainHandEnchantID)
    if (hasMainEnchant) then
        if mainHandEnchantID == Data.enchantIds.BRILLIANT_MANA_OIL then
            mp5 = mp5 + 12
        end
        if mainHandEnchantID == Data.enchantIds.LESSER_MANA_OIL then
            mp5 = mp5 + 8
        end
        if mainHandEnchantID == Data.enchantIds.MINOR_MANA_OIL then
            mp5 = mp5 + 4
        end
    end

    return mp5
end

local lastManaReg = 0

---@return number
function Data:GetMP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second (including talent and buff modifiers)
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base

    return DataUtils:Round(base * 5, 2)
end

-- Get mana regen while casting
---@return number
function Data:GetMP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second (including talent and buff modifiers)
    if casting < 0.1 then
        casting = 0
    end

    local _, mp5BuffBonus = Data:GetMP5FromBuffs()
    local mp5Items = Data:GetMP5FromItems()
    casting = (casting * 5) + mp5Items + mp5BuffBonus

    return DataUtils:Round(casting, 2)
end

function Data:GetMP5OutsideCasting()
    local mp5FromSpirit = Data:GetMP5FromSpirit()
    local _, mp5BuffBonus = Data:GetMP5FromBuffs()
    local mp5FromItems = Data:GetMP5FromItems()

    local totalMP5 = mp5FromSpirit + mp5FromItems + mp5BuffBonus
    return DataUtils:Round(totalMP5, 2)
end

---@return number, number
function Data:GetMP5FromBuffs()
    local mod = 0
    local bonus = 0
    local has4pEarthshatterer = Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 4)

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i, "HELPFUL|HARMFUL")
        i = i + 1
        if aura and aura.spellId then
            if _MP5:HasLightningShield(aura.spellId) and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
                bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
            end
            if aura.spellId == 6117 or aura.spellId == 22782 or aura.spellId == 22783 then
                mod = mod + 0.3 -- 30% from Mage Armor
            elseif aura.spellId == 25690 or aura.spellId == 25694 then
                bonus = bonus + 3
            elseif aura.spellId == 25691 then
                bonus = bonus + 6 -- 6 MP5 from Sagefish Delight
            elseif aura.spellId == 16609 or aura.spellId == 355366 or aura.spellId == 460939 or aura.spellId == 460940 or aura.spellId == 370548 then
                bonus = bonus + 10
            elseif aura.spellId == 17252 then
                bonus = bonus + 22 -- 22 MP5 from Mark of the Dragon Lord
            elseif aura.spellId == 833 then
                bonus = bonus + 30 -- Green Tea
            elseif aura.spellId == 430 then
                bonus = bonus + 42 -- drink
            elseif aura.spellId == 21174 then
                bonus = bonus + 50 -- Aura of Battle
            elseif aura.spellId == 2639 then
                bonus = bonus + 70 -- food
            elseif aura.spellId == 21172 or aura.spellId == 25701 then
                bonus = bonus + 75
            elseif aura.spellId == 431 then
                bonus = bonus + 104 -- drink
            elseif aura.spellId == 25703 then
                bonus = bonus + 135 -- Brain Food
            elseif aura.spellId == 432 then
                bonus = bonus + 174 -- drink
            elseif aura.spellId == 25887 then
                bonus = bonus + 210 -- Brain Food
            elseif aura.spellId == 1133 then
                bonus = bonus + 249 -- drink
            elseif aura.spellId == 25889 or aura.spellId == 29039 then
                bonus = bonus + 300
            elseif aura.spellId == 1135 then
                bonus = bonus + 332 -- drink
            elseif aura.spellId == 26473 then
                bonus = bonus + 367 -- drink
            elseif aura.spellId == 1137 or aura.spellId == 29007 then
                bonus = bonus + 489
            elseif aura.spellId == 26475 then
                bonus = bonus + 551 -- drink
            elseif aura.spellId == 22734 then
                bonus = bonus + 700 -- drink
            elseif aura.spellId == 23698 or aura.spellId == 18140 or aura.spellId == 25696 or aura.spellId == 26402 or aura.spellId == 25697 or aura.spellId == 26261 then
                bonus = bonus + 735
            elseif aura.spellId == 10250 then
                bonus = bonus +  800 -- drink
            elseif aura.spellId == 19742 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(10 * blessingMod) -- Blessing of Wisdom Rank 1
            elseif aura.spellId == 19850 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(15 * blessingMod) -- Blessing of Wisdom Rank 2
            elseif aura.spellId == 19852 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(20 * blessingMod) -- Blessing of Wisdom Rank 3
            elseif aura.spellId == 19853 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(25 * blessingMod) -- Blessing of Wisdom Rank 4
            elseif aura.spellId == 25894 or aura.spellId == 19854 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(30 * blessingMod)
            elseif aura.spellId == 25918 or aura.spellId == 25290 then
                local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                bonus = bonus + math.ceil(33 * blessingMod)
            elseif aura.spellId == 5677 then
                bonus = bonus + 10 -- 4 Mana per 2 seconds from Mana Spring Totem (Rank 1)
                if has4pEarthshatterer then
                    bonus = bonus + 2.5 -- + 0,25% for Shaman T3 2 piece bonus
                end
            elseif aura.spellId == 10491 then
                bonus = bonus + 15 -- 6 Mana per 2 seconds from Mana Spring Totem (Rank 2)
                if has4pEarthshatterer then
                    bonus = bonus + 3.75 -- + 0,25% for Shaman T3 2 piece bonus
                end
            elseif aura.spellId == 10493 then
                bonus = bonus + 20 -- 8 Mana per 2 seconds from Mana Spring Totem (Rank 3)
                if has4pEarthshatterer then
                    bonus = bonus + 5 -- + 0,25% for Shaman T3 2 piece bonus
                end
            elseif aura.spellId == 10494 then
                bonus = bonus + 25 -- 10 Mana per 2 seconds from Mana Spring Totem (Rank 4)
                if has4pEarthshatterer then
                    bonus = bonus + 6.25 -- + 0,25% for Shaman T3 2 piece bonus
                end
            elseif aura.spellId == 25569 then
                bonus = bonus + 50 -- 20 Mana per 2 seconds from Mana Spring Totem (Rank 5)
                if has4pEarthshatterer then
                    bonus = bonus + 6.25 -- + 0,25% for Shaman T3 2 piece bonus
                end
            end
            if ECS.IsSoD then
                if aura.spellId == 430948 then
                    bonus = bonus + 8 -- 8 MP5 from Arcane Recovery
                elseif aura.spellId == 473441 then
                    bonus = bonus + 10 -- Might of Blackrock
                elseif aura.spellId == 446396 or aura.spellId == 448084 then
                    bonus = bonus + 12
                elseif aura.spellId == 1213886 then
                    bonus = bonus + 13 -- Flask of Unyielding Sorrow
                elseif aura.spellId == 1220542 or aura.spellId == 1220685 then
                    bonus = bonus + 28
                elseif aura.spellId == 468767 then
                    bonus = bonus + 851 -- drink
                elseif aura.spellId == 461632 or aura.spellId == 446714 then
                    bonus = bonus + 1104
                end
            elseif ECS.IsTbc then
                if aura.spellId == 33265 then
                    bonus = bonus + 8 -- well fed
                elseif aura.spellId == 40568 or aura.spellId == 40582 then -- Only works in Blade's Edge Mountains Plateaus and Gruul's Lair.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if (instanceID and instanceID == 565) or C_Map.GetBestMapForUnit("player") == 1949 then
                        bonus = bonus + 8 -- Unstable Flask of the Elder
                    end
                elseif aura.spellId == 38437 then
                    bonus = bonus + 15 -- Totemic Mastery
                elseif aura.spellId == 28509 then
                    bonus = bonus + 16 -- Greater Mana Regeneration
                elseif aura.spellId == 35095 then
                    bonus = bonus + 21 -- Enlightenment
                elseif aura.spellId == 43742 then
                    bonus = bonus + 22 -- Grace of the Naaru
                elseif aura.spellId == 28519 then
                    bonus = bonus + 25 -- Flask of Mighty Restoration
                elseif aura.spellId == 41605 or aura.spellId == 41610 then -- Only active in Tempest Keep, Serpentshrine Cavern, Caverns of Time: Mount Hyjal, Black Temple and the Sunwell Plateau.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if instanceID and (instanceID == 550 or instanceID == 548 or instanceID == 543 or instanceID == 564 or instanceID == 580) then
                        bonus = bonus + 25 -- Mighty Restoration of Shattrath
                    end
                elseif aura.spellId == 31036 then
                    bonus = bonus + 45 -- Verdant Flame
                elseif aura.spellId == 46386 then
                    bonus = bonus + 66 -- Luminous Bluetail
                elseif aura.spellId == 37656 then
                     bonus = bonus + 76 -- wisdom
                end
            end
            if ECS.IsWotlk then
                if aura.spellId == 25694 then
                    bonus = bonus + 4 -- Well Fed
                elseif aura.spellId == 25941 then
                    bonus = bonus + 8 -- well fed
                elseif aura.spellId == 18194 or aura.spellId == 33265 or aura.spellId == 52127 then
                    bonus = bonus + 10
                elseif aura.spellId == 40568 or aura.spellId == 40582 then -- Only works in Blade's Edge Mountains Plateaus and Gruul's Lair.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if (instanceID and instanceID == 565) or C_Map.GetBestMapForUnit("player") == 1949 then
                        bonus = bonus + 12 -- Unstable Flask of the Elder
                    end
                elseif aura.spellId == 28145 then
                    bonus = bonus + 14 -- 14 MP5 from Druid Atiesh
                elseif aura.spellId == 24363 or aura.spellId == 57291 or aura.spellId == 57107 or aura.spellId == 52129 then
                    bonus = bonus + 15
                elseif aura.spellId == 67696 then
                    bonus = bonus + 16 -- Energized
                elseif aura.spellId == 67750 then
                    bonus = bonus + 18 -- Energized
                elseif aura.spellId == 28820 or aura.spellId == 38437 then
                    bonus = bonus + 19
                elseif aura.spellId == 28509 or aura.spellId == 59674 then
                    bonus = bonus + 20
                elseif aura.spellId == 52131 then
                    bonus = bonus + 21 -- Water Shield
                elseif aura.spellId == 35095 or aura.spellId == 52134 then
                    bonus = bonus + 26
                elseif aura.spellId == 43742 then
                    bonus = bonus + 28 -- Grace of the Naaru
                elseif aura.spellId == 28804 or aura.spellId == 53764 then
                    bonus = bonus + 30
                elseif aura.spellId == 28519 then
                    bonus = bonus + 31 -- Flask of Mighty Restoration
                elseif aura.spellId == 52136 then
                    bonus = bonus + 33 -- Water Shield
                elseif aura.spellId == 28795 or aura.spellId == 28824 then
                    bonus = bonus + 35
                elseif aura.spellId == 52138 then
                    bonus = bonus + 38 -- Water Shield
                elseif aura.spellId == 57334 then
                    bonus = bonus + 40 -- Well Fed
                elseif aura.spellId == 54212 then
                    bonus = bonus + 45 -- Flask of Pure Mojo
                elseif aura.spellId == 31036 then
                    bonus = bonus + 56 -- Verdant Flame
                elseif aura.spellId == 46386 then
                    bonus = bonus + 83 -- Luminous Bluetail
                elseif aura.spellId == 37656 then
                    bonus = bonus + 95 -- wisdom
                elseif aura.spellId == 57960 then
                    bonus = bonus + 100 -- Water Shield
                elseif aura.spellId == 49623 then
                    bonus = bonus + 125 -- Effervescence
                elseif aura.spellId == 65003 or aura.spellId == 60520 then
                    bonus = bonus + 220
                elseif aura.spellId == 64739 then
                    bonus = bonus + 272 -- Show of Faith
                elseif aura.spellId == 71584 then
                    bonus = bonus + 304 -- Revitalized
                elseif aura.spellId == 72623 then
                    bonus = bonus + 489 -- Drink
                elseif aura.spellId == 53373 then
                    bonus = bonus + 1200 -- Thunderbrew's Hard Ale
                elseif aura.spellId == 43182 or aura.spellId == 61830 then
                    bonus = bonus + 2140
                elseif aura.spellId == 61268 then
                    bonus = bonus + 2160 -- Mana Regeneration
                elseif aura.spellId == 57073 or aura.spellId == 64356 or aura.spellId == 43183 or aura.spellId == 69561 or aura.spellId == 69560 or aura.spellId == 69563 or aura.spellId == 52911 then
                    bonus = bonus + 3200
                elseif aura.spellId == 65000 then
                    bonus = bonus + 85 * aura.applications -- Meteoric Inspiration
                elseif aura.spellId == 56521 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(91 * blessingMod)
                elseif aura.spellId == 48938 or aura.spellId == 48936 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(92 * blessingMod)
                elseif aura.spellId == 48937 or aura.spellId == 48935 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(73 * blessingMod)
                elseif aura.spellId == 27143 or aura.spellId == 27142 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(41 * blessingMod)
                elseif aura.spellId == 27143 or aura.spellId == 27142 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(41 * blessingMod)
                elseif aura.spellId == 41605 or aura.spellId == 41610 then -- Only active in Tempest Keep, Serpentshrine Cavern, Caverns of Time: Mount Hyjal, Black Temple and the Sunwell Plateau.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if instanceID and (instanceID == 550 or instanceID == 548 or instanceID == 543 or instanceID == 564 or instanceID == 580) then
                        bonus = bonus + 31 -- Mighty Restoration of Shattrath
                    end
                elseif aura.spellId == 52051 then -- within Zul'Drak, Gundrak, and Drak'Tharon Keep.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if C_Map.GetBestMapForUnit("player") == 121 or instanceID and (instanceID == 604 or instanceID == 600) then
                        bonus = bonus + 91 -- Blessing of Zim'Rhuk
                    end
                end
            else
                if aura.spellId == 25941 then
                    bonus = bonus + 6 -- well fed
                elseif aura.spellId == 18194 then
                    bonus = bonus + 8 -- 8 MP5 from Nightfin Soup
                elseif aura.spellId == 28145 then
                    bonus = bonus + 11 -- 11 MP5 from Druid Atiesh
                elseif aura.spellId == 24363 then
                    bonus = bonus + 12 -- 12 MP5 from Mageblood Potion
                elseif aura.spellId == 28820 then
                    bonus = bonus + 15 -- Lightning Shield
                elseif aura.spellId == 28804 then
                    bonus = bonus + 24 -- Epiphany
                elseif aura.spellId == 28795 or aura.spellId == 28824 then
                    bonus = bonus + 28
                end
            end
            if ECS.IsTbc or ECS.IsWotlk then
                if aura.spellId == 34410 then
                    bonus = bonus + 10 -- Hellscream's Warsong
                elseif aura.spellId == 31462 then
                    bonus = bonus + 12 -- Moonwell Restoration
                elseif aura.spellId == 32548 then
                    bonus = bonus + 33 -- Symbol of Hope
                elseif aura.spellId == 27143 or aura.spellId == 27142 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(41 * blessingMod) -- Greater Blessing of Wisdom Rank 3
                elseif aura.spellId == 24398 then
                    bonus = bonus + 43 -- 43 MP5 from Water Shield Rank 1
                elseif aura.spellId == 44107 then
                    bonus = bonus + 42 -- Brewfest Drink
                elseif aura.spellId == 33736 then
                    bonus = bonus + 50 -- 50 MP5 from Water Shield Rank 2
                elseif aura.spellId == 44109 then
                    bonus = bonus + 104 -- Brewfest Drink
                elseif aura.spellId == 44110 then
                    bonus = bonus + 174 -- Brewfest Drink
                elseif aura.spellId == 46755 then
                    bonus = bonus + 240 -- drink
                elseif aura.spellId == 44111 then
                    bonus = bonus + 249 -- Brewfest Drink
                elseif aura.spellId == 45019 or aura.spellId == 44112 then
                    bonus = bonus + 332
                elseif aura.spellId == 26473 then
                    bonus = bonus + 367 -- drink
                elseif aura.spellId == 43154 or aura.spellId == 44113 then
                    bonus = bonus + 489
                elseif aura.spellId == 26475 then
                    bonus = bonus + 551 -- drink
                elseif aura.spellId == 44114 then
                    bonus = bonus + 700 -- Brewfest Drink
                elseif aura.spellId == 26261 or aura.spellId == 26402 or aura.spellId == 33774 then
                    bonus = bonus + 735
                elseif aura.spellId == 34291 then
                    bonus = bonus + 850 -- drink
                elseif aura.spellId == 49472 or aura.spellId == 27089 or aura.spellId == 44115 or aura.spellId == 42312 or aura.spellId == 44116 or aura.spellId == 43706 or aura.spellId == 45020 then
                    bonus = bonus + 1200
                elseif aura.spellId == 42308 then
                    bonus = bonus + 1250 -- brain food
                end
            end
        end
    until (not aura)

    return mod, bonus
end

---@return boolean
function _MP5:HasLightningShield(spellId)
    return spellId == 324 or spellId == 325 or spellId == 905 or spellId == 945 or spellId == 8134 or spellId == 10431 or spellId == 10432
end

---@return number
function _MP5:GetBlessingOfWisdomModifier()
    local mod = 0
    if classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 10)
        mod = points * 0.1 -- 0-20% from Improved Blessing of Wisdom
    end
    return mod
end

---@return number
function _MP5:GetGemBonusMP5(gemId)
    for _, value in ipairs(Data.gemIds.FOUR_MP5_GEMS) do
        if value == gemId then
            return 4
        end
    end
    for _, value in ipairs(Data.gemIds.THREE_MP5_GEMS) do
        if value == gemId then
            return 3
        end
    end
    for _, value in ipairs(Data.gemIds.TWO_MP5_GEMS) do
        if value == gemId then
            return 2
        end
    end
    for _, value in ipairs(Data.gemIds.ONE_MP5_GEMS) do
        if value == gemId then
            return 1
        end
    end
    return 0
end

---@param school number
---@return number
function _MP5.GetMP5FromRunes()
    local mod = 0

    if (not ECS.IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if (finger1Rune == 7639 or finger2Rune == 7639) then
        mod = mod + 5 -- 5 MP5 from Meditation Specialization Rune
    end

    return mod
end
