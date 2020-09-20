---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _GetMP5ValueOnItems, _GetTalentModifier

local _, _, classId = UnitClass("player")

-- Get MP5 from items
function Data:GetMP5FromItems()
    local mp5 = _GetMP5ValueOnItems()
    mp5 = mp5 + Data:GetSetBonusValueMP5()
    return mp5
end

_GetMP5ValueOnItems = function ()
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

function Data:GetMP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return DataUtils:Round(base, 0) * 5
end

-- Get manaregen while casting
function Data:GetMP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = lastManaReg
    end
    lastManaReg = casting

    local mod = _GetTalentModifier()
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

_GetTalentModifier = function()
    local mod = 0

    if classId == Data.PRIEST then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 8)
        mod = points * 0.05 -- 0-15% from Meditation
    elseif classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12)
        mod = points * 0.05 -- 0-15% Arcane Meditation
    elseif classId == Data.DRUID then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 0.05 -- 0-15% from Reflection
    end

    return mod
end

function Data:GetMP5FromBuffs()
    local mod = 0
    local bonus = 0

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
        if spellId == 16609 then
            bonus = bonus + 10 -- 10 MP5 from Warchief's Blessing
        end
        if spellId == 18194 then
            bonus = bonus + 8 -- 8 MP5 from Nightfin Soup
        end
        if spellId == 25691 then
            bonus = bonus + 6 -- 6 MP5 from Sagefish Delight
        end
        if spellId == 25690 then
            bonus = bonus + 3 -- 8 MP5 from Smoked Sagefish
        end
        if spellId == 5677 then
            bonus = bonus + 10 -- 4 Mana per 2 seconds from Mana Spring Totem (Rank 1)
        end
        if spellId == 10491 then
            bonus = bonus + 15 -- 6 Mana per 2 seconds from Mana Spring Totem (Rank 2)
        end
        if spellId == 10493 then
            bonus = bonus + 20 -- 8 Mana per 2 seconds from Mana Spring Totem (Rank 3)
        end
        if spellId == 10494 then
            bonus = bonus + 25 -- 10 Mana per 2 seconds from Mana Spring Totem (Rank 4)
        end
        if spellId == 25894 then
        	bonus = bonus + 30 -- Greater Blessing of Wisdom Rank 1
        end
        if spellId == 25918 then
        	bonus = bonus + 33 -- Greater Blessing of Wisdom Rank 2
        end
        if spellId == 19742 then
        	bonus = bonus + 10 -- Blessing of Wisdom Rank 1
        end
        if spellId == 19850 then
        	bonus = bonus + 15 -- Blessing of Wisdom Rank 2
        end
        if spellId == 19852 then
        	bonus = bonus + 20 -- Blessing of Wisdom Rank 3
        end
        if spellId == 19853 then
        	bonus = bonus + 25 -- Blessing of Wisdom Rank 4
        end
        if spellId == 19854 then
        	bonus = bonus + 30 -- Blessing of Wisdom Rank 5
        end
        if spellId == 25290 then
        	bonus = bonus + 33 -- Blessing of Wisdom Rank 6
        end
        if spellId == 17252 then
        	bonus = bonus + 22 -- 22 MP5 from Mark of the Dragon Lord
        end
    end

    return mod, bonus
end
