---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local commandTranslations = {
    ["ECS %s"] = {
        ["enUS"] = true,
        ["deDE"] = false,
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["/ecs toggle"] = {
        ["enUS"] = true,
        ["deDE"] = false,
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["/ecs config"] = {
        ["enUS"] = true,
        ["deDE"] = false,
        ["frFR"] = false,
        ["zhCN"] = false,
    },
}

for k, v in pairs(commandTranslations) do
    i18n.translations[k] = v
end
