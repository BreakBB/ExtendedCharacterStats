------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Utils
local Utils = ECSLoader:CreateModule("Utils")

-------------------------------------------------------------------

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