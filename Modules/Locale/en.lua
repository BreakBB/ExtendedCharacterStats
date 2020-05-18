---@class LocaleEN
local LocaleEN = ECSLoader:CreateModule("LocaleEN")

local strings = {}

function LocaleEN:GetStrings()
    return strings
end

strings = {
    ["NAME_VERSION"] = "ECS %s",
    ["SETTINGS"] = "Settings",
}
