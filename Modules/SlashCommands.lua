---@type i18n
local i18n = ECSLoader:ImportModule("i18n")
---@type Config
local Config = ECSLoader:ImportModule("Config")

local function _HandleSlash(msg)
    local cmd = string.lower(msg) or "help"

    if cmd == "toggle" then
        Stats:ToggleWindow()
    elseif cmd == "config" then
        Config:ToggleWindow()
    else
        print(i18n("AVAILABLE_COMMANDS"))
        print(i18n("SLASH_TOGGLE") .. " - " .. i18n("SLASH_TOGGLE_DESC"))
        print(i18n("SLASH_CONFIG") .. " - " .. i18n("SLASH_CONFIG_DESC"))
    end
end

SLASH_ECS1 = "/ecs"
SlashCmdList["ECS"] = _HandleSlash
