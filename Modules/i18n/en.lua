---@type i18n
local i18n = ECSLoader:LoadModule("i18n")

local strings = {}

function i18n:UseEnglish()
    i18n.texts = strings
end

strings = {
    ["NAME_VERSION"] = "ECS %s",
    ["SETTINGS"] = "Settings",
}
