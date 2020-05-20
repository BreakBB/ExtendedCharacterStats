---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local strings = {}

function i18n:UseEnglish()
    i18n.texts = strings
end

strings = {
    -- Slash commands
    ["AVAILABLE_COMMANDS"] = "Available Commands",
    ["SLASH_TOGGLE"] = "/ecs toggle",
    ["SLASH_TOGGLE_DESC"] = "Toggles the visibility of the stats window",
    ["SLASH_CONFIG"] = "/ecs config",
    ["SLASH_CONFIG_DESC"] = "Shows the configuration window",

    ["NAME_VERSION"] = "ECS %s",
    ["SETTINGS"] = "Settings",
}
