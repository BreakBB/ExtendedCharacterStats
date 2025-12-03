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
            if enchant then
                mp5 = mp5 + (Data.enchantsMP5[enchant] or 0)
            end
            -- Check for socketed gems (TODO: check for socket bonus)
            local gem1, gem2, gem3 = DataUtils:GetSocketedGemsFromItemLink(itemLink)
            if gem1 then
                mp5 = mp5 + (Data.gemsMP5[gem1] or 0)
            end
            if gem2 then
                mp5 = mp5 + (Data.gemsMP5[gem2] or 0)
            end
            if gem3 then
                mp5 = mp5 + (Data.gemsMP5[gem3] or 0)
            end
        end
    end

    -- Check weapon enchants (e.g. Mana Oil)
    local hasMainEnchant, _, _, mainHandEnchantID = GetWeaponEnchantInfo()
    mainHandEnchantID = tostring(mainHandEnchantID)
    if (hasMainEnchant) then
        mp5 = mp5 + (Data.enchantsMP5[mainHandEnchantID] or 0)
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
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            bonus = bonus + Data.BuffsMP5[aura.spellId]
            if _MP5:HasLightningShield(aura.spellId) and Data:IsSetBonusActive(Data.setNames.THE_EARTHSHATTERER, 8) then
                bonus = bonus + 15 -- 15 MP5 from Shaman T3 8 piece bonus when Lightning Shield is active
            end
            if aura.spellId == 6117 or aura.spellId == 22782 or aura.spellId == 22783 then
                mod = mod + 0.3 -- 30% from Mage Armor
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
            if ECS.IsTbc then
                if aura.spellId == 33265 then
                    bonus = bonus + 8 -- well fed
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
                elseif aura.spellId == 31036 then
                    bonus = bonus + 45 -- Verdant Flame
                elseif aura.spellId == 46386 then
                    bonus = bonus + 66 -- Luminous Bluetail
                elseif aura.spellId == 37656 then
                     bonus = bonus + 76 -- wisdom
                elseif aura.spellId == 40568 or aura.spellId == 40582 then -- Only works in Blade's Edge Mountains Plateaus and Gruul's Lair.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if (instanceID and instanceID == 565) or C_Map.GetBestMapForUnit("player") == 1949 then
                        bonus = bonus + 8 -- Unstable Flask of the Elder
                    end
                elseif aura.spellId == 41605 or aura.spellId == 41610 then -- Only active in Tempest Keep, Serpentshrine Cavern, Caverns of Time: Mount Hyjal, Black Temple and the Sunwell Plateau.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if instanceID and (instanceID == 550 or instanceID == 548 or instanceID == 543 or instanceID == 564 or instanceID == 580) then
                        bonus = bonus + 25 -- Mighty Restoration of Shattrath
                    end
                end
            end
            if ECS.IsWotlk then
                if aura.spellId == 25694 then
                    bonus = bonus + 4 -- Well Fed
                elseif aura.spellId == 25941 then
                    bonus = bonus + 8 -- well fed
                elseif aura.spellId == 18194 or aura.spellId == 33265 then
                    bonus = bonus + 10
                elseif aura.spellId == 28145 then
                    bonus = bonus + 14 -- 14 MP5 from Druid Atiesh
                elseif aura.spellId == 24363 then
                    bonus = bonus + 15
                elseif aura.spellId == 28820 or aura.spellId == 38437 then
                    bonus = bonus + 19
                elseif aura.spellId == 28509 then
                    bonus = bonus + 20
                elseif aura.spellId == 35095 then
                    bonus = bonus + 26
                elseif aura.spellId == 43742 then
                    bonus = bonus + 28 -- Grace of the Naaru
                elseif aura.spellId == 28804 then
                    bonus = bonus + 30
                elseif aura.spellId == 28519 then
                    bonus = bonus + 31 -- Flask of Mighty Restoration
                elseif aura.spellId == 28795 or aura.spellId == 28824 then
                    bonus = bonus + 35
                elseif aura.spellId == 31036 then
                    bonus = bonus + 56 -- Verdant Flame
                elseif aura.spellId == 46386 then
                    bonus = bonus + 83 -- Luminous Bluetail
                elseif aura.spellId == 37656 then
                    bonus = bonus + 95 -- wisdom
                elseif aura.spellId == 40568 or aura.spellId == 40582 then -- Only works in Blade's Edge Mountains Plateaus and Gruul's Lair.
                    local _, _, _, _, _, _, _, instanceID, _, _ = GetInstanceInfo()
                    if (instanceID and instanceID == 565) or C_Map.GetBestMapForUnit("player") == 1949 then
                        bonus = bonus + 12 -- Unstable Flask of the Elder
                    end
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
                elseif aura.spellId == 25694 then
                    bonus = bonus + 3
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
                if aura.spellId == 27143 or aura.spellId == 27142 then
                    local blessingMod = _MP5:GetBlessingOfWisdomModifier() + 1
                    bonus = bonus + math.ceil(41 * blessingMod) -- Greater Blessing of Wisdom Rank 3
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
