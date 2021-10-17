---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local meleeConfigTranslations = {
    ["Show Melee Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampfwerte anzeigen",
        ["frFR"] = "Mêlée Général",
        ["zhCN"] = "显示近战属性",
    },
    ["Shows/Hides all melee stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Nahkampfwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de mêlée.",
        ["zhCN"] = "显示/隐藏 所有近战属性",
    },
    ["Melee Attack Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Angriffskraft",
        ["frFR"] = "Puissance d'attaque en mêlée",
        ["zhCN"] = "近战攻击强度",
    },
    ["Shows/Hides the melee attack power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Nahkampf Angriffskraftwert.",
        ["frFR"] = "Affiche/Cache la puissance d'attaque en mêlée.",
        ["zhCN"] = "显示/隐藏 近战攻击强度",
    },
    ["Melee Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Kritisch",
        ["frFR"] = "Critique en mêlée",
        ["zhCN"] = "近战暴击",
    },
    ["Shows/Hides the melee crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance im Nahkampf kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances d'infliger un coup critique en mêlée.",
        ["zhCN"] = "显示/隐藏 近战暴击几率",
    },
    ["Shows/Hides the expertise value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Waffenkundewertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Shows/Hides the melee attack speed."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo im Nahkampf.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Shows/Hides the attack speed of the main hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Waffenhand.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Shows/Hides the attack speed of the off hand."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt das Angriffstempo der Schildhand.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Melee Hit"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Trefferwertung",
        ["frFR"] = "Toucher en mêlée",
        ["zhCN"] = "近战命中",
    },
    ["Melee Hit Values"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf Trefferwertung",
        ["frFR"] = "Valeurs de toucher en mêlée",
        ["zhCN"] = "近战命中率",
    },
    ["Shows/Hides all melee hit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Trefferwertungen im Nahkampf.",
        ["frFR"] = "Affiche/cache les chances de toucher en mêlée.",
        ["zhCN"] = "显示/隐藏 所有近战命中率",
    },
    ["Hit Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferwertung",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Shows/Hides the melee hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Nahkampf Trefferwertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferwertungsbonus",
        ["frFR"] = "Bonus de toucher",
        ["zhCN"] = "命中几率",
    },
    ["Shows/Hides the melee hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Nahkampf Trefferwertung.",
        ["frFR"] = "Affiche/Cache le bonus de toucher.",
        ["zhCN"] = "显示/隐藏 近战命中率",
    },
    ["Miss Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Chance zu verfehlen",
        ["frFR"] = "Chances de rater",
        ["zhCN"] = "未命中几率",
    },
    ["Shows/Hides the melee miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels im Nahkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater en mêlée contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的近战未命中率",
    },
    ["Miss Chance Boss"] = {
        ["enUS"] = true,
        ["deDE"] = "Chance zu verfehlen (Boss)",
        ["frFR"] = "Chances de rater-Boss",
        ["zhCN"] = "未命中 Boss",
    },
    ["Shows/Hides the melee miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen im Nahkampf zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater en mêlée contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的近战未命中率 (+3 等级)。",
    },
}

for k, v in pairs(meleeConfigTranslations) do
    i18n.translations[k] = v
end