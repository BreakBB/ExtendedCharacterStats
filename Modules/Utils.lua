---@class Utils
local Utils = ECSLoader:CreateModule("Utils")

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

local cachedTitle = nil
function Utils:GetAddonVersionInfo()
    if (not cachedTitle) then
        local _, title, _, _, _ = GetAddOnInfo("ExtendedCharacterStats")
        cachedTitle = title
    end
    -- %d = digit, %p = punctuation character, %x = hexadecimal digits.
    local major, minor, patch, commit = string.match(cachedTitle, "(%d+)%p(%d+)%p(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

function Utils:GetAddonVersionString()
    local major, minor, patch = Utils:GetAddonVersionInfo()
    return "v" .. tostring(major) .. "." .. tostring(minor) .. "." .. tostring(patch)
end