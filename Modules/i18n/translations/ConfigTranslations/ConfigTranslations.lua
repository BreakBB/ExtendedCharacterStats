---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local configTranslations = {
    ["Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Einstellungen",
        ["frFR"] = "Paramètres",
        ["zhCN"] = "设置",
        ["ruRU"] = "Настройки",
        ["esES"] = "Configuración",
        ["esMX"] = "Configuración",
        ["ptBR"] = "Configurações"
    },
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
    ["Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte",
        ["frFR"] = "Statistiques",
        ["zhCN"] = "统计信息",
        ["ruRU"] = "Характеристики",
        ["esES"] = "Estadísticas",
        ["esMX"] = "Estadísticas",
        ["ptBR"] = "Estatísticas"
    },
    ["General Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Allgemeine Einstellungen",
        ["frFR"] = "Paramètres généraux",
        ["zhCN"] = "一般设置",
        ["ruRU"] = "Основные настройки",
        ["esES"] = "Configuración general",
        ["esMX"] = "Configuración general",
        ["ptBR"] = "Configurações gerais"
    },
    ["Hide ECS when opening character tab"] = {
        ["enUS"] = true,
        ["deDE"] = "Verstecke das ECS Fenster beim Öffnen des Charakterfensters",
        ["frFR"] = "Cacher ECS quand la fenêtre du personnage est ouverte",
        ["zhCN"] = "显示ECS切换按键",
        ["ruRU"] = "Скрывать ECS",
        ["esES"] = "Ocultar ECS al abrir la información del personaje",
        ["esMX"] = "Ocultar ECS al abrir la información del personaje",
        ["ptBR"] = "Ocultar ECS ao abrir as informações do personagem"
    },
    ["Hides the stats windows when opening the character tab."] = {
        ["enUS"] = true,
        ["deDE"] = "Versteckt das Wertefenster beim Öffnen des Charakterfensters.",
        ["frFR"] = "Cache la fenêtre des statistiques quand la section du personnage est ouverte.",
        ["zhCN"] = "显示ECS打开/关闭按键",
        ["ruRU"] = "Скрывает панель ECS при открытии окна персонажа",
        ["esES"] = "Oculta la ventana de estadísticas cuando abriendo la información del personaje",
        ["esMX"] = "Oculta la ventana de estadísticas cuando abriendo la información del personaje",
        ["ptBR"] = "Oculta as janelas de estatísticas ao abrir as informações do personagem"
    },
    ["Colorize Stats"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte färben",
        ["frFR"] = "Coloriser les statistiques",
        ["zhCN"] = "染色统计信息",
        ["ruRU"] = "Окрашивание характеристик",
        ["esES"] = "Colorear estadísticas",
        ["esMX"] = "Colorear estadísticas",
        ["ptBR"] = "Colorir estatísticas"
    },
    ["Adds colors to the stats overview."] = {
        ["enUS"] = true,
        ["deDE"] = "Fügt dem Wertefenster Farben hinzu.",
        ["frFR"] = "Ajoute des couleurs dans l'aperçu des statistiques.",
        ["zhCN"] = "添加颜色的统计概览。",
        ["ruRU"] = "Окрашивает характеристики в панели ECS",
        ["esES"] = "Añade colores a la vista de estadísticas",
        ["esMX"] = "Añade colores a la vista de estadísticas",
        ["ptBR"] = "Adiciona cores à visão geral das estatísticas"
    },
    ["Stats colorization"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Farbe",
        ["frFR"] = "Couleurs des statistiques",
        ["zhCN"] = "统计信息染色",
        ["ruRU"] = "Окрашивание характеристик",
        ["esES"] = "Colorización de estadísticas",
        ["esMX"] = "Colorización de estadísticas",
        ["ptBR"] = "Colorização das estatísticas"
    },
    ["Full"] = {
        ["enUS"] = true,
        ["deDE"] = "Komplett",
        ["frFR"] = "Toutes",
        ["zhCN"] = "全部",
        ["ruRU"] = "Полное",
        ["esES"] = "Lleno",
        ["esMX"] = "Lleno",
        ["ptBR"] = "Cheia"
    },
    ["Stat texts"] = {
        ["enUS"] = true,
        ["deDE"] = "Wertenamen",
        ["frFR"] = "Textes des statistiques",
        ["zhCN"] = "统计文本染色",
        ["ruRU"] = "Только текст",
        ["esES"] = "Textos de estadísticas",
        ["esMX"] = "Textos de estadísticas",
        ["ptBR"] = "Textos de estatísticas"
    },
    ["Stat values"] = {
        ["enUS"] = true,
        ["deDE"] = "Wertezahlen",
        ["frFR"] = "Valeurs des statistiques",
        ["zhCN"] = "属性染色",
        ["ruRU"] = "Только значения",
        ["esES"] = "Valores de estadísticas",
        ["esMX"] = "Valores de estadísticas",
        ["ptBR"] = "Valores das estatísticas"
    },
    ["Show Item Quality Colors"] = {
        ["enUS"] = true,
        ["deDE"] = "Zeige Item Qualitätsfarben",
        ["frFR"] = "Affiche la couleur de rareté des objets",
        ["zhCN"] = "显示物品等级颜色",
        ["ruRU"] = "Окрашивание предметов",
        ["esES"] = "Mostrar color de la calidad del objeto",
        ["esMX"] = "Mostrar color de la calidad del objeto",
        ["ptBR"] = "Mostrar cores de qualidade dos itens"
    },
    ["Shows/Hides the colored frames around equipped items."] = {
        ["enUS"] = true,
        ["deDE"] = "Zeigt/Versteckt die farbigen Ränder an ausgerüsteten Gegenständen.",
        ["frFR"] = "Affiche/cache le niveau de rareté des objets par un cadre coloré.",
        ["zhCN"] = "显示/隐藏 装备边框染色 。",
        ["ruRU"] = "Показать/скрыть цветную рамку вокруг надетых предметов в зависимости от их качества",
        ["esES"] = "Muestra/oculta los marcos coloreados alrededor de los objetos equipados",
        ["esMX"] = "Muestra/oculta los marcos coloreados alrededor de los objetos equipados",
        ["ptBR"] = "Mostra/oculta os quadros coloridos ao redor dos itens equipados"
    },
    ["Quality Colors' Intensity"] = {
        ["enUS"] = true,
        ["deDE"] = "Intensität der Qualitätsfarben",
        ["frFR"] = "Intensité des couleurs de qualité",
        ["zhCN"] = "優質顏色的強度",
        ["ruRU"] = "Интенсивность качественных цветов",
        ["esES"] = "Intensidad de los colores de calidad",
        ["esMX"] = "Intensidad de los colores de calidad",
        ["ptBR"] = "Intensidade das cores de qualidade"
    },
    ["Changes the intensity of the colored frames' glow."] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Intensität des Leuchtens der farbigen Rahmen.",
        ["frFR"] = "Modifie l'intensité de l'éclat des cadres colorés.",
        ["zhCN"] = "改变彩色边框的发光强度。",
        ["ruRU"] = "Изменяет интенсивность свечения цветных рамок.",
        ["esES"] = "Cambia la intensidad del brillo de los marcos coloreados.",
        ["esMX"] = "Cambia la intensidad del brillo de los marcos coloreados.",
        ["ptBR"] = "Altera a intensidade do brilho dos quadros coloridos."
    },
    ["Header Font Size"] = {
        ["enUS"] = true,
        ["deDE"] = "Überschriften Schriftgröße",
        ["frFR"] = "Taille de la police d'entête",
        ["zhCN"] = "标题字体大小",
        ["ruRU"] = "Размер шрифта заголовка",
        ["esES"] = "Tamaño de fuente del encabezado",
        ["esMX"] = "Tamaño de fuente del encabezado",
        ["ptBR"] = "Tamanho da fonte do cabeçalho"
    },
    ["Changes the font size of the headers (e.g. Melee)"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Schriftgröße der Überschriften (z.B. Nahkampf)",
        ["frFR"] = "Modifie la taille de la police d'entête (ex. Mêlée)",
        ["zhCN"] = "更改标题的字体大小 (例如：近战)",
        ["ruRU"] = "Изменяет размер шрифта заголовка (например, \"Ближний бой\")",
        ["esES"] = "Cambia el tamaño de fuente de los encabezados (p. ej., cuerpo a cuerpo)",
        ["esMX"] = "Cambia el tamaño de fuente de los encabezados (p. ej., cuerpo a cuerpo)",
        ["ptBR"] = "Altera o tamanho da fonte dos cabeçalhos (por exemplo, corpo a corpo)"
    },
    ["Stat Font Size"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Schriftgröße",
        ["frFR"] = "Taille de la police des statistiques",
        ["zhCN"] = "统计字体大小",
        ["ruRU"] = "Размер шрифта характеристик",
        ["esES"] = "Tamaño de fuente de estadística",
        ["esMX"] = "Tamaño de fuente de estadística",
        ["ptBR"] = "Tamanho da fonte das estatísticas"
    },
    ["Changes the font size of the stat lines (e.g. Crit)"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Schriftgröße der Werte (z.B. Kritische Chance)",
        ["frFR"] = "Modifie la taille de la police des statistiques (ex. Critique)",
        ["zhCN"] = "更改统计行的字体大小 (例如：暴击)",
        ["ruRU"] = "Изменяет размер шрифта характеристик (например, \"Крит\")",
        ["esES"] = "Cambia el tamaño de fuente de las líneas de estadísticas (p. ej., crítico)",
        ["esMX"] = "Cambia el tamaño de fuente de las líneas de estadísticas (p. ej., crítico)",
        ["ptBR"] = "Altera o tamanho da fonte das linhas de estatísticas (por exemplo, crítico)"
    },
    ["Window Width"] = {
        ["enUS"] = true,
        ["deDE"] = "Fensterbreite",
        ["frFR"] = "Largeur de fenêtre",
        ["zhCN"] = "窗口宽度",
        ["ruRU"] = "Ширина панели",
        ["esES"] = "Anchura de la ventana",
        ["esMX"] = "Anchura de la ventana",
        ["ptBR"] = "Largura da janela"
    },
    ["Changes the width of the stats window"] = {
        ["enUS"] = true,
        ["deDE"] = "Ändert die Breite des Wertefensters",
        ["frFR"] = "Modifie la largeur de la fenêtre des statistiques",
        ["zhCN"] = "更改统计窗口的宽度",
        ["ruRU"] = "Изменяет ширину панели ECS",
        ["esES"] = "Cambia la anchura de la ventana de estadísticas",
        ["esMX"] = "Cambia la anchura de la ventana de estadísticas",
        ["ptBR"] = "Altera a largura da janela de estatísticas"
    },
    ["Language"] = {
        ["enUS"] = true,
        ["deDE"] = "Sprache",
        ["frFR"] = "Langue",
        ["zhCN"] = "语言",
        ["ruRU"] = "Язык",
        ["esES"] = "Idioma",
        ["esMX"] = "Idioma",
        ["ptBR"] = "Idioma"
    },
    ["Stats Settings"] = {
        ["enUS"] = true,
        ["deDE"] = "Werte Einstellungen",
        ["frFR"] = "Paramètres des statistiques",
        ["zhCN"] = "统计信息设置",
        ["ruRU"] = "Настройки характеристик",
        ["esES"] = "Configuración de estadísticas",
        ["esMX"] = "Configuración de estadísticas",
        ["ptBR"] = "Configurações das estatísticas"
    },
    ["Reset ECS"] = {
        ["enUS"] = true,
        ["deDE"] = "ECS zurücksetzen",
        ["frFR"] = "Réinitialiser ECS",
        ["zhCN"] = false,
        ["ruRU"] = "Сброс настроек",
        ["esES"] = "Restablecer ECS",
        ["esMX"] = "Restablecer ECS",
        ["ptBR"] = "Resetar ECS"
    },
    ["Restores all default values of ECS."] = {
        ["enUS"] = true,
        ["deDE"] = "Stellt alle Standardwerte von ECS wieder her.",
        ["frFR"] = "Restaure toutes les valeurs par défaut de l'ECS.",
        ["zhCN"] = false,
        ["ruRU"] = "Сбрасывает настройки ECS на используемые по умолчанию. Это перезагрузит пользовательский интерфейс",
        ["esES"] = "Restablece todos los valores predeterminados de ECS",
        ["esMX"] = "Restablece todos los valores predeterminados de ECS",
        ["ptBR"] = "Restaura todos os valores padrão do ECS"
    },
}

for k, v in pairs(configTranslations) do
    i18n.translations[k] = v
end
