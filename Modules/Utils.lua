---@class Utils
local Utils = ECSLoader:CreateModule("Utils")

local function _StrStartsWith(str, start)
    return string.sub(str, 1, str.len(start)) == start
end

Utils.CHAR_EQUIP_SLOTS = {
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

Utils.colors = {
    ATTACK_POWER_PRIMARY = "ffa000",
    ATTACK_POWER_SECONDARY = "ffd149",
    CRIT_PRIMARY = "d32f2f",
    CRIT_SECONDARY = "ff6659",
    HIT_PRIMARY = "558b2f",
    -- HIT_PRIMARY = "aed581",
    HIT_SECONDARY = "85bb5c",
    -- HIT_SECONDARY = "e1ffb1",
    MP5_PRIMARY = "0d47a1",
    MP5_SECONDARY = "5472d3",
    DEFENSE_PRIMARY = "8d6e63",
    DEFENSE_SECONDARY = "be9c91",

    ARCANE_PRIMARY = "80deea",
    ARCANE_SECONDARY = "b4ffff",
    FIRE_PRIMARY = "d50000",
    FIRE_SECONDARY = "ff5131",
    FROST_PRIMARY = "00b0ff",
    FROST_SECONDARY = "69e2ff",
    HEALING_PRIMARY = "f5f5f5",
    HEALING_SECONDARY = "ffffff",
    HOLY_PRIMARY = "ffd600",
    HOLY_SECONDARY = "ff9e40",
    NATURE_PRIMARY = "64dd17",
    NATURE_SECONDARY = "9cff57",
    PHYSICAL_PRIMARY = "cfcfcf",
    PHYSICAL_SECONDARY = "9e9e9e",
    SHADOW_PRIMARY = "aa00ff",
    SHADOW_SECONDARY = "e254ff",

    WHITE = "FFFFFF",
    GRAY = "A8A8A8",
}

function Utils:Colorize(text, color)
    return "|cFF" .. color .. text .. "|r"
end

---@param statTextRef string The text from a stat of the profile
---@return table<string, string, string> -- The colors for statText, statValue and the percent symbol
function Utils:GetColorsForStatTextRef(statTextRef)
    local colors = Utils.colors

    local statTextColor = colors.DEFENSE_SECONDARY
    local statValueColor = colors.DEFENSE_PRIMARY
    local percentColor = colors.DEFENSE_PRIMARY

    if statTextRef == "ATTACK_POWER" then
        statTextColor = colors.ATTACK_POWER_SECONDARY
        statValueColor = colors.ATTACK_POWER_PRIMARY
        percentColor = colors.ATTACK_POWER_PRIMARY
    end
    if statTextRef == "CRIT_CHANCE" then
        statTextColor = colors.CRIT_SECONDARY
        statValueColor = colors.CRIT_PRIMARY
        percentColor = colors.CRIT_PRIMARY
    end
    if statTextRef == "BONUS" or statTextRef == "MISS" or statTextRef == "MISS_BOSS" then
        statTextColor = colors.HIT_SECONDARY
        statValueColor = colors.HIT_PRIMARY
        percentColor = colors.HIT_PRIMARY
    end

    if _StrStartsWith(statTextRef, "MP5_") then
        statTextColor = colors.MP5_SECONDARY
        statValueColor = colors.MP5_PRIMARY
        percentColor = colors.MP5_PRIMARY
    end

    if _StrStartsWith(statTextRef, "HEALING_") then
        statTextColor = colors.HEALING_SECONDARY
        statValueColor = colors.HEALING_PRIMARY
        percentColor = colors.HEALING_PRIMARY
    end
    if _StrStartsWith(statTextRef, "ARCANCE_") then
        statTextColor = colors.ARCANE_SECONDARY
        statValueColor = colors.ARCANE_PRIMARY
        percentColor = colors.ARCANE_PRIMARY
    end
    if _StrStartsWith(statTextRef, "FIRE_") then
        statTextColor = colors.FIRE_SECONDARY
        statValueColor = colors.FIRE_PRIMARY
        percentColor = colors.FIRE_PRIMARY
    end
    if _StrStartsWith(statTextRef, "FROST_") then
        statTextColor = colors.FROST_SECONDARY
        statValueColor = colors.FROST_PRIMARY
        percentColor = colors.FROST_PRIMARY
    end
    if _StrStartsWith(statTextRef, "HOLY_") then
        statTextColor = colors.HOLY_SECONDARY
        statValueColor = colors.HOLY_PRIMARY
        percentColor = colors.HOLY_PRIMARY
    end
    if _StrStartsWith(statTextRef, "NATURE_") then
        statTextColor = colors.NATURE_SECONDARY
        statValueColor = colors.NATURE_PRIMARY
        percentColor = colors.NATURE_PRIMARY
    end
    if _StrStartsWith(statTextRef, "PHYSICAL_") then
        statTextColor = colors.PHYSICAL_SECONDARY
        statValueColor = colors.PHYSICAL_PRIMARY
        percentColor = colors.PHYSICAL_PRIMARY
    end
    if _StrStartsWith(statTextRef, "SHADOW_") then
        statTextColor = colors.SHADOW_SECONDARY
        statValueColor = colors.SHADOW_PRIMARY
        percentColor = colors.SHADOW_PRIMARY
    end

    if (ExtendedCharacterStats.general.statColorSelection == "texts") then
        statValueColor = colors.GRAY
        percentColor = colors.GRAY
    end
    if (ExtendedCharacterStats.general.statColorSelection == "values") then
        statTextColor = colors.GRAY
    end

    return statTextColor, statValueColor, percentColor
end

local cachedTitle
function Utils:GetAddonVersionInfo()
    if (not cachedTitle) then
        local _, title, _, _, _ = GetAddOnInfo("ExtendedCharacterStats")
        cachedTitle = title
    end
    -- %d = digit, %p = punctuation character, %x = hexadecimal digits.
    local major, minor, patch, _ = string.match(cachedTitle, "(%d+)%p(%d+)%p(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

function Utils:GetAddonVersionString()
    local major, minor, patch = Utils:GetAddonVersionInfo()
    return "v" .. tostring(major) .. "." .. tostring(minor) .. "." .. tostring(patch)
end