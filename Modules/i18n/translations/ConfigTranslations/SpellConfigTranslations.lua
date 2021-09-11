---@type i18n
local i18n = QuestieLoader:ImportModule("i18n")

local spellConfigTranslations = {
    ["Show Spell Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauberwerte anzeigen",
        ["frFR"] = "Sorts Général",
        ["zhCN"] = "显示法术属性",
    },
    ["Shows/Hides all spell stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Zauberwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques des sorts.",
        ["zhCN"] = "显示/隐藏 法术属性",
    },
    ["Shows/Hides the spell crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit einem Zauber kritisch zu treffen.",
        ["frFR"] = "Affiche/cache les chances d'infliger un coup critique avec les sorts.",
        ["zhCN"] = "显示/隐藏 法术暴击",
    },
    ["Shows/Hides all spell hit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Trefferwertungen für Zauber.",
        ["frFR"] = "Affiche/cache les chances de toucher avec les sorts.",
        ["zhCN"] = "显示/隐藏 法术命中",
    },
    ["Shows/Hides the spell hit rating."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauber Trefferwertung.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },
    ["Shows/Hides the spell hit bonus."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Bonus auf die Zauber Trefferwertung.",
        ["frFR"] = "Affiche/cache le bonus de toucher des sorts.",
        ["zhCN"] = "显示/隐藏 法术命中几率",
    },
    ["Shows/Hides the spell miss chance against enemies on the same level."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner des gleichen Levels mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un ennemi du même niveau.",
        ["zhCN"] = "显示/隐藏 针对同等级敌人的法术未命中率",
    },
    ["Shows/Hides the spell miss chance against boss enemies (+3 Level)."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance einen Gegner mit 3 Level über dem eigenen mit Zauber zu verfehlen.",
        ["frFR"] = "Affiche/cache les chances de rater des sorts contre un boss de 3 niveaux supérieurs.",
        ["zhCN"] = "显示/隐藏 针对BOSS的法术未命中率 (+3 等级)。",
    },
    ["Shows/Hides the spell penetration value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Zauberdurchschlagskraft.",
        ["frFR"] = false,
        ["zhCN"] = false,
    },

    ["Show Spell Power Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Zaubermachtwerte anzeigen",
        ["frFR"] = "Afficher la puissance des sorts",
        ["zhCN"] = "显示法术强度属性",
    },
    ["Shows/Hides all spell power stats."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Zaubermachtwerte.",
        ["frFR"] = "Affiche/cache toutes les statistiques de puissance des sorts.",
        ["zhCN"] = "显示/隐藏 法术强度属性",
    },
    ["Shows/Hides the physical damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den physischen Schadenswert.",
        ["frFR"] = "Affiche/Cache les dégats physiques.",
        ["zhCN"] = "显示/隐藏 物理伤害",
    },
    ["Shows/Hides the physical crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit physischen Zaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique physique.",
        ["zhCN"] = "显示/隐藏 物理暴击",
    },
    ["Shows/Hides the holy damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heiligschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du sacré.",
        ["zhCN"] = "显示/隐藏 神圣伤害",
    },
    ["Shows/Hides the holy crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Heiligzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du sacré.",
        ["zhCN"] = "显示/隐藏 神圣暴击",
    },
    ["Shows/Hides the arcane damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Arkanschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术伤害",
    },
    ["Shows/Hides the arcane crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Arkanzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术暴击",
    },

    ["Shows/Hides the nature damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Naturschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats de la nature.",
        ["zhCN"] = "显示/隐藏 自然伤害",
    },
    ["Shows/Hides the nature crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Naturzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique de la nature.",
        ["zhCN"] = "显示/隐藏 自然暴击",
    },
    ["Shows/Hides the frost damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Frostschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du givre.",
        ["zhCN"] = "显示/隐藏 冰霜伤害",
    },
    ["Shows/Hides the frost crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Frostzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du givre.",
        ["zhCN"] = "显示/隐藏 冰霜暴击",
    },
    ["Shows/Hides the fire damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Feuerschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats du feu.",
        ["zhCN"] = "显示/隐藏 火焰伤害",
    },
    ["Shows/Hides the fire crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Feuerzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique du feu.",
        ["zhCN"] = "显示/隐藏 火焰暴击",
    },

    ["Shows/Hides the shadow damage value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Schattenschadenswert.",
        ["frFR"] = "Affiche/Cache les dégats des ombres.",
        ["zhCN"] = "显示/隐藏 暗影伤害",
    },
    ["Shows/Hides the shadow crit chance."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die Chance mit Schattenzaubern kritisch zu treffen.",
        ["frFR"] = "Affiche/Cache les chances de critique des ombres.",
        ["zhCN"] = "显示/隐藏 暗影暴击",
    },

    ["Shows/Hides the healing power value."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt den Heilungsmachtwert.",
        ["frFR"] = "Affiche/Cache la puissance des soins.",
        ["zhCN"] = "显示/隐藏 法术治疗",
    },
}

for k, v in pairs(spellConfigTranslations) do
    i18n.translations[k] = v
end