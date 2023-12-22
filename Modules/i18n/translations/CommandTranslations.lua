---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local commandTranslations = {
    ["ECS %s"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
    },
    ["/ecs toggle"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
    },
    ["Toggles the visibility of the stats window"] = {
        ["enUS"] = true,
        ["deDE"] = "Öffnet/Schließt das Attributefenster",
        ["frFR"] = "Affiche/Cache la fenêtre des statistiques ECS",
        ["zhCN"] = "切换统计信息窗口",
        ["ruRU"] = "Открыть окно характеристик",
        ["esES"] = "Alterna la visibilidad de la ventana de estadísticas",
        ["esMX"] = "Alterna la visibilidad de la ventana de estadísticas",
    },
    ["/ecs config"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
    },
    ["Shows the configuration window"] = {
        ["enUS"] = true,
        ["deDE"] = "Öffnet/Schließt das Einstellungsfenster",
        ["frFR"] = "Affiche la fenêtre de configuration ECS",
        ["zhCN"] = "显示配置窗口",
        ["ruRU"] = "Открыть окно настроек",
        ["esES"] = "Muestra la ventana de configuración",
        ["esMX"] = "Muestra la ventana de configuración",
    },
}

for k, v in pairs(commandTranslations) do
    i18n.translations[k] = v
end
