---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local manaConfigTranslations = {
    ["Show Mana Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Manawerte anzeigen",
        ["frFR"] = "Afficher mana",
        ["zhCN"] = "显示法力回复",
        ["ruRU"] = "Мана",
        ["esES"] = "Mostrar maná",
        ["esMX"] = "Mostrar maná",
        ["ptBR"] = "Mostrar mana"
    },
    ["Shows/Hides all mana stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Manawerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de mana.",
        ["zhCN"] = "显示/隐藏 所有法力回复",
        ["ruRU"] = "Показать/скрыть все характеристики маны",
        ["esES"] = "Muestra/oculta todas estadísticas de maná",
        ["esMX"] = "Muestra/oculta todas estadísticas de maná",
        ["ptBR"] = "Mostra/oculta todas as estatísticas de mana"
    },
    ["MP5 Items"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 Gegenstände",
        ["frFR"] = "MP5 (Objets)",
        ["zhCN"] = "装备回蓝",
        ["ruRU"] = "MP5 (экипировка)",
        ["esES"] = "MP5 (Objetos)",
        ["esMX"] = "MP5 (Objetos)",
        ["ptBR"] = "MP5 (Itens)"
    },
    ["Shows/Hides the MP5 value from items."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert von Gegenständen.",
        ["frFR"] = "Affiche/cache la valeur MP5 des objets.",
        ["zhCN"] = "显示/隐藏 装备回蓝",
        ["ruRU"] = "Показать/скрыть значение MP5 (восполнение маны каждые 5 сек вне боя) от экипировки",
        ["esES"] = "Muestra/oculta el valor de MP5 de objetos",
        ["esMX"] = "Muestra/oculta el valor de MP5 de objetos",
        ["ptBR"] = "Mostra/oculta o valor de MP5 de itens"
    },
    ["MP5 Buffs"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 Stärkungszauber",
        ["frFR"] = "MP5 (Amélioration)",
        ["zhCN"] = "增益回蓝",
        ["ruRU"] = "MP5 (баффы)",
        ["esES"] = "MP5 (Beneficios)",
        ["esMX"] = "MP5 (Beneficios)",
        ["ptBR"] = "MP5 (Bônus)"
    },
    ["Shows/Hides the MP5 value from buffs."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert Stärkungszauber.",
        ["frFR"] = "Affiche/cache la valeur MP5 de Amélioration.",
        ["zhCN"] = "显示/隐藏 增益回蓝",
        ["ruRU"] = "Показать/скрыть значение MP5 (восполнение маны каждые 5 сек вне боя) от баффов",
        ["esES"] = "Muestra/oculta el valor de MP5 de beneficios",
        ["esMX"] = "Muestra/oculta el valor de MP5 de beneficios",
        ["ptBR"] = "Mostra/oculta o valor de MP5 de bônus"
    },
    ["MP5 Spirit"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 Willenskraft",
        ["frFR"] = "MP5 Esprit",
        ["zhCN"] = "精神回蓝",
        ["ruRU"] = "MP5 (дух)",
        ["esES"] = "MP5 (Espíritu)",
        ["esMX"] = "MP5 (Espíritu)",
        ["ptBR"] = "MP5 (Espírito)",
    },
    ["Shows/Hides the MP5 value from spirit."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert durch Willenskraft.",
        ["frFR"] = "Affiche/cache la valeur MP5 de l'esprit.",
        ["zhCN"] = "显示/隐藏 精神回蓝",
        ["ruRU"] = "Показать/скрыть значение MP5 (восполнение маны каждые 5 сек вне боя) от духа",
        ["esES"] = "Muestra/oculta el valor de MP5 de espíritu",
        ["esMX"] = "Muestra/oculta el valor de MP5 de espíritu",
        ["ptBR"] = "Mostra/oculta o valor de MP5 de espírito",
    },
    ["MP5 Casting"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 Zaubernd",
        ["frFR"] = "MP5 (Incantation)",
        ["zhCN"] = "附魔回蓝",
        ["ruRU"] = "MP5 (каст)",
        ["esES"] = "MP5 (Lanzar)",
        ["esMX"] = "MP5 (Lanzar)",
        ["ptBR"] = "MP5 (Lançar)"
    },
    ["Shows/Hides the MP5 while casting value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert während des Zauberwirkens.",
        ["frFR"] = "Affiche/cache la valeur MP5 pendant l'incantation.",
        ["zhCN"] = "显示/隐藏 附魔回蓝",
        ["ruRU"] = "Показать/скрыть значение MP5 (восполнение маны каждые 5 сек вне боя) во время произношения заклинаний",
        ["esES"] = "Muestra/oculta el valor de MP5 mientras lanzas",
        ["esMX"] = "Muestra/oculta el valor de MP5 mientras lanzas",
        ["ptBR"] = "Mostra/oculta o valor de MP5 durante o lançamento"
    },
    ["Shows/Hides the MP5 value when outside of the 5 second rule."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den MP5-Wert der die Mana-Regeneration außerhalb der 5-Sekunden-Regel angibt.",
        ["frFR"] = "Affiche/cache la valeur MP5 lorsque hors de la règle des 5 secondes.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение MP5 (восполнение маны каждые 5 сек вне боя) не во время произношения заклинаний",
        ["esES"] = "Muestra/oculta el valor de MP5 cuando estás fuera de la regla de los 5 segundos",
        ["esMX"] = "Muestra/oculta el valor de MP5 cuando estás fuera de la regla de los 5 segundos",
        ["ptBR"] = "Mostra/oculta o valor de MP5 quando fora da regra dos 5 segundos"
    },
}

for k, v in pairs(manaConfigTranslations) do
    i18n.translations[k] = v
end
