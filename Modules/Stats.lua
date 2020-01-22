------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Stats
local Stats = ECSLoader:CreateModule("Stats")
local _Stats = Stats.private
_Stats.displayedLines = {}

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


local framePool = {}
local lastYOffset = 20
------------------------------------------------------------------


-- Creates the main frame for the application
function Stats:CreateWindow()
    local mainFrame = CreateFrame("Frame", "ECS_StatsFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset")
    mainFrame:SetSize(ExtendedCharacterStats.windowSize.width, ExtendedCharacterStats.windowSize.height) -- Width, Height
    mainFrame:SetPoint("RIGHT", PaperDollItemsFrame, "RIGHT", ExtendedCharacterStats.windowSize.xOffset,
                           ExtendedCharacterStats.windowSize.yOffset) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
    mainFrame.title:SetFontObject("GameFontHighlight")
    mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 5, 0)
    mainFrame.title:SetText("Extended Character Stats " .. Utils:GetAddonVersionString())

    mainFrame.configButton = CreateFrame("Button", nil, mainFrame, "GameMenuButtonTemplate")
    mainFrame.configButton:SetText("Settings")
    mainFrame.configButton:SetSize(ExtendedCharacterStats.windowSize.width - 10, 20)
    mainFrame.configButton:SetPoint("CENTER", mainFrame, "TOP", -1, -35)
    mainFrame.configButton:SetScript("OnClick", function ()
        Config:ToggleWindow()
    end)

    mainFrame.ScrollFrame = CreateFrame("ScrollFrame", nil, mainFrame, "UIPanelScrollFrameTemplate")
    mainFrame.ScrollFrame:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", -35, -50)
    mainFrame.ScrollFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", -35, 10)

    mainFrame.ScrollChild = CreateFrame("Frame", nil, mainFrame.ScrollFrame)
    mainFrame.ScrollChild:SetSize(ExtendedCharacterStats.windowSize.width, ExtendedCharacterStats.windowSize.height)
    mainFrame.ScrollFrame:SetScrollChild(mainFrame.ScrollChild)
    _Stats.frame = mainFrame

    local toggleButton = CreateFrame("Button", "ECS_ToggleButton", CharacterModelFrame, "GameMenuButtonTemplate")
    toggleButton:SetText("ECS")
    toggleButton:SetSize(33, 16)
    toggleButton:SetPoint("BOTTOMRIGHT", CharacterModelFrame, "BOTTOMRIGHT", 0, 10)
    toggleButton:SetScript("OnClick", function ()
        Stats:ToggleWindow()
    end)

    Stats:CreateStatInfos()
    Config:CreateWindow()
end

function Stats:ToggleWindow()
    _Stats.frame:SetShown(not _Stats.frame:IsShown())
end

function Stats:GetDisplayedLines()
    return _Stats.displayedLines
end

---@return boolean @True if any stat of the child is displayed, false otherwise
local function _IsAnyChildDisplayed(child)
    local anyDisplayed = false

    for _, stat in pairs(child) do
        if type(stat) == "table" and stat.display == true then
            anyDisplayed = true
        end
    end

    return anyDisplayed
end

local function _CreateStatInfo(category, ...)
    if category.display == true then
        local header = Stats:CreateHeader(category.refName, category.text, category.isSubGroup)
        local anyStatDisplayed = false
        local stats = {...}
        -- Loop through all stats
        for _, stat in pairs(stats) do
            if type(stat) == "table" and stat.display == true then
                anyStatDisplayed = true
                Stats:CreateText(stat.refName, stat.text .. Data:GetStatInfo(stat.refName), category.isSubGroup)
            end
        end

        if (not anyStatDisplayed) and ((category.hit == nil) or (not _IsAnyChildDisplayed(category.hit))) then
            Stats:RecycleFrame(header)
            lastYOffset = lastYOffset + 20
            -- header:Hide()
        end
    end
end

function Stats:CreateStatInfos()
    local profile = ExtendedCharacterStats.profile

    local category = profile.melee
    _CreateStatInfo(category, category.crit)
    category = category.hit
    _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)

    category = profile.ranged
    _CreateStatInfo(category, category.crit)
    category = category.hit
    _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)

    category = profile.defense
    _CreateStatInfo(category, category.block, category.parry, category.dodge)

    category = profile.regen
    _CreateStatInfo(category, category.mp5Items, category.mp5Spirit, category.mp5Casting)

    category = profile.spell
    _CreateStatInfo(category, category.crit)
    category = category.hit
    _CreateStatInfo(category, category.bonus, category.sameLevel, category.bossLevel)

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
---@return StatsHeader
function Stats:CreateHeader(name, displayText, isSubHeader)
    local xOffSet = 50
    if isSubHeader then
        xOffSet = 60
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
    header:Show()
    _Stats.displayedLines[name] = header

    return header
end

-- Creates a new information text on the UI
function Stats:CreateText(name, displayText, isSubText)
    local xOffSet = 60
    if isSubText then
        xOffSet = 70
    end
    lastYOffset = lastYOffset - 15
    local stat = table.remove(framePool)
    if not stat then
        stat = _Stats.frame.ScrollChild:CreateFontString(name, "OVERLAY", statFont)
    else
        stat:SetFontObject(statFont)
    end
    stat:SetPoint("TOPLEFT", xOffSet, lastYOffset)
    stat:SetText(displayText)
    stat:Show()
    _Stats.displayedLines[name] = stat
end

function Stats:RecycleFrame(frame)
    frame:Hide()
    table.insert(framePool, frame)
end

function Stats:RebuildStatInfos()
    local stats = _Stats.displayedLines
    lastYOffset = 20

    for _, entry in pairs(stats) do
        entry:Hide()
    end

    Stats:CreateStatInfos()
end

function Stats:UpdateItem(refName, text)
    local stats = _Stats.displayedLines

    local stat = stats[refName]
    if stat then
        stat:SetText(text)
    end
end

local function _UpdateStats(category)
    for _, stat in pairs(category) do
        if type(stat) == "table" then
            if stat.isSubGroup then
                for _, subStat in pairs(stat) do
                    if type(subStat) == "table" and subStat.display == true then
                        Stats:UpdateItem(subStat.refName, subStat.text .. Data:GetStatInfo(subStat.refName))
                    end
                end
            elseif stat.display == true then
                Stats:UpdateItem(stat.refName, stat.text .. Data:GetStatInfo(stat.refName))
            end
        end
    end
end

--- Read the loaded profile and update all enabled elements
function Stats:UpdateInformation()

    -- Loop through all categories
    for _, category in pairs(ExtendedCharacterStats.profile) do
        if category.display == true then
            -- Loop through all stats
            _UpdateStats(category)
        end
    end
end