---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local rangedConfigTranslations = {
    ["Show Ranged Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampfwerte anzeigen",
        ["frFR"] = "Afficher à distance",
        ["zhCN"] = "显示远程属性",
        ["ruRU"] = "Дальний бой",
        ["esES"] = "Mostrar a distancia",
        ["esMX"] = "Mostrar a distancia",
        ["ptBR"] = "Mostrar longo alcance"
    },
    ["Shows/Hides all ranged stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Fernkampfwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques à distance.",
        ["zhCN"] = "显示/隐藏 所有远程属性",
        ["ruRU"] = "Показать/скрыть все характеристики дальнего боя",
        ["esES"] = "Muestra/oculta todas estadísticas a distancia",
        ["esMX"] = "Muestra/oculta todas estadísticas a distancia"
    },
    ["Ranged Attack Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampf Angriffskraft",
        ["frFR"] = "Puissance d'attaque à distance",
        ["zhCN"] = "远程攻击强度",
        ["ruRU"] = "Сила атаки",
        ["esES"] = "Poder de ataque",
        ["esMX"] = "Poder de ataque",
        ["ptBR"] = "Poder de ataque"
    },
    ["Shows/Hides the ranged attack power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Fernkampf Angriffskraftwert.",
        ["frFR"] = "Affiche/cache la puissance d'attaque à distance.",
        ["zhCN"] = "显示/隐藏 远程攻击强度",
        ["ruRU"] = "Показать/скрыть значение силы атаки",
        ["esES"] = "Muestra/oculta el valor de poder de ataque a distancia",
        ["esMX"] = "Muestra/oculta el valor de poder de ataque a distancia",
        ["ptBR"] = "Mostra/oculta o valor de poder de ataque de longo alcance"
    },
    ["Ranged Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampf Kritisch",
        ["frFR"] = "Critique à distance",
        ["zhCN"] = "远程暴击",
        ["ruRU"] = "Крит",
        ["esES"] = "Probabilidad de golpe crítico",
        ["esMX"] = "Crítico a distancia",
        ["ptBR"] = "Crítico de longo alcance"
    },
    ["Shows/Hides the ranged crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance im Fernkampf kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances de coup critique à distance.",
        ["zhCN"] = "显示/隐藏 远程暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона",
        ["esES"] = "Muestra/oculta la probabilidad de conseguir un golpe crítico a distancia",
        ["esMX"] = "Muestra/oculta la probabilidad de conseguir un golpe crítico a distancia",
        ["ptBR"] = "Mostra/oculta a chance de realizar acertos críticos de longo alcance"
    },
    ["Shows/Hides the ranged haste rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Fernkampftempowertung.",
        ["frFR"] = "Affiche/cache le score de hâte à distance.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга скорости дальнего боя",
        ["esES"] = "Muestra/oculta el índice de celeridad a distancia",
        ["esMX"] = "Muestra/oculta el índice de celeridad a distancia",
        ["ptBR"] = "Mostra/oculta a taxa de aceleração de longo alcance"
    },
    ["Shows/Hides the ranged haste bonus value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Fernkampftempobonus.",
        ["frFR"] = "Affiche/cache le bonus de hâte à distance.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение бонуса к скорости дальнего боя",
        ["esES"] = "Muestra/oculta el bonus de celeridad a distancia",
        ["esMX"] = "Muestra/oculta el bonus de celeridad a distancia",
        ["ptBR"] = "Mostra/oculta o bônus de aceleração de longo alcance"
    },
    ["Shows/Hides the ranged attack speed."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Fernkampf Angriffstempo.",
        ["frFR"] = "Affiche/cache la vitesse d'attaque à distance.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение скорости атаки",
        ["esES"] = "Muestra/oculta la velocidad de ataque a distancia",
        ["esMX"] = "Muestra/oculta la velocidad de ataque a distancia",
        ["ptBR"] = "Mostra/oculta a velocidade de ataque de longo alcance"
    },
    ["Ranged Hit"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampf Trefferwertung",
        ["frFR"] = "Toucher à distance",
        ["zhCN"] = "远程命中",
        ["ruRU"] = "Меткость",
        ["esES"] = "Probabilidad de golpear",
        ["esMX"] = "Probabilidad de golpear",
        ["ptBR"] = "Chance de acerto"
    },
    ["Ranged Hit Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampf Trefferwertung",
        ["frFR"] = "Valeurs de toucher à distance",
        ["zhCN"] = "远程命中率",
        ["ruRU"] = "Показатели меткости",
        ["esES"] = "Valor de probabilidad de golpear",
        ["esMX"] = "Valor de probabilidad de golpear",
        ["ptBR"] = "Valor de chance de acerto"
    },
    ["Shows/Hides all ranged hit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Trefferwertungen im Fernkampf.",
        ["frFR"] = "Affiche/cache les chances de toucher à distance.",
        ["zhCN"] = "显示/隐藏 所有远程命中",
        ["ruRU"] = "Показать/скрыть все показатели меткости",
        ["esES"] = "Muestra/oculta la probabilidad de golpear",
        ["esMX"] = "Muestra/oculta la probabilidad de golpear",
        ["ptBR"] = "Mostra/oculta a chance de acerto"
    },
    ["Shows/Hides the ranged hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Fernkampf Trefferwertung.",
        ["frFR"] = "Affiche/cache le score de toucher à distance.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга меткости",
        ["esES"] = "Muestra/oculta el índice de golpear",
        ["esMX"] = "Muestra/oculta el índice de golpear",
        ["ptBR"] = "Mostra/oculta a taxa de acerto"
    },
    ["Shows/Hides the ranged hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Fernkampf Trefferwertung.",
        ["frFR"] = "Affiche/cache le bonus de toucher à distance.",
        ["zhCN"] = "显示/隐藏 远程命中率",
        ["ruRU"] = "Показать/скрыть значение бонуса к меткости",
        ["esES"] = "Muestra/oculta el bonus de golpear",
        ["esMX"] = "Muestra/oculta el bonus de golpear",
        ["ptBR"] = "Mostra/oculta o bônus de acerto"
    },
    ["Shows/Hides the ranged miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels im Fernkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater à distance contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的远程未命中率",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим атакам цели вашего уровня",
        ["esES"] = "Muestra/oculta la probabilidad de fallo contra enemigos del mismo nivel",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo contra enemigos del mismo nivel",
        ["ptBR"] = "Mostra/oculta a chance de erro contra inimigos do mesmo nível"
    },
    ["Shows/Hides the ranged miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen im Fernkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater à distance contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的远程未命中率 (+3 等级)。",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим атакам цели на 3 уровня выше вашего",
        ["esES"] = "Muestra/oculta la probabilidad de fallo contra jefes (nivel +3)",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo contra jefes (nivel +3)",
        ["ptBR"] = "Mostra/oculta a chance de erro contra chefes (nível +3)"
    },
}

for k, v in pairs(rangedConfigTranslations) do
    i18n.translations[k] = v
end
