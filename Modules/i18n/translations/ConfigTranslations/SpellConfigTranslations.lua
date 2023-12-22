---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local spellConfigTranslations = {
    ["Show Spell Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberwerte anzeigen",
        ["frFR"] = "Sorts Général",
        ["zhCN"] = "显示法术属性",
        ["ruRU"] = "Заклинания",
        ["esES"] = "Mostrar estadísticas de hechizos",
        ["esMX"] = "Mostrar estadísticas de hechizos"
    },
    ["Shows/Hides all spell stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Zauberwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques des sorts.",
        ["zhCN"] = "显示/隐藏 法术属性",
        ["ruRU"] = "Показать/скрыть все характеристики заклинаний",
        ["esES"] = "Muestra/oculta todas estadísticas de hechizos",
        ["esMX"] = "Muestra/oculta todas estadísticas de hechizos"
    },
    ["Spell Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Kritisch",
        ["frFR"] = "Critique des sorts",
        ["zhCN"] = "法术暴击",
        ["ruRU"] = "Крит",
        ["esES"] = "Crítico con hechizos",
        ["esMX"] = "Crítico con hechizos"
    },
    ["Shows/Hides the spell crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit einem Zauber kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances d'infliger un coup critique avec les sorts.",
        ["zhCN"] = "显示/隐藏 法术暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos"
    },
    ["Spell Penetration"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberdurchschlagskraft",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Проник. способ.",
        ["esES"] = "Penetración con hechizos",
        ["esMX"] = "Penetración con hechizos"
    },
    ["Shows/Hides the spell penetration value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauberdurchschlagskraft.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение проникающей способности заклинаний",
        ["esES"] = "Muestra/oculta el valor de penetración con hechizos",
        ["esMX"] = "Muestra/oculta el valor de penetración con hechizos"
    },
    ["Shows/Hides the spell haste rating value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zaubertempowertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга скорости заклинаний",
        ["esES"] = "Muestra/oculta el índice de celeridad con hechizos",
        ["esMX"] = "Muestra/oculta el índice de celeridad con hechizos"
    },
    ["Shows/Hides the spell haste bonus value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Zaubertempobonus.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение бонуса к скорости заклинаний",
        ["esES"] = "Muestra/oculta el bonus de celeridad con hechizos",
        ["esMX"] = "Muestra/oculta el bonus de celeridad con hechizos"
    },
    ["Spell Hit Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Trefferwertung",
        ["frFR"] = "Toucher des sorts",
        ["zhCN"] = "法术命中率",
        ["ruRU"] = "Показатели меткости",
        ["esES"] = "Valor de golpear con hechizos",
        ["esMX"] = "Valor de golpear con hechizos"
    },
    ["Shows/Hides all spell hit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Trefferwertungen für Zauber.",
        ["frFR"] = "Affiche/cache les chances de toucher avec les sorts.",
        ["zhCN"] = "显示/隐藏 法术命中",
        ["ruRU"] = "Показать/скрыть все показатели меткости",
        ["esES"] = "Muestra/oculta la probabilidad de golpear con hechizos",
        ["esMX"] = "Muestra/oculta la probabilidad de golpear con hechizos"
    },
    ["Spell Hit"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Trefferwertung",
        ["frFR"] = "Valeurs de toucher sorts",
        ["zhCN"] = "法术命中",
        ["ruRU"] = "Меткость",
        ["esES"] = "Probabilidad de golpear con hechizos",
        ["esMX"] = "Probabilidad de golpear con hechizos"
    },
    ["Shows/Hides the spell hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauber Trefferwertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга меткости",
        ["esES"] = "Muestra/oculta el índice de golpear con hechizos",
        ["esMX"] = "Muestra/oculta el índice de golpear con hechizos"
    },
    ["Shows/Hides the spell hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Zauber Trefferwertung.",
        ["frFR"] = "Affiche/cache le bonus de toucher des sorts.",
        ["zhCN"] = "显示/隐藏 法术命中几率",
        ["ruRU"] = "Показать/скрыть значение бонуса к меткости",
        ["esES"] = "Muestra/oculta el bonus de golpear con hechizos",
        ["esMX"] = "Muestra/oculta el bonus de golpear con hechizos"
    },
    ["Shows/Hides the spell miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的法术未命中率",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим заклинаниям цели вашего уровня",
        ["esES"] = "Muestra/oculta la probabilidad de fallo con hechizos contra enemigos del mismo nivel",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo con hechizos contra enemigos del mismo nivel"
    },
    ["Shows/Hides the spell miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的法术未命中率 (+3 等级)。",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим заклинаниям цели на 3 уровня выше вашего",
        ["esES"] = "Muestra/oculta la probabilidad de fallo con hechizos contra jefes (nivel +3)",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo con hechizos contra jefes (nivel +3)"
    },
    ["Show Spell Power Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zaubermachtwerte anzeigen",
        ["frFR"] = "Afficher la puissance des sorts",
        ["zhCN"] = "显示法术强度属性",
        ["ruRU"] = "Сила заклинаний",
        ["esES"] = "Mostrar estadísticas de poder con hechizos",
        ["esMX"] = "Mostrar estadísticas de poder con hechizos",
    },
    ["Shows/Hides all spell power stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Zaubermachtwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de puissance des sorts.",
        ["zhCN"] = "显示/隐藏 法术强度属性",
        ["ruRU"] = "Показать/скрыть все характеристики силы заклинаний",
        ["esES"] = "Muestra/oculta todas estadísticas de poder con hechizos",
        ["esMX"] = "Muestra/oculta todas estadísticas de poder con hechizos",
    },
    ["Shows/Hides the physical damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den physischen Schadenswert.",
        ["frFR"] = "Affiche/Cache les dégats physiques.",
        ["zhCN"] = "显示/隐藏 物理伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного физического урона",
        ["esES"] = "Muestra/oculta el valor de daño físico",
        ["esMX"] = "Muestra/oculta el valor de daño físico"
    },
    ["Shows/Hides the physical crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit physischen Zaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique physique.",
        ["zhCN"] = "显示/隐藏 物理暴击",
        ["ruRU"] = "Показать/скрыть шанс критического физического урона",
        ["esES"] = "Muestra/oculta la probabilidad de conseguir un golpe crítico físico",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico físico",
    },
    ["Shows/Hides the holy damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heiligschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du sacré.",
        ["zhCN"] = "显示/隐藏 神圣伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями света",
        ["esES"] = "Muestra/oculta el valor de daño sagrado",
        ["esMX"] = "Muestra/oculta el valor de daño sagrado",
    },
    ["Shows/Hides the holy crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Heiligzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du sacré.",
        ["zhCN"] = "显示/隐藏 神圣暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями света",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos sagrados",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos sagrados",
    },
    ["Shows/Hides the arcane damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Arkanschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями тайной магии",
        ["esES"] = "Muestra/oculta el valor de daño arcano",
        ["esMX"] = "Muestra/oculta el valor de daño arcano",
    },
    ["Shows/Hides the arcane crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Arkanzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями тайной магии",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos arcanos",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos arcanos",
    },
    ["Shows/Hides the nature damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Naturschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats de la nature.",
        ["zhCN"] = "显示/隐藏 自然伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями природы",
        ["esES"] = "Muestra/oculta el valor de daño de la naturaleza",
        ["esMX"] = "Muestra/oculta el valor de daño de la naturaleza",
    },
    ["Shows/Hides the nature crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Naturzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique de la nature.",
        ["zhCN"] = "显示/隐藏 自然暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями природы",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de la naturaleza",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de la naturaleza"
    },
    ["Shows/Hides the frost damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Frostschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du givre.",
        ["zhCN"] = "显示/隐藏 冰霜伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями льда",
        ["esES"] = "Muestra/oculta el valor de daño de escarcha",
        ["esMX"] = "Muestra/oculta el valor de daño de escarcha",
    },
    ["Shows/Hides the frost crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Frostzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du givre.",
        ["zhCN"] = "显示/隐藏 冰霜暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями льда",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de escarcha",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de escarcha"
    },
    ["Shows/Hides the fire damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Feuerschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du feu.",
        ["zhCN"] = "显示/隐藏 火焰伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями огня",
        ["esES"] = "Muestra/oculta el valor de daño de fuego",
        ["esMX"] = "Muestra/oculta el valor de daño de fuego",
    },
    ["Shows/Hides the fire crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Feuerzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du feu.",
        ["zhCN"] = "显示/隐藏 火焰暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями огня",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de fuego",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de fuego"
    },
    ["Shows/Hides the shadow damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Schattenschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats des ombres.",
        ["zhCN"] = "显示/隐藏 暗影伤害",
        ["ruRU"] = "Показать/скрыть значение дополнительного урона заклинаниями тьмы",
        ["esES"] = "Muestra/oculta el valor de daño de sombras",
        ["esMX"] = "Muestra/oculta el valor de daño de sombras",
    },
    ["Shows/Hides the shadow crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Schattenzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique des ombres.",
        ["zhCN"] = "显示/隐藏 暗影暴击",
        ["ruRU"] = "Показать/скрыть шанс критического урона заклинаниями тьмы",
        ["esES"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de sombras",
        ["esMX"] = "Muestra/oculta la probabilidad de asestar un golpe crítico con hechizos de sombras"
    },

    ["Shows/Hides the healing power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heilungsmachtwert.",
        ["frFR"] = "Affiche/Cache la puissance des soins.",
        ["zhCN"] = "显示/隐藏 法术治疗",
        ["ruRU"] = "Показать/скрыть значение дополнительного исцеления",
        ["esES"] = "Muestra/oculta el valor poder de sanación",
        ["esMX"] = "Muestra/oculta el valor poder de sanación",
    },
}

for k, v in pairs(spellConfigTranslations) do
    i18n.translations[k] = v
end
