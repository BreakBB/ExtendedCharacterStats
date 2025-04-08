---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local statTranslations = {
    ["General"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemein",
        ["frFR"] = "Général",
        ["zhCN"] = "一般",
        ["ruRU"] = "Основные",
        ["esES"] = true,
        ["esMX"] = true,
        ["ptBR"] = "Geral"
    },
    ["Movement Speed"] = {
        ["enUS"] = true,
        ["deDE"] = "Geschwindigkeit",
        ["frFR"] = "Vitesse de déplacement",
        ["zhCN"] = "移动速度",
        ["ruRU"] = "Скорость движения",
        ["esES"] = "Velocidad de movimiento",
        ["esMX"] = "Velocidad de movimiento",
        ["ptBR"] = "Velocidade de movimento"
    },
    ["Melee"] = {
        ["enUS"] = true,
        ["deDE"] = "Nahkampf",
        ["frFR"] = "Mêlée",
        ["zhCN"] = "近战",
        ["ruRU"] = "Ближний бой",
        ["esES"] = "Cuerpo a cuerpo",
        ["esMX"] = "Cuerpo a cuerpo",
        ["ptBR"] = "Corpo a corpo"
    },
    ["Attack Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Angriffskraft",
        ["frFR"] = "Puissance d'attaque",
        ["zhCN"] = "攻击强度",
        ["ruRU"] = "Сила атаки",
        ["esES"] = "Poder de ataque",
        ["esMX"] = "Poder de ataque",
        ["ptBR"] = "Poder de ataque"
    },
    ["Crit Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Kritische Chance",
        ["frFR"] = "Chances de critique",
        ["zhCN"] = "暴击几率",
        ["ruRU"] = "Крит",
        ["esES"] = "Probabilidad de golpe crítico",
        ["esMX"] = "Probabilidad de golpe crítico",
        ["ptBR"] = "Chance de acerto crítico"
    },
    ["Armor Pen."] = {
        ["enUS"] = true,
        ["deDE"] = "Rüstungsdurchschlagskraft",
        ["frFR"] = "Pénétration d'armure",
        ["zhCN"] = false,
        ["ruRU"] = "Проник. способ. броня",
        ["esES"] = "Penetración de armadura",
        ["esMX"] = "Penetración de armadura",
        ["ptBR"] = "Penetração em Armadura"
    },
    ["Armor Pen. Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Rüstungsdurchschlagwertung",
        ["frFR"] = "Score de pénétration d'armure",
        ["zhCN"] = false,
        ["ruRU"] = false,
        ["esES"] = "Índice de penetración de armadura",
        ["esMX"] = "Índice de penetración de armadura",
        ["ptBR"] = "Taxa de penetração em armadura"
    },
    ["Expertise"] = {
        ["enUS"] = true,
        ["deDE"] = "Waffenkunde",
        ["frFR"] = "Expertise",
        ["zhCN"] = false,
        ["ruRU"] = "Мастерство",
        ["esES"] = "Pericia",
        ["esMX"] = "Pericia",
        ["ptBR"] = "Aptidão"
    },
    ["Expertise Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Waffenkundewertung",
        ["frFR"] = "Score d'expertise",
        ["zhCN"] = false,
        ["ruRU"] = "Рейтинг мастерства",
        ["esES"] = "Índice de pericia",
        ["esMX"] = "Índice de pericia",
        ["ptBR"] = "Taxa de aptidão"
    },
    ["Hit"] = {
        ["enUS"] = true,
        ["deDE"] = "Trefferchance",
        ["frFR"] = "Toucher",
        ["zhCN"] = "命中",
        ["ruRU"] = "Меткость",
        ["esES"] = "Probabilidad de golpear",
        ["esMX"] = "Probabilidad de golpear",
        ["ptBR"] = "Chance de acerto"
    },
    ["Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Wertung",
        ["frFR"] = "Score",
        ["zhCN"] = false,
        ["ruRU"] = "Меткость",
        ["esES"] = "Índice",
        ["esMX"] = "Índice",
        ["ptBR"] = "Taxa"
    },
    ["Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = "命中",
        ["ruRU"] = "Бонус",
        ["esES"] = true,
        ["esMX"] = true,
        ["ptBR"] = "Bônus"
    },
    ["Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Verfehlen",
        ["frFR"] = "Rater",
        ["zhCN"] = "未命中",
        ["ruRU"] = "Сопротивление",
        ["esES"] = "Fallo",
        ["esMX"] = "Fallo",
        ["ptBR"] = "Erro"
    },
    ["Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater (Niv. + 3)",
        ["zhCN"] = "未命中 (等级 + 3)",
        ["ruRU"] = "Сопрот. (+3 ур.)",
        ["esES"] = "Fallo (Niv. + 3)",
        ["esMX"] = "Fallo (Niv. + 3)",
        ["ptBR"] = "Erro (Nív. + 3)",
    },
    ["Glancing Blow"] = {
        ["enUS"] = true,
        ["deDE"] = "Streifschlag",
        ["frFR"] = "Coup d'éraflure",
        ["zhCN"] = "偏斜打击",
        ["ruRU"] = "Скользящий удар",
        ["esES"] = "Golpe de refilón",
        ["esMX"] = "Golpe de refilón",
        ["ptBR"] = "Pancada de relance",
    },
    ["Chance"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = "几率",
        ["ruRU"] = "Шанс",
        ["esES"] = "Probabilidad",
        ["esMX"] = "Probabilidad",
        ["ptBR"] = true
    },
    ["Chance (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = "Chance (Niv. + 3)",
        ["zhCN"] = "几率（等级 + 3）",
        ["ruRU"] = "Шанс (+3 ур.)",
        ["esES"] = "Probabilidad (Niv. + 3)",
        ["esMX"] = "Probabilidad (Niv. + 3)",
        ["ptBR"] = "Chance (Nív. + 3)"
    },
    ["Damage"] = {
        ["enUS"] = "Damage",
        ["deDE"] = "Schaden",
        ["frFR"] = "Dégâts",
        ["zhCN"] = "伤害",
        ["ruRU"] = "Урон",
        ["esES"] = "Daño",
        ["esMX"] = "Daño",
        ["ptBR"] = "Dano"
    },
    ["Damage (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Schaden (Lvl + 3)",
        ["frFR"] = "Dégâts (Niv. + 3)",
        ["zhCN"] = "伤害（等级 + 3）",
        ["ruRU"] = "Урон (+3 ур.)",
        ["esES"] = "Daño (Niv. + 3)",
        ["esMX"] = "Daño (Niv. + 3)",
        ["ptBR"] = "Dano (Nív. + 3)"
    },
    ["Haste Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Tempowertung",
        ["frFR"] = "Score de hâte",
        ["zhCN"] = false,
        ["ruRU"] = "Рейтинг скорости",
        ["esES"] = "Índice de celeridad",
        ["esMX"] = "Índice de celeridad",
        ["ptBR"] = "Taxa de aceleração"
    },
    ["Haste Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Tempobonus",
        ["frFR"] = "Bonus de hâte",
        ["zhCN"] = false,
        ["ruRU"] = "Бонус к скорости",
        ["esES"] = "Bonus de celeridad",
        ["esMX"] = "Bonus de celeridad",
        ["ptBR"] = "Bônus de aceleração"
    },
    ["Attack Speed"] = {
        ["enUS"] = true,
        ["deDE"] = "Angriffstempo",
        ["frFR"] = "Vitesse d'attaque",
        ["zhCN"] = false,
        ["ruRU"] = "Скорость атаки",
        ["esES"] = "Velocidad de ataque",
        ["esMX"] = "Velocidad de ataque",
        ["ptBR"] = "Velocidade de ataque"
    },
    ["Main Hand"] = {
        ["enUS"] = true,
        ["deDE"] = "Waffenhand",
        ["frFR"] = "Main droite",
        ["zhCN"] = false,
        ["ruRU"] = "Правая рука",
        ["esES"] = "Mano derecha",
        ["esMX"] = "Mano derecha",
        ["ptBR"] = "Mão principal"
    },
    ["Off Hand"] = {
        ["enUS"] = true,
        ["deDE"] = "Schildhand",
        ["frFR"] = "Main gauche",
        ["zhCN"] = false,
        ["ruRU"] = "Левая рука",
        ["esES"] = "Mano izquierda",
        ["esMX"] = "Mano izquierda",
        ["ptBR"] = "Mão secundária"
    },
    ["Ranged"] = {
        ["enUS"] = true,
        ["deDE"] = "Fernkampf",
        ["frFR"] = "À distance",
        ["zhCN"] = "远程",
        ["ruRU"] = "Дальний бой",
        ["esES"] = "A distancia",
        ["esMX"] = "A distancia",
        ["ptBR"] = "Longo alcance"
    },
    ["Armor"] = {
        ["enUS"] = true,
        ["deDE"] = "Rüstung",
        ["frFR"] = "Armure",
        ["zhCN"] = "护甲",
        ["ruRU"] = "Броня",
        ["esES"] = "Armadura",
        ["esMX"] = "Armadura",
        ["ptBR"] = "Armadura"
    },
    ["Crit Immune"] = {
        ["enUS"] = true,
        ["deDE"] = "Krit. Immun",
        ["frFR"] = "Immunisé des critiques",
        ["zhCN"] = false,
        ["ruRU"] = "Крит иммун",
        ["esES"] = "Inmune Crít",
        ["esMX"] = "Inmune Crít",
        ["ptBR"] = "Imune a críticos"
    },
    ["Crit Reduction"] = {
        ["enUS"] = true,
        ["deDE"] = "Krit. Reduzierung",
        ["frFR"] = "Réduction des critiques",
        ["zhCN"] = false,
        ["ruRU"] = "Снижение крита",
        ["esES"] = "Reducción de Crít",
        ["esMX"] = "Reducción de Crít",
        ["ptBR"] = "Redução de crítico"
    },
    ["Avoidance"] = {
        ["enUS"] = true,
        ["deDE"] = "Vermeidung",
        ["frFR"] = "Évitement",
        ["zhCN"] = false,
        ["ruRU"] = "Избежание",
        ["esES"] = "Eludir",
        ["esMX"] = "Eludir",
        ["ptBR"] = "Evasiva"
    },
    ["Avoidance (Lvl +3)"] = {
        ["enUS"] = true,
        ["deDE"] = false,
        ["frFR"] = "Évitement (Niv. +3)",
        ["zhCN"] = false,
        ["ruRU"] = false,
        ["esES"] = "Eludir (Niv. +3)",
        ["esMX"] = "Eludir (Niv. +3)",
        ["ptBR"] = "Evasiva (Nív. +3)"
    },
    ["Defense Rating"] = {
        ["enUS"] = true,
        ["deDE"] = "Verteidigungswertung",
        ["frFR"] = "Score de défense",
        ["zhCN"] = false,
        ["ruRU"] = "Доп. защита",
        ["esES"] = "Índice de defensa",
        ["esMX"] = "Índice de defensa",
        ["ptBR"] = "Taxa de defesa"
    },
    ["Defense"] = {
        ["enUS"] = true,
        ["deDE"] = "Verteidigung",
        ["frFR"] = "Défense",
        ["zhCN"] = "防御",
        ["ruRU"] = "Защита",
        ["esES"] = "Defensa",
        ["esMX"] = "Defensa",
        ["ptBR"] = "Defesa"
    },
    ["Block Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Blockchance",
        ["frFR"] = "Chances de bloquer",
        ["zhCN"] = "格挡几率",
        ["ruRU"] = "Шанс блока",
        ["esES"] = "Probabilidad de bloquear",
        ["esMX"] = "Probabilidad de bloquear",
        ["ptBR"] = "Chance de bloquear"
    },
    ["Block Value"] = {
        ["enUS"] = true,
        ["deDE"] = "Blockwertung",
        ["frFR"] = "Bloquer",
        ["zhCN"] = "格挡值",
        ["ruRU"] = "Блок",
        ["esES"] = "Bloqueo",
        ["esMX"] = "Bloqueo",
        ["ptBR"] = "Bloqueio"
    },
    ["Parry Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Parrierchance",
        ["frFR"] = "Chances de parer",
        ["zhCN"] = "招架几率",
        ["ruRU"] = "Парирование",
        ["esES"] = "Probabilidad de parar",
        ["esMX"] = "Probabilidad de parar",
        ["ptBR"] = "Chance de aparar"
    },
    ["Dodge Chance"] = {
        ["enUS"] = true,
        ["deDE"] = "Ausweichchance",
        ["frFR"] = "Chances d'esquiver",
        ["zhCN"] = "躲闪几率",
        ["ruRU"] = "Уклонение",
        ["esES"] = "Probabilidad de esquivar",
        ["esMX"] = "Probabilidad de esquivar",
        ["ptBR"] = "Chance de esquivar"
    },
    ["Resilience"] = {
        ["enUS"] = true,
        ["deDE"] = "Abhärtung",
        ["frFR"] = "Résilience",
        ["zhCN"] = false,
        ["ruRU"] = "Устойчивость",
        ["esES"] = "Temple",
        ["esMX"] = "Temple",
        ["ptBR"] = "Resiliência"
    },
    ["Mana"] = {
        ["enUS"] = true,
        ["deDE"] = true,
        ["frFR"] = true,
        ["zhCN"] = "法力回复",
        ["ruRU"] = "Мана",
        ["esES"] = "Maná",
        ["esMX"] = "Maná",
        ["ptBR"] = true
    },
    ["MP5 (Items)"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 (Gegenstände)",
        ["frFR"] = "MP5 (Objets)",
        ["zhCN"] = "装备回蓝",
        ["ruRU"] = "MP5 (экип.)",
        ["esES"] = "MP5 (Objetos)",
        ["esMX"] = "MP5 (Objetos)",
        ["ptBR"] = "MP5 (Itens)"
    },
    ["MP5 (Spirit)"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 (Willenskraft)",
        ["frFR"] = "MP5 (Esprit)",
        ["zhCN"] = "精神回蓝",
        ["ruRU"] = "MP5 (дух)",
        ["esES"] = "MP5 (Espíritu)",
        ["esMX"] = "MP5 (Espíritu)",
        ["ptBR"] = "MP5 (Espírito)"
    },
    ["MP5 (Buffs)"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 (Stärkungszauber)",
        ["frFR"] = "MP5 (Améliorations)",
        ["zhCN"] = "增益回蓝",
        ["ruRU"] = "MP5 (баффы)",
        ["esES"] = "MP5 (Beneficios)",
        ["esMX"] = "MP5 (Beneficios)",
        ["ptBR"] = "MP5 (Bônus)"
    },
    ["MP5 (Casting)"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 (Zaubernd)",
        ["frFR"] = "MP5 (Incantation)",
        ["zhCN"] = "附魔回蓝",
        ["ruRU"] = "MP5 (каст)",
        ["esES"] = "MP5 (Lanzar)",
        ["esMX"] = "MP5 (Lanzar)",
        ["ptBR"] = "MP5 (Lançar)"
    },
    ["MP5 (Not casting)"] = {
        ["enUS"] = true,
        ["deDE"] = "MP5 (Nicht zaubernd)",
        ["frFR"] = "MP5 (Pas d'incantation)",
        ["zhCN"] = "MP5（非铸造）",
        ["ruRU"] = "MP5 (не каст)",
        ["esES"] = "MP5 (Sin lanzar)",
        ["esMX"] = "MP5 (Sin lanzar)",
        ["ptBR"] = "MP5 (Sem lançar)"
    },
    ["Spell"] = {
        ["enUS"] = true,
        ["deDE"] = "Zauber",
        ["frFR"] = "Sorts",
        ["zhCN"] = "法术强度",
        ["ruRU"] = "Заклинания",
        ["esES"] = "Hechizo",
        ["esMX"] = "Hechizo",
        ["ptBR"] = "Feitiço"
    },
    ["Penetration"] = {
        ["enUS"] = true,
        ["deDE"] = "Durchschlagskraft",
        ["frFR"] = "Pénétration",
        ["zhCN"] = false,
        ["ruRU"] = "Проник. способ.",
        ["esES"] = "Penetración",
        ["esMX"] = "Penetración",
        ["ptBR"] = "Penetração"
    },
    ["Healing Power"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilungskraft",
        ["frFR"] = "Pouvoir de guérison",
        ["zhCN"] = "法术治疗",
        ["ruRU"] = "Доп. исцеление",
        ["esES"] = "Curación",
        ["esMX"] = "Sanación",
        ["ptBR"] = "Poder de cura"
    },
    ["Arcane Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkanschaden",
        ["frFR"] = "Dégats des arcanes",
        ["zhCN"] = "奥术伤害",
        ["ruRU"] = "Тайная магия",
        ["esES"] = "Daño arcano",
        ["esMX"] = "Daño arcano",
        ["ptBR"] = "Dano arcano"
    },
    ["Arcane Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkan Kritisch",
        ["frFR"] = "Critique des arcanes",
        ["zhCN"] = "奥术暴击",
        ["ruRU"] = "Крит (ТМ)",
        ["esES"] = "Crítico arcano",
        ["esMX"] = "Crítico arcano",
        ["ptBR"] = "Crítico arcano"
    },
    ["Arcane Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkan Trefferchancebonus",
        ["frFR"] = "Bonus de toucher des arcanes",
        ["zhCN"] = "奥术命中加成",
        ["ruRU"] = "Меткость (ТМ)",
        ["esES"] = "Bonificación de golpe arcano",
        ["esMX"] = "Bonificación de golpe arcano",
        ["ptBR"] = "Bônus de acerto arcano"
    },
    ["Arcane Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkan Verfehlen",
        ["frFR"] = "Rater des arcanes",
        ["zhCN"] = "奥术未命中",
        ["ruRU"] = "Сопротивление (ТМ)",
        ["esES"] = "Fallo arcano",
        ["esMX"] = "Fallo arcano",
        ["ptBR"] = "Erro arcano"
    },
    ["Arcane Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Arkan Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater des arcanes (Niv. + 3)",
        ["zhCN"] = "奥术未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (ТМ) (+3 ур.)",
        ["esES"] = "Fallo arcano (Niv. + 3)",
        ["esMX"] = "Fallo arcano (Niv. + 3)",
        ["ptBR"] = "Erro arcano (Nív. + 3)"
    },
    ["Fire Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuerschaden",
        ["frFR"] = "Dégats du feu",
        ["zhCN"] = "火焰伤害",
        ["ruRU"] = "Огонь",
        ["esES"] = "Daño de fuego",
        ["esMX"] = "Daño de fuego",
        ["ptBR"] = "Dano de fogo"
    },
    ["Fire Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuer Kritisch",
        ["frFR"] = "Critique du feu",
        ["zhCN"] = "火焰暴击",
        ["ruRU"] = "Крит (огонь)",
        ["esES"] = "Crítico de fuego",
        ["esMX"] = "Crítico de fuego",
        ["ptBR"] = "Crítico de fogo"
    },
    ["Fire Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuer Trefferchancebonus",
        ["frFR"] = "Bonus de toucher du feu",
        ["zhCN"] = "火焰命中加成",
        ["ruRU"] = "Меткость (огонь)",
        ["esES"] = "Bonificación de golpe de fuego",
        ["esMX"] = "Bonificación de golpe de fuego",
        ["ptBR"] = "Bônus de acerto de fogo"
    },
    ["Fire Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuer Verfehlen",
        ["frFR"] = "Rater du feu",
        ["zhCN"] = "火焰未命中",
        ["ruRU"] = "Сопротивление (огонь)",
        ["esES"] = "Fallo de fuego",
        ["esMX"] = "Fallo de fuego",
        ["ptBR"] = "Erro de fogo"
    },
    ["Fire Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Feuer Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater du feu (Niv. + 3)",
        ["zhCN"] = "火焰未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (огонь) (+3 ур.)",
        ["esES"] = "Fallo de fuego (Niv. + 3)",
        ["esMX"] = "Fallo de fuego (Niv. + 3)",
        ["ptBR"] = "Erro de fogo (Nív. + 3)"
    },
    ["Frost Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Frostschaden",
        ["frFR"] = "Dégats du givre",
        ["zhCN"] = "冰霜伤害",
        ["ruRU"] = "Лед",
        ["esES"] = "Daño de escarcha",
        ["esMX"] = "Daño de escarcha",
        ["ptBR"] = "Dano de gelo"
    },
    ["Frost Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Frost Kritisch",
        ["frFR"] = "Critique du givre",
        ["zhCN"] = "冰霜暴击",
        ["ruRU"] = "Крит (лед)",
        ["esES"] = "Crítico de escarcha",
        ["esMX"] = "Crítico de escarcha",
        ["ptBR"] = "Crítico de gelo"
    },
    ["Frost Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Frost Trefferchancebonus",
        ["frFR"] = "Bonus de toucher du givre",
        ["zhCN"] = "冰霜命中加成",
        ["ruRU"] = "Меткость (лед)",
        ["esES"] = "Bonificación de golpe de escarcha",
        ["esMX"] = "Bonificación de golpe de escarcha",
        ["ptBR"] = "Bônus de acerto de gelo"
    },
    ["Frost Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Frost Verfehlen",
        ["frFR"] = "Rater du givre",
        ["zhCN"] = "冰霜未命中",
        ["ruRU"] = "Сопротивление (лед)",
        ["esES"] = "Fallo de escarcha",
        ["esMX"] = "Fallo de escarcha",
        ["ptBR"] = "Erro de gelo"
    },
    ["Frost Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Frost Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater du givre (Niv. + 3)",
        ["zhCN"] = "冰霜未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (лед) (+3 ур.)",
        ["esES"] = "Fallo de escarcha (Niv. + 3)",
        ["esMX"] = "Fallo de escarcha (Niv. + 3)",
        ["ptBR"] = "Erro de gelo (Nív. + 3)"
    },
    ["Holy Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Heiligschaden",
        ["frFR"] = "Dégats du sacré",
        ["zhCN"] = "神圣伤害",
        ["ruRU"] = "Свет",
        ["esES"] = "Daño sagrado",
        ["esMX"] = "Daño sagrado",
        ["ptBR"] = "Dano sagrado"
    },
    ["Holy Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilig Kritisch",
        ["frFR"] = "Critique du sacré",
        ["zhCN"] = "神圣暴击",
        ["ruRU"] = "Крит (свет)",
        ["esES"] = "Crítico sagrado",
        ["esMX"] = "Crítico sagrado",
        ["ptBR"] = "Crítico sagrado"
    },
    ["Holy Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilig Trefferchancebonus",
        ["frFR"] = "Bonus de toucher du sacré",
        ["zhCN"] = "神圣命中加成",
        ["ruRU"] = "Меткость (свет)",
        ["esES"] = "Bonificación de golpe sagrado",
        ["esMX"] = "Bonificación de golpe sagrado",
        ["ptBR"] = "Bônus de acerto sagrado"
    },
    ["Holy Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilig Verfehlen",
        ["frFR"] = "Rater du sacré",
        ["zhCN"] = "神圣未命中",
        ["ruRU"] = "Сопротивление (свет)",
        ["esES"] = "Fallo sagrado",
        ["esMX"] = "Fallo sagrado",
        ["ptBR"] = "Erro sagrado"
    },
    ["Holy Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Heilig Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater du sacré (Niv. + 3)",
        ["zhCN"] = "神圣未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (свет) (+3 ур.)",
        ["esES"] = "Fallo sagrado (Niv. + 3)",
        ["esMX"] = "Fallo sagrado (Niv. + 3)",
        ["ptBR"] = "Erro sagrado (Nív. + 3)"
    },
    ["Nature Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Naturschaden",
        ["frFR"] = "Dégats de la nature",
        ["zhCN"] = "自然伤害",
        ["ruRU"] = "Природа",
        ["esES"] = "Daño de la naturaleza",
        ["esMX"] = "Daño de la naturaleza",
        ["ptBR"] = "Dano de natureza"
    },
    ["Nature Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Natur Kritisch",
        ["frFR"] = "Critique de la nature",
        ["zhCN"] = "自然暴击",
        ["ruRU"] = "Крит (природа)",
        ["esES"] = "Crítico de la naturaleza",
        ["esMX"] = "Crítico de la naturaleza",
        ["ptBR"] = "Crítico de natureza"
    },
    ["Nature Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Natur Trefferchancebonus",
        ["frFR"] = "Bonus de toucher de la nature",
        ["zhCN"] = "自然命中加成",
        ["ruRU"] = "Меткость (природа)",
        ["esES"] = "Bonificación de golpe de la naturaleza",
        ["esMX"] = "Bonificación de golpe de la naturaleza",
        ["ptBR"] = "Bônus de acerto de natureza"
    },
    ["Nature Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Natur Verfehlen",
        ["frFR"] = "Rater de la nature",
        ["zhCN"] = "自然未命中",
        ["ruRU"] = "Сопротивление (природа)",
        ["esES"] = "Fallo de la naturaleza",
        ["esMX"] = "Fallo de la naturaleza",
        ["ptBR"] = "Erro de natureza"
    },
    ["Nature Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Natur Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater de la nature (Niv. + 3)",
        ["zhCN"] = "自然未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (природа) (+3 ур.)",
        ["esES"] = "Fallo de la naturaleza (Niv. + 3)",
        ["esMX"] = "Fallo de la naturaleza (Niv. + 3)",
        ["ptBR"] = "Erro de natureza (Nív. + 3)"
    },
    ["Physical Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Physischer Schaden",
        ["frFR"] = "Dégats physiques",
        ["zhCN"] = "物理伤害",
        ["ruRU"] = "Физ. урон",
        ["esES"] = "Daño físico",
        ["esMX"] = "Daño físico",
        ["ptBR"] = "Dano físico"
    },
    ["Physical Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Physisch Kritisch",
        ["frFR"] = "Critique physique",
        ["zhCN"] = "物理暴击",
        ["ruRU"] = "Крит (физ.)",
        ["esES"] = "Crítico físico",
        ["esMX"] = "Crítico físico",
        ["ptBR"] = "Crítico físico"
    },
    ["Physical Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Physischer Trefferchancebonus",
        ["frFR"] = "Bonus de toucher physique",
        ["zhCN"] = "物理命中加成",
        ["ruRU"] = "Меткость (физ.)",
        ["esES"] = "Bonificación de golpe físico",
        ["esMX"] = "Bonificación de golpe físico",
        ["ptBR"] = "Bônus de acerto físico"
    },
    ["Physical Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Physisch Verfehlen",
        ["frFR"] = "Rater physique",
        ["zhCN"] = "物理未命中",
        ["ruRU"] = "Сопротивление (физ.)",
        ["esES"] = "Fallo físico",
        ["esMX"] = "Fallo físico",
        ["ptBR"] = "Erro físico"
    },
    ["Physical Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Physisch Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater physique (Niv. + 3)",
        ["zhCN"] = "物理未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (физ.) (+3 ур.)",
        ["esES"] = "Fallo físico (Niv. + 3)",
        ["esMX"] = "Fallo físico (Niv. + 3)",
        ["ptBR"] = "Erro físico (Nív. + 3)"
    },
    ["Shadow Damage"] = {
        ["enUS"] = true,
        ["deDE"] = "Schattenschaden",
        ["frFR"] = "Dégats des ombres",
        ["zhCN"] = "暗影伤害",
        ["ruRU"] = "Тьма",
        ["esES"] = "Daño de las sombras",
        ["esMX"] = "Daño de las sombras",
        ["ptBR"] = "Dano de sombra"
    },
    ["Shadow Crit"] = {
        ["enUS"] = true,
        ["deDE"] = "Schatten Kritisch",
        ["frFR"] = "Critique des ombres",
        ["zhCN"] = "暗影暴击",
        ["ruRU"] = "Крит (тьма)",
        ["esES"] = "Crítico de las sombras",
        ["esMX"] = "Crítico de las sombras",
        ["ptBR"] = "Crítico de sombra"
    },
    ["Shadow Hit Bonus"] = {
        ["enUS"] = true,
        ["deDE"] = "Schatten Trefferchancebonus",
        ["frFR"] = "Bonus de toucher des ombres",
        ["zhCN"] = "暗影命中加成",
        ["ruRU"] = "Меткость (тьма)",
        ["esES"] = "Bonificación de golpe de las sombras",
        ["esMX"] = "Bonificación de golpe de las sombras",
        ["ptBR"] = "Bônus de acerto de sombra"
    },
    ["Shadow Miss"] = {
        ["enUS"] = true,
        ["deDE"] = "Schatten Verfehlen",
        ["frFR"] = "Rater des ombres",
        ["zhCN"] = "暗影未命中",
        ["ruRU"] = "Сопротивление (тьма)",
        ["esES"] = "Fallo de las sombras",
        ["esMX"] = "Fallo de las sombras",
        ["ptBR"] = "Erro de sombra"
    },
    ["Shadow Miss (Lvl + 3)"] = {
        ["enUS"] = true,
        ["deDE"] = "Schatten Verfehlen (Lvl + 3)",
        ["frFR"] = "Rater des ombres (Niv. + 3)",
        ["zhCN"] = "暗影未命中（等级 + 3）",
        ["ruRU"] = "Сопрот. (тьма) (+3 ур.)",
        ["esES"] = "Fallo de las sombras (Niv. + 3)",
        ["esMX"] = "Fallo de las sombras (Niv. + 3)",
        ["ptBR"] = "Erro de sombra (Nív. + 3)"
    },
}

for k, v in pairs(statTranslations) do
    i18n.translations[k] = v
end
