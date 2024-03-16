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
        ["frFR"] = "Affiche/Cache la puissance d'attaque en mêlée.",
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
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение проникающую способность брони",
        ["esES"] = "Muestra/oculta el valor de penetración de armadura",
        ["esMX"] = "Muestra/oculta el valor de penetración de armadura"
    },
    ["Shows/Hides the armor penetration rating value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Rüstungsdurchschlagwertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = false,
        ["esES"] = "Muestra/oculta el índice de penetración de armadura",
        ["esMX"] = "Muestra/oculta el índice de penetración de armadura"
    },
    ["Shows/Hides the expertise value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Waffenkunde.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение мастерства",
        ["esES"] = "Muestra/oculta el valor de pericia",
        ["esMX"] = "Muestra/oculta el valor de pericia"
    },
    ["Shows/Hides the expertise rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Waffenkundewertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга мастерства",
        ["esES"] = "Muestra/oculta el índice de pericia",
        ["esMX"] = "Muestra/oculta el índice de pericia"
    },
    ["Shows/Hides the melee haste rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Nahkampftempowertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение рейтинга скорости ближнего боя",
        ["esES"] = "Muestra/oculta el índice de celeridad cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta el índice de celeridad cuerpo a cuerpo"
    },
    ["Shows/Hides the melee haste bonus value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Nahkampftempobonus.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение бонуса к скорости ближнего боя",
        ["esES"] = "Muestra/oculta el bonus de celeridad cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta el bonus de celeridad cuerpo a cuerpo"
    },
    ["Shows/Hides the melee attack speed."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo im Nahkampf.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значения скорости атаки",
        ["esES"] = "Muestra/oculta la velocidad de ataque cuerpo a cuerpo",
        ["esMX"] = "Muestra/oculta la velocidad de ataque cuerpo a cuerpo"
    },
    ["Shows/Hides the attack speed of the main hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Waffenhand.",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Показать/скрыть значение скорости атаки оружия в правой руке",
        ["esES"] = "Muestra/oculta la velocidad de ataque de la mano derecha",
        ["esMX"] = "Muestra/oculta la velocidad de ataque de la mano derecha"
    },
    ["Shows/Hides the attack speed of the off hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Schildhand.",
        ["frFR"] = false,
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
        ["frFR"] = "Affiche/cache les chances de toucher en mêlée.",
        ["zhCN"] = "显示/隐藏 所有近战命中率",
        ["ruRU"] = "Показать/скрыть все показатели меткости",
        ["esES"] = "Muestra/oculta la probabilidad de golpear",
        ["esMX"] = "Muestra/oculta la probabilidad de golpear"
    },
    ["Hit Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferwertung",
        ["frFR"] = false,
        ["zhCN"] = false,
        ["ruRU"] = "Меткость",
        ["esES"] = "Índice de golpear",
        ["esMX"] = "Índice de golpear"
    },
    ["Shows/Hides the melee hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Nahkampf Trefferwertung.",
        ["frFR"] = false,
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
        ["frFR"] = "Affiche/Cache le bonus de toucher.",
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
    ["Glancing Blow Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Streifschlagchance",
        ["frFR"] = "Chance de coup éraflant",
        ["zhCN"] = "偏斜打击几率",
        ["ruRU"] = "Шанс скользящего удара",
        ["esES"] = "Probabilidad de golpe de refilón",
        ["esMX"] = "Probabilidad de golpe de refilón"
    },
    ["Shows/Hides the glancing chance against enemies on same level."] = {
        ["enUS"] = "Shows/Hides the glancing chance against enemies on same level.",
        ["deDE"] = "Zeigt/Verbirgt die Streifschlagchance gegenüber Gegnern auf gleichem Niveau.",
        ["frFR"] = "Affiche/Masque la chance de coup éraflant contre les ennemis du même niveau.",
        ["zhCN"] = "显示/隐藏与同等级敌人的偏斜打击几率。",
        ["ruRU"] = "Показывает/Скрывает шанс скользящего удара против врагов того же уровня.",
        ["esES"] = "Muestra/Oculta la probabilidad de golpe de refilón contra enemigos del mismo nivel.",
        ["esMX"] = "Muestra/Oculta la probabilidad de golpe de refilón contra enemigos del mismo nivel."
    },
    ["Glancing Blow Chance Boss"] = {
        ["enUS"] = true,
        ["deDE"] = "Streifschlagchance Boss",
        ["frFR"] = "Chance de coup éraflant sur le boss",
        ["zhCN"] = "对Boss的偏斜打击几率",
        ["ruRU"] = "Шанс скользящего удара по боссу",
        ["esES"] = "Probabilidad de golpe de refilón contra jefes",
        ["esMX"] = "Probabilidad de golpe de refilón contra jefes"
    },
    ["Shows/Hides the glancing chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Verbirgt die Streifschlagchance gegenüber Bossgegnern (+3 Stufen).",
        ["frFR"] = "Affiche/Masque la chance de coup éraflant contre les boss (+3 Niveaux).",
        ["zhCN"] = "显示/隐藏对Boss敌人的偏斜打击几率（+3级）。",
        ["ruRU"] = "Показывает/Скрывает шанс скользящего удара против боссов (+3 Уровня).",
        ["esES"] = "Muestra/Oculta la probabilidad de golpe de refilón contra jefes (+3 Niveles).",
        ["esMX"] = "Muestra/Oculta la probabilidad de golpe de refilón contra jefes (+3 Niveles)."
    },
    ["Glancing Blow Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Streifschlagschaden",
        ["frFR"] = "Dégâts du coup éraflant",
        ["zhCN"] = "偏斜打击伤害",
        ["ruRU"] = "Урон от скользящего удара",
        ["esES"] = "Daño de golpe de refilón",
        ["esMX"] = "Daño de golpe de refilón"
    },
    ["Shows/Hides the glancing damage against enemies on same level"] = {
        ["enUS"] = "Shows/Hides the glancing damage against enemies on same level",
        ["deDE"] = "Zeigt/Verbirgt den Streifschlagschaden gegenüber Gegnern auf gleichem Niveau",
        ["frFR"] = "Affiche/Masque les dégâts du coup éraflant contre les ennemis du même niveau",
        ["zhCN"] = "显示/隐藏对同等级敌人的偏斜打击伤害",
        ["ruRU"] = "Показывает/Скрывает урон от скользящего удара против врагов того же уровня",
        ["esES"] = "Muestra/Oculta el daño de golpe de refilón contra enemigos del mismo nivel",
        ["esMX"] = "Muestra/Oculta el daño de golpe de refilón contra enemigos del mismo nivel"
    },
    ["Glancing Blow Damage Boss"] = {
        ["enUS"] = true,
        ["deDE"] = "Streifschlagschaden Boss",
        ["frFR"] = "Dégâts du coup éraflant sur le boss",
        ["zhCN"] = "对Boss的偏斜打击伤害",
        ["ruRU"] = "Урон от скользящего удара по боссу",
        ["esES"] = "Daño de golpe de refilón contra jefes",
        ["esMX"] = "Daño de golpe de refilón contra jefes"
    },
    ["Shows/Hides the glancing damage against boss enemies (+3 Level)."] = {
        ["enUS"] = "Shows/Hides the glancing damage against boss enemies (+3 Level).",
        ["deDE"] = "Zeigt/Verbirgt den Streifschlagschaden gegenüber Bossgegnern (+3 Stufen).",
        ["frFR"] = "Affiche/Masque les dégâts du coup éraflant contre les boss (+3 Niveaux).",
        ["zhCN"] = "显示/隐藏对Boss敌人的偏斜打击伤害（+3级）。",
        ["ruRU"] = "Показывает/Скрывает урон от скользящего удара против боссов (+3 Уровня).",
        ["esES"] = "Muestra/Oculta el daño de golpe de refilón contra jefes (+3 Niveles).",
        ["esMX"] = "Muestra/Oculta el daño de golpe de refilón contra jefes (+3 Niveles)."
    },
    ["Melee Glance Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf-Streifwerte",
        ["frFR"] = "Valeurs de coup éraflant en mêlée",
        ["zhCN"] = "近战偏斜值",
        ["ruRU"] = "Значения скользящих ударов в ближнем бою",
        ["esES"] = "Valores de refilón en combate cuerpo a cuerpo",
        ["esMX"] = "Valores de refilón en combate cuerpo a cuerpo"
    },
    ["Shows/Hides all glancing blow stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Verbirgt alle Streifschlagstatistiken",
        ["frFR"] = "Affiche/Masque toutes les statistiques de coups éraflants",
        ["zhCN"] = "显示/隐藏所有偏斜打击统计",
        ["ruRU"] = "Показывает/Скрывает все статистики скользящих ударов",
        ["esES"] = "Muestra/Oculta todas las estadísticas de golpes de refilón",
        ["esMX"] = "Muestra/Oculta todas las estadísticas de golpes de refilón"
    }
}

for k, v in pairs(meleeConfigTranslations) do
    i18n.translations[k] = v
end
