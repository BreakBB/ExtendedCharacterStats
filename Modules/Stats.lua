------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Stats
local Stats = ECSLoader:CreateModule("Stats")
local _Stats = Stats.private
_Stats.displayedLines = {}

---@type i18n
local i18n = ECSLoader:CreateModule("i18n")
---@type Config
local Config = ECSLoader:ImportModule("Config")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")
---@type Data
local Data = ECSLoader:ImportModule("Data")

------------------------------------------------------------------
-- Defaults
------------------------------------------------------------------

-- Font for the header display
local headerFont = "GameFontNormal"

-- Font for the stat display
local statFont = "GameFontHighlightSmall"

-- Forward declaration
local _CreateStatInfos, _CreateHeader, _CreateText

local framePool = {}
local lastYOffset = 20
------------------------------------------------------------------


--- Creates the main frame for the Stats window
function Stats:CreateWindow()
    local ecs = ExtendedCharacterStats

    local mainFrame = CreateFrame("Frame", "ECS_StatsFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset")
    mainFrame:SetSize(ecs.general.window.width, ecs.general.window.height) -- Width, Height
    mainFrame:SetPoint("LEFT", PaperDollItemsFrame, "RIGHT", ecs.general.window.xOffset, ecs.general.window.yOffset) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
    mainFrame.title:SetFontObject("GameFontHighlight")
    mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 11, 0)
    mainFrame.title:SetText(i18n("NAME_VERSION", Utils:GetAddonVersionString()))

    mainFrame.configButton = CreateFrame("Button", nil, mainFrame, "GameMenuButtonTemplate")
    mainFrame.configButton:SetText(i18n("SETTINGS"))
    mainFrame.configButton:SetSize(ecs.general.window.width - 10, 20)
    mainFrame.configButton:SetPoint("CENTER", mainFrame, "TOP", -1, -35)
    mainFrame.configButton:SetScript("OnClick", function ()
        ECSConfigFrame:SetShown(not ECSConfigFrame:IsShown())
    end)

    mainFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, mainFrame, "UIPanelScrollFrameTemplate")
    mainFrame.ScrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", -35, -50)
    mainFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -35, 10)

    mainFrame.ScrollChild = CreateFrame("Frame", nil, mainFrame.ScrollFrame)
    mainFrame.ScrollChild:SetSize(ecs.general.window.width, ecs.general.window.height)
    mainFrame.ScrollFrame:SetScrollChild(mainFrame.ScrollChild)
    _Stats.frame = mainFrame

    local toggleButton = CreateFrame("Button", "ECS_ToggleButton", CharacterModelFrame, "GameMenuButtonTemplate")
    toggleButton:SetText("< ECS")
    toggleButton:SetSize(44, 18)
    if (_G.LeaPlusDB and _G.LeaPlusDB["DurabilityStatus"] == "On") -- Move to old position if Leatrix Plus durability button is active. See #20
        or PawnInitialize then -- Pawn is loaded
        toggleButton:SetPoint("TOPRIGHT", PaperDollItemsFrame, "TOPRIGHT", -38, -43)
    else
        toggleButton:SetPoint("BOTTOMRIGHT", PaperDollItemsFrame, "BOTTOMRIGHT", -38, 87)
    end
    toggleButton:SetScript("OnClick", function ()
        Stats:ToggleWindow()
        if _Stats.frame:IsShown() then
           toggleButton:SetText("< ECS")
        else
            toggleButton:SetText("ECS >")
        end
    end)

    _CreateStatInfos()
    Config:CreateWindow()
end

function Stats:UpdateWindowSize()
    _Stats.frame:SetSize(ExtendedCharacterStats.general.window.width, ExtendedCharacterStats.general.window.height)
    _Stats.frame.configButton:SetSize(ExtendedCharacterStats.general.window.width- 10, 20)
end

function Stats:UpdateSettingsButtonText()
    _Stats.frame.configButton:SetText(i18n("SETTINGS"))
end

--- Toogles the stats window
function Stats:ToggleWindow()
    _Stats.frame:SetShown(not _Stats.frame:IsShown())
end

function Stats:GetFrame()
    return _Stats.frame
end

---@return table<string, StatsHeader|StatsText>
function Stats:GetDisplayedLines()
    return _Stats.displayedLines
end

--- Helper function to iteracte all field of a given category and create them if they should be displayed
---@param category Category|SubCategory
_CreateStatInfo = function(category, ...)
    if category.display == true then
        _CreateHeader(category.refName, i18n(category.text), category.isSubGroup)
        local stats = {...}
        -- Loop through all stats
        for _, stat in pairs(stats) do
            if type(stat) == "table" and stat.display == true then
                _CreateText(stat.refName, i18n(stat.text) .. Data:GetStatInfo(stat.refName), category.isSubGroup)
            end
        end
    end
