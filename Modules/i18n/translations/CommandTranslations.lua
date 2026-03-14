---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local commandTranslations = {
    ["Available Commands"] = {
        ["enUS"] = true,
        ["deDE"] = "Verfügbare Befehle",
        ["frFR"] = "Commandes disponibles",
        ["zhCN"] = "可用命令",
        ["ruRU"] = "Доступные команды",
        ["esES"] = "Comandos disponibles",
        ["esMX"] = "Comandos disponibles",
        ["ptBR"] = "Comandos disponíveis"
    },
    ["ECS %s"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
        ["ptBR"] = true
    },
    ["/ecs toggle"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
        ["ptBR"] = true
    },
    ["Toggles the visibility of the stats window"] = {
        ["enUS"] = true,
        ["deDE"] = "Öffnet/Schließt das Attributefenster",
        ["frFR"] = "Affiche/cache la fenêtre des statistiques ECS",
        ["zhCN"] = "切换统计信息窗口",
        ["ruRU"] = "Открыть окно характеристик",
        ["esES"] = "Muestra/oculta la ventana de estadísticas",
        ["esMX"] = "Muestra/oculta la ventana de estadísticas",
        ["ptBR"] = "Mostra/oculta a janela de estatísticas"
    },
    ["/ecs config"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = true,
        ["ruRU"] = true,
        ["esES"] = true,
        ["esMX"] = true,
        ["ptBR"] = true
    },
    ["Shows the configuration window"] = {
        ["enUS"] = true,
        ["deDE"] = "Öffnet/Schließt das Einstellungsfenster",
        ["frFR"] = "Affiche la fenêtre de configuration ECS",
        ["zhCN"] = "显示配置窗口",
        ["ruRU"] = "Открыть окно настроек",
        ["esES"] = "Muestra la ventana de configuración",
        ["esMX"] = "Muestra la ventana de configuración",
        ["ptBR"] = "Mostra a janela de configuração"
    },
    ["Profile has been reset due to a major update."] = {
        ["enUS"] = true,
        ["deDE"] = "Profil wurde aufgrund eines größeren Updates zurückgesetzt.",
        ["frFR"] = "Le profil a été réinitialisé en raison d'une mise à jour majeure.",
        ["zhCN"] = "由于重大更新，配置文件已重置。",
        ["ruRU"] = "Профиль был сброшен из-за крупного обновления.",
        ["esES"] = "El perfil se ha restablecido debido a una actualización importante.",
        ["esMX"] = "El perfil se ha restablecido debido a una actualización importante.",
        ["ptBR"] = "O perfil foi redefinido devido a uma atualização importante.",
    },
}

for k, v in pairs(commandTranslations) do
    i18n.translations[k] = v
end
