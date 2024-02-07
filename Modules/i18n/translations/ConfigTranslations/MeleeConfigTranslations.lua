---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local meleeConfigTranslations = {
    ["Show Melee Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampfwerte anzeigen",
        ["frFR"] = "Mêlée Général",
        ["zhCN"] = "显示近战属性",
        ["ruRU"] = "Ближний бой",
        ["esES"] = "Mostrar cuerpo a cuerpo",
        ["esMX"] = "Mostrar cuerpo a cuerpo"
    },
    ["Shows/Hides all melee stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Nahkampfwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de mêlée.",
        ["zhCN"] = "显示/隐藏 所有近战属性",
        ["ruRU"] = "Показать/скрыть все характеристики ближнего боя",
        ["esES"] = "Muestra/oculta todas estadísticas cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta todas estadísticas cuerpo a cuerpo"
    },
    ["Melee Attack Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Angriffskraft",
        ["frFR"] = "Puissance d'attaque en mêlée",
        ["zhCN"] = "近战攻击强度",
        ["ruRU"] = "Сила атаки",
        ["esES"] = "Poder de ataque",
        ["esMX"] = "Poder de ataque"
    },
    ["Shows/Hides the melee attack power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Nahkampf Angriffskraftwert.",
        ["frFR"] = "Affiche/cache la puissance d'attaque en mêlée.",
        ["zhCN"] = "显示/隐藏 近战攻击强度",
        ["ruRU"] = "Показать/скрыть значение силы атаки",
        ["esES"] = "Muestra/oculta el valor de poder de ataque cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta el valor de poder de ataque cuerpo a cuerpo"
    },
    ["Melee Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Kritisch",
        ["frFR"] = "Critique en mêlée",
        ["zhCN"] = "近战暴击",
        ["ruRU"] = "Крит",
        ["esES"] = "Probabilidad de golpe crítico",
        ["esMX"] = "Probabilidad de golpe crítico"
    },
    ["Shows/Hides the melee crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance im Nahkampf kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances d'infliger un coup critique en mêlée.",
        ["zhCN"] = "显示/隐藏 近战暴击几率",
        ["ruRU"] = "Показать/скрыть шанс критического урона",
        ["esES"] = "Muestra/oculta la probabilidad de conseguir un golpe crítico cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta la probabilidad de conseguir un golpe crítico cuerpo a cuerpo"
    },
    ["Shows/Hides the armor penetration value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Rüstungsdurchschlagskraft.",
        ["frFR"] = "Affiche/cache la valeur de pénétration d'armure.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение проникающую способность брони",
        ["esES"] = "Muestra/oculta el valor de penetración de armadura",
        ["esMX"] = "Muestra/oculta el valor de penetración de armadura"
    },
    ["Shows/Hides the armor penetration rating value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Rüstungsdurchschlagwertung.",
        ["frFR"] = "Affiche/cache la valeur de notation de pénétration d'armure.",
        ["zhCN"] = false,
        ["ruRU"] = false,
        ["esES"] = "Muestra/oculta el índice de penetración de armadura",
        ["esMX"] = "Muestra/oculta el índice de penetración de armadura"
    },
    ["Shows/Hides the expertise value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Waffenkunde.",
        ["frFR"] = "Affiche/cache la valeur d'expertise.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение мастерства",
        ["esES"] = "Muestra/oculta el valor de pericia",
        ["esMX"] = "Muestra/oculta el valor de pericia"
    },
    ["Shows/Hides the expertise rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Waffenkundewertung.",
        ["frFR"] = "Affiche/cache le score d'expertise",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга мастерства",
        ["esES"] = "Muestra/oculta el índice de pericia",
        ["esMX"] = "Muestra/oculta el índice de pericia"
    },
    ["Shows/Hides the melee haste rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Nahkampftempowertung.",
        ["frFR"] = "Affiche/cache le score d'hâte en mêlée.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга скорости ближнего боя",
        ["esES"] = "Muestra/oculta el índice de celeridad cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta el índice de celeridad cuerpo a cuerpo"
    },
    ["Shows/Hides the melee haste bonus value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Nahkampftempobonus.",
        ["frFR"] = "Affiche/cache la valeur de bonus d'hâte en mêlée.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение бонуса к скорости ближнего боя",
        ["esES"] = "Muestra/oculta el bonus de celeridad cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta el bonus de celeridad cuerpo a cuerpo"
    },
    ["Shows/Hides the melee attack speed."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo im Nahkampf.",
        ["frFR"] = "Affiche/cache la vitesse d'attaque en mêlée.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значения скорости атаки",
        ["esES"] = "Muestra/oculta la velocidad de ataque cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta la velocidad de ataque cuerpo a cuerpo"
    },
    ["Shows/Hides the attack speed of the main hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Waffenhand.",
        ["frFR"] = "Affiche/cache la vitesse d'attaque de la main droite.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение скорости атаки оружия в правой руке",
        ["esES"] = "Muestra/oculta la velocidad de ataque de la mano derecha",
        ["esMX"] = "Muestra/oculta la velocidad de ataque de la mano derecha"
    },
    ["Shows/Hides the attack speed of the off hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Schildhand.",
        ["frFR"] = "Affiche/cache la vitesse d'attaque de la main gauche.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение скорости атаки оружия в левой руке",
        ["esES"] = "Muestra/oculta la velocidad de ataque de la mano izquierda",
        ["esMX"] = "Muestra/oculta la velocidad de ataque de la mano izquierda"
    },
    ["Melee Hit"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Trefferwertung",
        ["frFR"] = "Toucher en mêlée",
        ["zhCN"] = "近战命中",
        ["ruRU"] = "Меткость",
        ["esES"] = "Probabilidad de golpear",
        ["esMX"] = "Probabilidad de golpear"
    },
    ["Melee Hit Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Trefferwertung",
        ["frFR"] = "Valeurs de toucher en mêlée",
        ["zhCN"] = "近战命中率",
        ["ruRU"] = "Показатели меткости",
        ["esES"] = "Valor de probabilidad de golpear",
        ["esMX"] = "Valor de probabilidad de golpear"
    },
    ["Shows/Hides all melee hit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Trefferwertungen im Nahkampf.",
        ["frFR"] = "Affiche/cache les chances de toucher.",
        ["zhCN"] = "显示/隐藏 所有近战命中率",
        ["ruRU"] = "Показать/скрыть все показатели меткости",
        ["esES"] = "Muestra/oculta la probabilidad de golpear",
        ["esMX"] = "Muestra/oculta la probabilidad de golpear"
    },
    ["Hit Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferwertung",
        ["frFR"] = "Score de toucher",
        ["zhCN"] = false,
        ["ruRU"] = "Меткость",
        ["esES"] = "Índice de golpear",
        ["esMX"] = "Índice de golpear"
    },
    ["Shows/Hides the melee hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Nahkampf Trefferwertung.",
        ["frFR"] = "Affiche/cache le score de toucher.",
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга меткости",
        ["esES"] = "Muestra/oculta el índice de golpear",
        ["esMX"] = "Muestra/oculta el índice de golpear"
    },
    ["Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferwertungsbonus",
        ["frFR"] = "Bonus de toucher",
        ["zhCN"] = "命中几率",
        ["ruRU"] = "Бонус",
        ["esES"] = "Bonus de golpear",
        ["esMX"] = "Bonus de golpear"
    },
    ["Shows/Hides the melee hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Nahkampf Trefferwertung.",
        ["frFR"] = "Affiche/cache le bonus de toucher.",
        ["zhCN"] = "显示/隐藏 近战命中率",
        ["ruRU"] = "Показать/скрыть значение бонуса к меткости",
        ["esES"] = "Muestra/oculta el bonus de golpear",
        ["esMX"] = "Muestra/oculta el bonus de golpear"
    },
    ["Miss Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Chance zu verfehlen",
        ["frFR"] = "Chances de rater",
        ["zhCN"] = "未命中几率",
        ["ruRU"] = "Сопротивление",
        ["esES"] = "Probabilidad de fallo",
        ["esMX"] = "Probabilidad de fallo"
    },
    ["Shows/Hides the melee miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels im Nahkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater en mêlée contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的近战未命中率",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим атакам цели вашего уровня",
        ["esES"] = "Muestra/oculta la probabilidad de fallo contra enemigos del mismo nivel",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo contra enemigos del mismo nivel"
    },
    ["Miss Chance Boss"] = {
        ["enUS"] = true,
        ["deDE"] = "Chance zu verfehlen (Boss)",
        ["frFR"] = "Chances de rater-Boss",
        ["zhCN"] = "未命中 Boss",
        ["ruRU"] = "Сопрот. (+3 ур.)",
        ["esES"] = "Probabilidad de fallo (jefe)",
        ["esMX"] = "Probabilidad de fallo (jefe)"
    },
    ["Shows/Hides the melee miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen im Nahkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater en mêlée contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的近战未命中率 (+3 等级)。",
        ["ruRU"] = "Показать/скрыть значение шанса сопротивления вашим атакам цели на 3 уровня выше вашего",
        ["esES"] = "Muestra/oculta la probabilidad de fallo contra jefes (nivel +3)",
        ["esMX"] = "Muestra/oculta la probabilidad de fallo contra jefes (nivel +3)"
    },
}

for k, v in pairs(meleeConfigTranslations) do
    i18n.translations[k] = v
end