end

--- Creates all categories with headers and they child values
_CreateStatInfos = function()
    local profile = ExtendedCharacterStats.profile

    local category = profile.melee
    _CreateStatInfo(category, category.attackPower, category.crit)
    if category.display then
        category = category.hit
        _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)
    end

    category = profile.ranged
    _CreateStatInfo(category, category.attackPower, category.crit)
    if category.display then
        category = category.hit
        _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)
    end

    category = profile.defense
    _CreateStatInfo(category, category.armor, category.defense, category.blockChance, category.blockValue, category.parry, category.dodge)

    category = profile.regen
    _CreateStatInfo(category, category.mp5Items, category.mp5Spirit, category.mp5Casting)

    category = profile.spell
    _CreateStatInfo(category, category.crit)
    if category.display then
        category = category.hit
        _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)
    end

    category = profile.spellBonus
    _CreateStatInfo(
        category, category.bonusHealing, category.arcaneDmg, category.arcaneCrit, category.fireDmg,
        category.fireCrit, category.frostDmg, category.frostCrit, category.holyDmg,
        category.holyCrit, category.natureDmg, category.natureCrit, category.physicalDmg,
        category.physicalCrit, category.shadowDmg, category.shadowCrit
    )
end

--- Creates a new header in the stats UI
---@param name string
---@param displayText string
---@param isSubHeader boolean
_CreateHeader = function(name, displayText, isSubHeader)
    local xOffSet = 49
    if isSubHeader then
        xOffSet = 56
    end
    lastYOffset = lastYOffset - 20
    ---@class StatsHeader
    local header = table.remove(framePool)
    if not header then
        header = _Stats.frame.ScrollChild:CreateFontString(name, "OVERLAY", headerFont)
    else
        header:SetFontObject(headerFont)
    end
    header:SetPoint("TOPLEFT", xOffSet, lastYOffset)
    header:SetText(displayText)
    header:SetFont(STANDARD_TEXT_FONT, ExtendedCharacterStats.general.headerFontSize)
    header:Show()
    _Stats.displayedLines[name] = header
end

--- Creates a new value in the stats UI
---@param name string
---@param displayText string
---@param isSubText boolean
_CreateText = function(name, displayText, isSubText)
    local xOffSet = 56
    if isSubText then
        xOffSet = 62
    end

    lastYOffset = lastYOffset - 15
    ---@class StatsText
    local stat = table.remove(framePool)
    if not stat then
        stat = _Stats.frame.ScrollChild:CreateFontString(name, "OVERLAY", statFont)
    else
        stat:SetFontObject(statFont)
    end
    stat:SetPoint("TOPLEFT", xOffSet, lastYOffset)
    stat:SetText(displayText)
    stat:SetFont(STANDARD_TEXT_FONT, ExtendedCharacterStats.general.statFontSize)
    stat:Show()
    _Stats.displayedLines[name] = stat
end

--- Recycles an existing frame to be reused for the next stat/header
---@param frame StatsHeader|StatsText
function Stats:RecycleFrame(frame)
    frame:Hide()
    table.insert(framePool, frame)
end

--- Resets the Y-Offset and rebuilds the displayed frames
function Stats:RebuildStatInfos()
    local stats = _Stats.displayedLines
    lastYOffset = 20

    for _, entry in pairs(stats) do
        Stats:RecycleFrame(entry)
    end

    _Stats.displayedLines = {}
    _CreateStatInfos()
end

--- Updates a single existing stat value
---@param refName string
---@param text string
local function _UpdateItem(refName, text)
    local stats = _Stats.displayedLines

    local stat = stats[refName]
    if stat then
        stat:SetText(text)
    end
end

--- Updates all existing stats of a given category
---@param category Category|SubCategory
local function _UpdateStats(category)
    for _, stat in pairs(category) do
        if type(stat) == "table" then
            if stat.isSubGroup then
                for _, subStat in pairs(stat) do
                    if type(subStat) == "table" and subStat.display == true then
                        _UpdateItem(subStat.refName, i18n(subStat.text) .. Data:GetStatInfo(subStat.refName))
                    end
                end
            elseif stat.display == true then
                _UpdateItem(stat.refName, i18n(stat.text) .. Data:GetStatInfo(stat.refName))
            end
        end
    end
end

--- Read the loaded profile and update all enabled elements
function Stats:UpdateInformation()

    -- Loop through all categories
    for _, category in pairs(ExtendedCharacterStats.profile) do
        if category and category.display == true then
            -- Loop through all stats
            _UpdateStats(category)
        end
    end
end