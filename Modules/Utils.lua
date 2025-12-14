---@class Utils
local Utils = ECSLoader:CreateModule("Utils")

local GetAddOnInfo = C_AddOns and C_AddOns.GetAddOnInfo or GetAddOnInfo

---@class table<string, EquipSlot>
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
    ["Waist"] = "WaistSlot",
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

---@class Colors
Utils.colors = {
    ATTACK_POWER_PRIMARY = "ffa000",
    ATTACK_POWER_SECONDARY = "ffd149",
    CRIT_PRIMARY = "d32f2f",
    CRIT_SECONDARY = "ff6659",
    HIT_PRIMARY = "558b2f",
    HIT_SECONDARY = "85bb5c",
    --ATTACK_SPEED_PRIMARY = "006978",
    ATTACK_SPEED_PRIMARY = "00766c",
    --ATTACK_SPEED_SECONDARY = "0097a7",
    ATTACK_SPEED_SECONDARY = "009688",
    MP5_PRIMARY = "0d47a1",
    MP5_SECONDARY = "5472d3",
    DEFENSE_PRIMARY = "8d6e63",
    DEFENSE_SECONDARY = "be9c91",

    HASTE_RATING_PRIMARY = "ffd740",
    HASTE_RATING_SECONDARY = "c8a600",

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

---@param text string
---@param color Color
function Utils.Colorize(text, color)
    return "|cFF" .. color .. text .. "|r"
end

local cachedTitle
---@return number, number, number
function Utils:GetAddonVersionInfo()
    if (not cachedTitle) then
        local _, title, _, _, _ = GetAddOnInfo("ExtendedCharacterStats")
        cachedTitle = title
    end
    -- %d = digit, %p = punctuation character, %x = hexadecimal digits.
    local major, minor, patch, _ = string.match(cachedTitle, "(%d+)%p(%d+)%p(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

---@return string
function Utils:GetAddonVersionString()
    local major, minor, patch = Utils:GetAddonVersionInfo()
    return "v" .. tostring(major) .. "." .. tostring(minor) .. "." .. tostring(patch)
end

return Utils
