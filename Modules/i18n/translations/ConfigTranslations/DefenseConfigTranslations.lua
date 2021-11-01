---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local defenseConfigTranslations = {
    ["Show Defense Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Verteidigungswerte anzeigen",
        ["frFR"] = "Défense Général",
        ["zhCN"] = "显示防御属性",
        ["ruRU"] = "Защита",
    },
    ["Shows/Hides all defense stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Verteidigungswerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de défense.",
        ["zhCN"] = "显示/隐藏 所有防御属性",
        ["ruRU"] = "Показать/скрыть все характеристики защиты",
    },
    ["Shows/Hides the armor value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Rüstungswert.",
        ["frFR"] = "Affiche/cache la valeur de l'armure.",
        ["zhCN"] = "显示/隐藏 护甲值",
        ["ruRU"] = "Показать/скрыть значение брони",
    },
    ["Shows/Hides the percentage of being crit immune."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die erreichte Crit Immunität in Prozent.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть шанс невосприимчивости к критическому урону",
    },
    ["Shows/Hides the reduction percentage of being critically hit."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt, um wie viel Prozent die Chance kritisch getroffen zu werden reduziert ist.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть шанс снижения вероятности получить критический урон",
    },
    ["Shows/Hides the defense value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die den Verteidigungswert.",
        ["frFR"] = "Affiche/cache la valeur de défense.",
        ["zhCN"] = "显示/隐藏 防御值",
        ["ruRU"] = "Показать/скрыть значение защиты",
    },
    ["Shows/Hides the defense rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Verteidigungswertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение дополнительной защиты",
    },
    ["Shows/Hides the block chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Blockchance.",
        ["frFR"] = "Affiche/cache les chances de bloquer.",
        ["zhCN"] = "显示/隐藏 格挡几率",
        ["ruRU"] = "Показать/скрыть значение шанса блокирования",
    },
    ["Shows/Hides the block value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Blockwertung.",
        ["frFR"] = "Affiche/cache la valeur de bloquage.",
        ["zhCN"] = "显示/隐藏 格挡值",
        ["ruRU"] = "Показать/скрыть значение рейтинга блокирования",
    },
    ["Shows/Hides the parry chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Parrierwertung.",
        ["frFR"] = "Affiche/cache les chances de parer.",
        ["zhCN"] = "显示/隐藏 招架几率",
        ["ruRU"] = "Показать/скрыть шанс парирования атак",
    },
    ["Shows/Hides the dodge chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Ausweichchance.",
        ["frFR"] = "Affiche/cache les chances d'esquiver.",
        ["zhCN"] = "显示/隐藏 躲闪几率",
        ["ruRU"] = "Показать/скрыть шанс уклонения от атак",
    },
    ["Shows/Hides the resilience value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Abhärtungswert.",
        ["frFR"] = "Affiche/cache la valeur de résilience.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение устойчивости",
    },
}

for k, v in pairs(defenseConfigTranslations) do
    i18n.translations[k] = v
end
