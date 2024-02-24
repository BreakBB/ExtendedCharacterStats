---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local generalConfigTranslations = {
    ["Show General Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemeine Werte anzeigen",
        ["frFR"] = "Afficher les statistiques",
        ["zhCN"] = "显示常规属性信息",
        ["ruRU"] = "Основные характеристики",
        ["esES"] = "Mostrar estadísticas",
        ["esMX"] = "Mostrar estadísticas",
        ["ptBR"] = "Mostrar estatísticas"
    },
    ["Shows/Hides all general stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die allgemeinen Werte.",
        ["frFR"] = "Affiche/cache toutes les statistiques générales.",
        ["zhCN"] = "显示/隐藏 所有常规属性信息。",
        ["ruRU"] = "Показать/скрыть все основные характеристики",
        ["esES"] = "Muestra/oculta todas estadísticas generales",
        ["esMX"] = "Muestra/oculta todas estadísticas generales",
        ["ptBR"] = "Mostra/oculta todas as estatísticas gerais"
    },
    ["Show Movement Speed"] = {
        ["enUS"] = true,
        ["deDE"] = "Bewegungsgeschwindigkeit anzeigen",
        ["frFR"] = "Afficher la vitesse de déplacement",
        ["zhCN"] = "显示移动速度",
        ["ruRU"] = "Скорость движения",
        ["esES"] = "Mostrar velocidad de movimiento",
        ["esMX"] = "Mostrar velocidad de movimiento",
        ["ptBR"] = "Mostrar velocidade de movimento"
    },
    ["Shows/Hides the movement speed value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Bewegungsgeschwindigkeit.",
        ["frFR"] = "Affiche/cache la vitesse de déplacement.",
        ["zhCN"] = "显示/隐藏 移动速度",
        ["ruRU"] = "Показать/скрыть значение скорости движения",
        ["esES"] = "Muestra/oculta el valor de velocidad de movimiento",
        ["esMX"] = "Muestra/oculta el valor de velocidad de movimiento",
        ["ptBR"] = "Mostra/oculta o valor da velocidade de movimento"
    },
}

for k, v in pairs(generalConfigTranslations) do
    i18n.translations[k] = v
end
