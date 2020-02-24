---@class LocaleEN
local LocaleEN = ECSLoader:CreateModule("LocaleEN")

local strings = {}

function LocaleEN:GetStrings()
    return strings
end

strings = {
    ["NAME_VERSION"] = "Extended Character Stats %s",
    ["SETTINGS"] = "Settings",
}
