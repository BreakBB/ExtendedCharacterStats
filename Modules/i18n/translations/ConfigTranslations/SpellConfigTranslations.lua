---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local spellConfigTranslations = {
    ["Show Spell Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberwerte anzeigen",
        ["frFR"] = "Afficher sorts",
        ["zhCN"] = "显示法术属性",
        ["ruRU"] = "Заклинания",
        ["esES"] = "Mostrar hechizos",
        ["esMX"] = "Mostrar hechizos",
        ["ptBR"] = "Mostrar feitiços"
    },
    ["Shows/Hides all spell stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Zauberwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques des sorts.",
        ["zhCN"] = "显示/隐藏 法术属性",
        ["ruRU"] = "Показать/скрыть все характеристики заклинаний",
        ["esES"] = "Muestra/oculta todas estadísticas de hechizos",
        ["esMX"] = "Muestra/oculta todas estadísticas de hechizos",
        ["ptBR"] = "Mostra/oculta todas as estatísticas de feitiços"
    },
    ["Spell Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Kritisch",
        ["frFR"] = "Critique des sorts",
        ["zhCN"] = "法术暴击",
        ["ruRU"] = "Крит",
        ["esES"] = "Crítico con hechizos",
        ["esMX"] = "Crítico con hechizos",
        ["ptBR"] = "Crítico com feitiços",
    },
    ["Shows/Hides the spell crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit einem Zauber kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances d'infliger un coup critique avec les sorts.",
        ["zhCN"] = "显示/隐藏 法术暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos",
        ["ptBR"] = "Mostra/oculta a chance de realizar acertos críticos com feitiços"
    },
    ["Spell Penetration"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberdurchschlagskraft",
        ["frFR"] = "Pénétration des sorts",
        ["zhCN"] = false,
        ["ruRU"] = "Проник. способ.",
        ["esES"] = "Penetración de hechizos",
        ["esMX"] = "Penetración de hechizos",
        ["ptBR"] = "Penetração de feitiço"
    },
    ["Shows/Hides the spell penetration value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauberdurchschlagskraft.",
        ["frFR"] = "Affiche/cache la valeur de pénétration des sorts.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение проникающей способности заклинаний",
        ["esES"] = "Muestra/oculta el valor de penetración de hechizos",
        ["esMX"] = "Muestra/oculta el valor de penetración de hechizos",
        ["ptBR"] = "Mostra/oculta o valor de penetração de feitiço"
    },
    ["Shows/Hides the spell haste rating value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zaubertempowertung.",
        ["frFR"] = "Affiche/cache le score de hâte des sorts.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга скорости заклинаний",
        ["esES"] = "Muestra/oculta el índice de celeridad con hechizos",
        ["esMX"] = "Muestra/oculta el índice de celeridad con hechizos",
        ["ptBR"] = "Mostra/oculta a taxa de aceleração de feitiço"
    },
    ["Shows/Hides the spell haste bonus value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Zaubertempobonus.",
        ["frFR"] = "Affiche/cache le bonus de hâte des sorts.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение бонуса к скорости заклинаний",
        ["esES"] = "Muestra/oculta el bonus de celeridad con hechizos",
        ["esMX"] = "Muestra/oculta el bonus de celeridad con hechizos",
        ["ptBR"] = "Mostra/oculta o bônus de de aceleração de feitiço"
    },
    ["Spell Hit Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Trefferwertung",
        ["frFR"] = "Toucher des sorts",
        ["zhCN"] = "法术命中率",
        ["ruRU"] = "Показатели меткости",
        ["esES"] = "Golpear con hechizos",
        ["esMX"] = "Golpear con hechizos",
        ["ptBR"] = "Acerto com feitiço"
    },
    ["Shows/Hides the spell hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauber Trefferwertung.",
        ["frFR"] = "Affiche/cache la valeur d'indice de toucher des sorts.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга меткости",
        ["esES"] = "Muestra/oculta el índice de golpear con hechizos",
        ["esMX"] = "Muestra/oculta el índice de golpear con hechizos",
        ["ptBR"] = "Mostra/oculta a taxa de acerto com feitiços"
    },
    ["Shows/Hides the spell hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Zauber Trefferwertung.",
        ["frFR"] = "Affiche/cache le bonus de toucher des sorts.",
        ["zhCN"] = "显示/隐藏 法术命中几率",
        ["ruRU"] = "Показать/скрыть значение бонуса к меткости",
        ["esES"] = "Muestra/oculta el bonus de golpear con hechizos",
        ["esMX"] = "Muestra/oculta el bonus de golpear con hechizos",
        ["ptBR"] = "Mostra/oculta o bônus de acerto com feitiços"
    },
    ["Shows/Hides the spell miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的法术未命中率",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим заклинаниям цели вашего уровня",
        ["esES"] = "Muestra/oculta la probabilidad de fallo con hechizos contra enemigos del mismo nivel",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo con hechizos contra enemigos del mismo nivel",
        ["ptBR"] = "Mostra/oculta a chance de erro de feitiço contra inimigos do mesmo nível"
    },
    ["Shows/Hides the spell miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的法术未命中率 (+3 等级)。",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим заклинаниям цели на 3 уровня выше вашего",
        ["esES"] = "Muestra/oculta la probabilidad de fallo con hechizos contra jefes (nivel +3)",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo con hechizos contra jefes (nivel +3)",
        ["ptBR"] = "Mostra/oculta a chance de erro de feitiço contra inimigos chefes (nível +3)"
    },
    ["Spell Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberkraft",
        ["frFR"] = "Puissance des sorts",
        ["zhCN"] = "法术强度",
        ["ruRU"] = "Сила заклинаний",
        ["esES"] = "Poder con hechizos",
        ["esMX"] = "Poder con hechizos",
        ["ptBR"] = "Poder mágico"
    },
    ["Shows/Hides the physical damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den physischen Schadenswert.",
        ["frFR"] = "Affiche/cache les dégats physiques.",
        ["zhCN"] = "显示/隐藏 物理伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного физического урона",
        ["esES"] = "Muestra/oculta el valor de daño físico",
        ["esMX"] = "Muestra/oculta el valor de daño físico",
        ["ptBR"] = "Mostra/oculta o valor do dano físico"
    },
    ["Shows/Hides the holy damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heiligschadenswert.",
        ["frFR"] = "Affiche/cache les dégats du sacré.",
        ["zhCN"] = "显示/隐藏 神圣伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями света",
        ["esES"] = "Muestra/oculta el valor de daño sagrado",
        ["esMX"] = "Muestra/oculta el valor de daño sagrado",
        ["ptBR"] = "Mostra/oculta o valor de dano sagrado"
    },
    ["Shows/Hides the arcane damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Arkanschadenswert.",
        ["frFR"] = "Affiche/cache les dégats des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями тайной магии",
        ["esES"] = "Muestra/oculta el valor de daño arcano",
        ["esMX"] = "Muestra/oculta el valor de daño arcano",
        ["ptBR"] = "Mostra/oculta o valor de dano arcano"
    },
    ["Shows/Hides the nature damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Naturschadenswert.",
        ["frFR"] = "Affiche/cache les dégats de la nature.",
        ["zhCN"] = "显示/隐藏 自然伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями природы",
        ["esES"] = "Muestra/oculta el valor de daño de la naturaleza",
        ["esMX"] = "Muestra/oculta el valor de daño de la naturaleza",
        ["ptBR"] = "Mostra/oculta o valor de dano de natureza"
    },
    ["Shows/Hides the frost damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Frostschadenswert.",
        ["frFR"] = "Affiche/cache les dégats du givre.",
        ["zhCN"] = "显示/隐藏 冰霜伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями льда",
        ["esES"] = "Muestra/oculta el valor de daño de escarcha",
        ["esMX"] = "Muestra/oculta el valor de daño de escarcha",
        ["ptBR"] = "Mostra/oculta o valor de dano de gelo"
    },
    ["Shows/Hides the fire damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Feuerschadenswert.",
        ["frFR"] = "Affiche/cache les dégats du feu.",
        ["zhCN"] = "显示/隐藏 火焰伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями огня",
        ["esES"] = "Muestra/oculta el valor de daño de fuego",
        ["esMX"] = "Muestra/oculta el valor de daño de fuego",
        ["ptBR"] = "Mostra/oculta o valor de dano de fogo"
    },
    ["Shows/Hides the shadow damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Schattenschadenswert.",
        ["frFR"] = "Affiche/cache les dégats des ombres.",
        ["zhCN"] = "显示/隐藏 暗影伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями тьмы",
        ["esES"] = "Muestra/oculta el valor de daño de las sombras",
        ["esMX"] = "Muestra/oculta el valor de daño de las sombras",
        ["ptBR"] = "Mostra/oculta o valor de dano de sombra"
    },
    ["Shows/Hides the healing power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heilungsmachtwert.",
        ["frFR"] = "Affiche/cache la valeur du pouvoir de guérison.",
        ["zhCN"] = "显示/隐藏 法术治疗",
        ["ruRU"] = "Показать/скрыть значение дополнительного исцеления",
        ["esES"] = "Muestra/oculta el valor de poder de curación",
        ["esMX"] = "Muestra/oculta el valor de poder de sanación",
        ["ptBR"] = "Mostra/oculta o valor de poder de cura"
    },
}

for k, v in pairs(spellConfigTranslations) do
    i18n.translations[k] = v
end
