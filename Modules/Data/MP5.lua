---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _MP5 = {}

local _, _, classId = UnitClass("player")

-- Get MP5 from items
---@return number
function Data:GetMP5FromItems()
    local mp5 = _MP5:GetMP5ValueOnItems()
    mp5 = mp5 + Data:GetSetBonusValueMP5()
    return mp5
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
    local _, intValue = UnitStat("player", 4)
    local _, spiritValue = UnitStat("player", 5)
    return DataUtils:Round((0.001 + (spiritValue * 0.009327 * (intValue^0.5))) * 5 * 0.6, 2)
end

-- Get mana regen while casting
---@return number
function Data:GetMP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = 0
    end

    if ECS.IsWotlk then
        casting = (casting * 5) + _MP5:GetTalentBonus()

        return DataUtils:Round(casting, 2)
    end

    local mod = _MP5:GetTalentModifier()
    if Data:HasSetBonusModifierMP5() then
        mod = mod + 0.15
    end
    local auraMod, auraValues = Data:GetMP5FromBuffs()
    mod = mod + auraMod
    if mod == 0 then
        casting = 0
    end
    casting = casting * mod

    local mp5Items = Data:GetMP5FromItems()
    casting = (casting * 5) + mp5Items + auraValues

    return DataUtils:Round(casting, 2)
end

function Data:GetMP5OutsideCasting()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return DataUtils:Round(base * 5, 2)
end

---@return number
function _MP5:GetTalentModifier()
    local mod = 0

    if classId == Data.PRIEST then
        local meditationTalentSlot = ECS.IsWotlk and 9 or 8
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, meditationTalentSlot)
        mod = points * 0.05 -- 0-15% from Meditation
    elseif classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12)
        mod = points * 0.05 -- 0-15% Arcane Meditation
    elseif classId == Data.DRUID then
        local _, _, _, _, reflectionPoints, _, _, _ = GetTalentInfo(3, 6)
        mod = reflectionPoints * 0.05 -- 0-15% from Reflection
    end

    return mod
end

---This is only relevant for the TBC client
---@return number
function _MP5:GetTalentBonus()
    local bonus = 0

    if classId == Data.DRUID then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 17)
        local _, intValue, _, _ = UnitStat("player", 4)

        if points == 1 then
            bonus = 0.04 * intValue -- 4% of Int as MP5
        elseif points == 2 then
            bonus = 0.07 * intValue -- 7% of Int as MP5
        elseif points == 3 then
            bonus = 0.1 * intValue -- 10% of Int as MP5
        end
    end

    if classId == Data.SHAMAN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 14)
        local _, intValue, _, _ = UnitStat("player", 4)

        bonus = points * 0.02 * intValue -- 0-10% of Int as MP5
    end

    return bonus
end

---@return number, number
function Data:GetMP5FromBuffs()
    local mod = 0
    local bonus = 0
    local has4pEarthshatterer = Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 4)

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 6117 or spellId == 22782 or spellId == 22783 then
            mod = mod + 0.3 -- 30% from Mage Armor
        end
        if spellId == 24363 then
            bonus = bonus + 12 -- 12 MP5 from Mageblood Potion
        end
        if spellId == 18194 then
            bonus = bonus + 8 -- 8 MP5 from Nightfin Soup
        end
        if spellId == 25691 then
            bonus = bonus + 6 -- 6 MP5 from Sagefish Delight
        end
        if spellId == 25690 then
            bonus = bonus + 3 -- 3 MP5 from Smoked Sagefish
        end
        if spellId == 33266 then
            bonus = bonus + 8 -- 8 MP5 from Blackened Sporefish
        end

        if spellId == 5677 then
            bonus = bonus + 10 -- 4 Mana per 2 seconds from Mana Spring Totem (Rank 1)
            if has4pEarthshatterer then
                bonus = bonus + 2.5 -- + 0,25% for Shaman T3 2 piece bonus
            end
        end
        if spellId == 10491 then
            bonus = bonus + 15 -- 6 Mana per 2 seconds from Mana Spring Totem (Rank 2)
            if has4pEarthshatterer then
                bonus = bonus + 3.75 -- + 0,25% for Shaman T3 2 piece bonus
            end
        end
        if spellId == 10493 then
            bonus = bonus + 20 -- 8 Mana per 2 seconds from Mana Spring Totem (Rank 3)
            if has4pEarthshatterer then
                bonus = bonus + 5 -- + 0,25% for Shaman T3 2 piece bonus
            end
        end
        if spellId == 10494 then
            bonus = bonus + 25 -- 10 Mana per 2 seconds from Mana Spring Totem (Rank 4)
            if has4pEarthshatterer then
                bonus = bonus + 6.25 -- + 0,25% for Shaman T3 2 piece bonus
            end
        end
        if spellId == 25569 then
            bonus = bonus + 50 -- 20 Mana per 2 seconds from Mana Spring Totem (Rank 5)
            if has4pEarthshatterer then
                bonus = bonus + 6.25 -- + 0,25% for Shaman T3 2 piece bonus
            end
        end

        if _MP5:HasLightningShield(spellId) and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
            bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
        end
        if spellId == 28824 then
            bonus = bonus + 28 -- 28 MP5 from Shaman T3 6 piece proc Totemic Power
        end
        if spellId == 24398 then
            bonus = bonus + 43 -- 43 MP5 from Water Shield Rank 1
        end
        if spellId == 33736 then
            bonus = bonus + 50 -- 50 MP5 from Water Shield Rank 2
        end

        if spellId == 25894 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(30 * blessingMod) -- Greater Blessing of Wisdom Rank 1
        end
        if spellId == 25918 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(33 * blessingMod) -- Greater Blessing of Wisdom Rank 2
        end
        if spellId == 27143 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(41 * blessingMod) -- Greater Blessing of Wisdom Rank 3
        end
        if spellId == 19742 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(10 * blessingMod) -- Blessing of Wisdom Rank 1
        end
        if spellId == 19850 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(15 * blessingMod) -- Blessing of Wisdom Rank 2
        end
        if spellId == 19852 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(20 * blessingMod) -- Blessing of Wisdom Rank 3
        end
        if spellId == 19853 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(25 * blessingMod) -- Blessing of Wisdom Rank 4
        end
        if spellId == 19854 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(30 * blessingMod) -- Blessing of Wisdom Rank 5
        end
        if spellId == 25290 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(33 * blessingMod) -- Blessing of Wisdom Rank 6
        end
        if spellId == 27142 then
            local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
            bonus = bonus + math.ceil(41 * blessingMod) -- Blessing of Wisdom Rank 7
        end

        if spellId == 16609 then
            bonus = bonus + 10 -- 10 MP5 from Warchief's Blessing
        end
        if spellId == 17252 then
            bonus = bonus + 22 -- 22 MP5 from Mark of the Dragon Lord
        end
        if spellId == 28145 then
            bonus = bonus + 11 -- 11 MP5 from Druid Atiesh
        end
    end

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
