---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local defenseConfigTranslations = {
    ["Show Defense Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Verteidigungswerte anzeigen",
        ["frFR"] = "Afficher défense",
        ["zhCN"] = "显示防御属性",
        ["ruRU"] = "Защита",
        ["esES"] = "Mostrar defensa",
        ["esMX"] = "Mostrar defensa",
        ["ptBR"] = "Mostrar defesa"
    },
    ["Shows/Hides all defense stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Verteidigungswerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de défense.",
        ["zhCN"] = "显示/隐藏 所有防御属性",
        ["ruRU"] = "Показать/скрыть все характеристики защиты",
        ["esES"] = "Muestra/oculta todas estadísticas de defensa",
        ["esMX"] = "Muestra/oculta todas estadísticas de defensa",
        ["ptBR"] = "Mostra/oculta todas as estatísticas de defesa"
    },
    ["Shows/Hides the armor value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Rüstungswert.",
        ["frFR"] = "Affiche/cache la valeur de l'armure.",
        ["zhCN"] = "显示/隐藏 护甲值",
        ["ruRU"] = "Показать/скрыть значение брони",
        ["esES"] = "Muestra/oculta el valor de armadura",
        ["esMX"] = "Muestra/oculta el valor de armadura",
        ["ptBR"] = "Mostra/oculta o valor de armadura"
    },
    ["Shows/Hides the percentage of being crit immune."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die erreichte Crit Immunität in Prozent.",
        ["frFR"] = "Affiche/cache le pourcentage d'immunité aux critiques.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть шанс невосприимчивости к критическому урону",
        ["esES"] = "Muestra/oculta el porcentaje de inmunidad a los golpes críticos",
        ["esMX"] = "Muestra/oculta el porcentaje de inmunidad a los golpes críticos",
        ["ptBR"] = "Mostra/oculta a porcentagem de imunidade a golpes críticos"
    },
    ["Shows/Hides the reduction percentage of being critically hit."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt, um wie viel Prozent die Chance kritisch getroffen zu werden reduziert ist.",
        ["frFR"] = "Affiche/cache le pourcentage de réduction des coups critiques.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть шанс снижения вероятности получить критический урон",
        ["esES"] = "Muestra/oculta el porcentaje de reducción de ser golpeado críticamente",
        ["esMX"] = "Muestra/oculta el porcentaje de reducción de ser golpeado críticamente",
        ["ptBR"] = "Mostra/oculta a porcentagem de redução de ser golpeado criticamente"
    },
    ["Shows/Hides the defense value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die den Verteidigungswert.",
        ["frFR"] = "Affiche/cache la valeur de défense.",
        ["zhCN"] = "显示/隐藏 防御值",
        ["ruRU"] = "Показать/скрыть значение защиты",
        ["esES"] = "Muestra/oculta el valor de defensa",
        ["esMX"] = "Muestra/oculta el valor de defensa",
        ["ptBR"] = "Mostra/oculta o valor de defesa"
    },
    ["Shows/Hides the defense rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Verteidigungswertung.",
        ["frFR"] = "Affiche/cache le score de défense.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение дополнительной защиты",
        ["esES"] = "Muestra/oculta el índice de defensa",
        ["esMX"] = "Muestra/oculta el índice de defensa",
        ["ptBR"] = "Mostra/oculta a taxa de defesa"
    },
    ["Shows/Hides the block chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Blockchance.",
        ["frFR"] = "Affiche/cache les chances de bloquer.",
        ["zhCN"] = "显示/隐藏 格挡几率",
        ["ruRU"] = "Показать/скрыть значение шанса блокирования",
        ["esES"] = "Muestra/oculta la probababilidad de bloquear",
        ["esMX"] = "Muestra/oculta la probababilidad de bloquear",
        ["ptBR"] = "Mostra/oculta a chance de bloquear"
    },
    ["Shows/Hides the block value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Blockwertung.",
        ["frFR"] = "Affiche/cache le score de blocage.",
        ["zhCN"] = "显示/隐藏 格挡值",
        ["ruRU"] = "Показать/скрыть значение рейтинга блокирования",
        ["esES"] = "Muestra/oculta el valor de bloqueo",
        ["esMX"] = "Muestra/oculta el valor de bloqueo",
        ["ptBR"] = "Muestra/oculta o valor de bloqueio"
    },
    ["Shows/Hides the parry chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Parrierwertung.",
        ["frFR"] = "Affiche/cache les chances de parer.",
        ["zhCN"] = "显示/隐藏 招架几率",
        ["ruRU"] = "Показать/скрыть шанс парирования атак",
        ["esES"] = "Muestra/oculta la probabilidad de parar",
        ["esMX"] = "Muestra/oculta la probabilidad de parar",
        ["ptBR"] = "Mostra/oculta a chance de aparar"
    },
    ["Shows/Hides the dodge chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Ausweichchance.",
        ["frFR"] = "Affiche/cache les chances d'esquiver.",
        ["zhCN"] = "显示/隐藏 躲闪几率",
        ["ruRU"] = "Показать/скрыть шанс уклонения от атак",
        ["esES"] = "Muestra/oculta la probabilidad de esquivar",
        ["esMX"] = "Muestra/oculta la probabilidad de esquivar",
        ["ptBR"] = "Mostra/oculta a chance de esquivar"
    },
    ["Shows/Hides the resilience value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Abhärtungswert.",
        ["frFR"] = "Affiche/cache la valeur de résilience.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение устойчивости",
        ["esES"] = "Muestra/oculta el valor de temple",
        ["esMX"] = "Muestra/oculta el valor de temple",
        ["ptBR"] = "Mostra/oculta o valor de resiliência"
    },
    ["Shows/Hides the total avoidance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Vermeidungswert.",
        ["frFR"] = "Affiche/cache l'évitement total.",
        ["zhCN"] = false,
        ["ruRU"] = false,
        ["esES"] = "Muestra/oculta eludir",
        ["esMX"] = "Muestra/oculta eludir",
        ["ptBR"] = "Mostra/oculta evasiva"
    },
}

for k, v in pairs(defenseConfigTranslations) do
    i18n.translations[k] = v
end
