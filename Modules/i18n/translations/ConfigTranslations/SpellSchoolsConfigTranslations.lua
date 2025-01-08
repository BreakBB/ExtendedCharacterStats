---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local spellSchoolsConfigTranslations = {
    ["Spell Schools"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber Schulen",
        ["frFR"] = "Écoles de magie",
        ["zhCN"] = "法术学派",
        ["ruRU"] = "Школы магии",
        ["esES"] = "Escuelas de hechizos",
        ["esMX"] = "Escuelas de hechizos",
        ["ptBR"] = "Escolas de feitiços"
    },
    ["Arcane"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkan",
        ["frFR"] = "Arcanes",
        ["zhCN"] = "奥术",
        ["ruRU"] = "Тайная магия",
        ["esES"] = "Arcano",
        ["esMX"] = "Arcano",
        ["ptBR"] = "Arcano"
    },
    ["Shows/Hides all arcane values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Arkanwerte.",
        ["frFR"] = "Affiche/cache les dégats des arcanes.",
        ["zhCN"] = "显示/隐藏 奥术伤害",
        ["ruRU"] = "Показать/скрыть все значения аркано",
        ["esES"] = "Muestra/oculta todos los valores arcanos",
        ["esMX"] = "Muestra/oculta todos los valores arcanos",
        ["ptBR"] = "Mostra/oculta todos os valores arcanos",
    },
    ["Fire"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuer",
        ["frFR"] = "Feu",
        ["zhCN"] = "火焰",
        ["ruRU"] = "Огонь",
        ["esES"] = "Fuego",
        ["esMX"] = "Fuego",
        ["ptBR"] = "Fogo"
    },
    ["Shows/Hides all fire values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Feuerwerte.",
        ["frFR"] = "Affiche/cache les dégats du feu.",
        ["zhCN"] = "显示/隐藏 火焰伤害",
        ["ruRU"] = "Показать/скрыть все значения огня",
        ["esES"] = "Muestra/oculta todos los valores de fuego",
        ["esMX"] = "Muestra/oculta todos los valores de fuego",
        ["ptBR"] = "Mostra/oculta todos os valores de fogo",
    },
    ["Frost"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = "Givre",
        ["zhCN"] = "冰霜",
        ["ruRU"] = "Лед",
        ["esES"] = "Escarcha",
        ["esMX"] = "Escarcha",
        ["ptBR"] = "Gelo"
    },
    ["Shows/Hides all frost values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Frostwerte.",
        ["frFR"] = "Affiche/cache les dégats du givre.",
        ["zhCN"] = "显示/隐藏 冰霜伤害",
        ["ruRU"] = "Показать/скрыть все значения льда",
        ["esES"] = "Muestra/oculta todos los valores de escarcha",
        ["esMX"] = "Muestra/oculta todos los valores de escarcha",
        ["ptBR"] = "Mostra/oculta todos os valores de gelo",
    },
    ["Holy"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilig",
        ["frFR"] = "Sacré",
        ["zhCN"] = "神圣",
        ["ruRU"] = "Свет",
        ["esES"] = "Sagrado",
        ["esMX"] = "Sagrado",
        ["ptBR"] = "Sagrado"
    },
    ["Shows/Hides all holy values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Heiligwerte.",
        ["frFR"] = "Affiche/cache les dégats sacrés.",
        ["zhCN"] = "显示/隐藏 神圣伤害",
        ["ruRU"] = "Показать/скрыть все значения света",
        ["esES"] = "Muestra/oculta todos los valores sagrados",
        ["esMX"] = "Muestra/oculta todos los valores sagrados",
        ["ptBR"] = "Mostra/oculta todos os valores sagrados",
    },
    ["Nature"] = {
        ["enUS"] = true,
        ["deDE"] = "Natur",
        ["frFR"] = true,
        ["zhCN"] = "自然",
        ["ruRU"] = "Природа",
        ["esES"] = "Naturaleza",
        ["esMX"] = "Naturaleza",
        ["ptBR"] = "Natureza"
    },
    ["Shows/Hides all nature values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Naturwerte.",
        ["frFR"] = "Affiche/cache les dégats de la nature.",
        ["zhCN"] = "显示/隐藏 自然伤害",
        ["ruRU"] = "Показать/скрыть все значения природы",
        ["esES"] = "Muestra/oculta todos los valores de naturaleza",
        ["esMX"] = "Muestra/oculta todos los valores de naturaleza",
        ["ptBR"] = "Mostra/oculta todos os valores de natureza",
    },
    ["Physical"] = {
        ["enUS"] = true,
        ["deDE"] = "Physisch",
        ["frFR"] = "Physique",
        ["zhCN"] = "物理",
        ["ruRU"] = "Физический",
        ["esES"] = "Físico",
        ["esMX"] = "Físico",
        ["ptBR"] = "Físico"
    },
    ["Shows/Hides all physical values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Physischwerte.",
        ["frFR"] = "Affiche/cache les dégats physiques.",
        ["zhCN"] = "显示/隐藏 物理伤害",
        ["ruRU"] = "Показать/скрыть все значения физического урона",
        ["esES"] = "Muestra/oculta todos los valores físicos",
        ["esMX"] = "Muestra/oculta todos los valores físicos",
        ["ptBR"] = "Mostra/oculta todos os valores físicos",
    },
    ["Shadow"] = {
        ["enUS"] = true,
        ["deDE"] = "Schatten",
        ["frFR"] = "Ombre",
        ["zhCN"] = "暗影",
        ["ruRU"] = "Тьма",
        ["esES"] = "Sombras",
        ["esMX"] = "Sombras",
        ["ptBR"] = "Sombra"
    },
    ["Shows/Hides all shadow values."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt alle Schattenwerte.",
        ["frFR"] = "Affiche/cache les dégats des ombres.",
        ["zhCN"] = "显示/隐藏 暗影伤害",
        ["ruRU"] = "Показать/скрыть все значения тьмы",
        ["esES"] = "Muestra/oculta todos los valores de sombras",
        ["esMX"] = "Muestra/oculta todos los valores de sombras",
        ["ptBR"] = "Mostra/oculta todos os valores de sombra",
    },
}

for k, v in pairs(spellSchoolsConfigTranslations) do
    i18n.translations[k] = v
end
