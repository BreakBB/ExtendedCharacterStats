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
local _CreateStatInfos, _CreateStatInfo, _CreateHeader, _CreateText, _FormatStatsText
local _UpdateStats, _UpdateItem

local colors = Utils.colors
local framePool = {}
local lastYOffset = 20
local engravingFrameHooked = false
------------------------------------------------------------------


--- Creates the main frame for the Stats window
function Stats.CreateWindow()
    local ecs = ExtendedCharacterStats

    local mainFrame = CreateFrame("Frame", "ECS_StatsFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset")
    mainFrame:SetSize(ecs.general.window.width, ecs.general.window.height) -- Width, Height
    mainFrame:SetPoint("LEFT", PaperDollItemsFrame, "RIGHT", ecs.general.window.xOffset, ecs.general.window.yOffset)
    mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
    mainFrame.title:SetFontObject("GameFontHighlight")
    mainFrame.title:SetPoint("CENTER", mainFrame.TitleBg, "CENTER", 11,  0)
    mainFrame.title:SetText(i18n("ECS %s", Utils:GetAddonVersionString()))

    mainFrame.configButton = CreateFrame("Button", nil, mainFrame, "GameMenuButtonTemplate")
    mainFrame.configButton:SetText(i18n("Settings"))
    mainFrame.configButton:SetSize(ecs.general.window.width - 10, 20)
    mainFrame.configButton:SetPoint("CENTER", mainFrame, "TOP", -1,  -35)
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
    -- Move to old position if Leatrix Plus durability button is active. See #20
    if (LeaPlusDB and LeaPlusDB["DurabilityStatus"] == "On") or PawnInitialize then
        if OutfitterButton then -- See #89
            toggleButton:SetPoint("TOPRIGHT", PaperDollItemsFrame, "TOPRIGHT", -55, -16)
        else
            toggleButton:SetPoint("TOPRIGHT", PaperDollItemsFrame, "TOPRIGHT", -57, -16)
        end
    else
        toggleButton:SetPoint("BOTTOMRIGHT", PaperDollItemsFrame, "BOTTOMRIGHT", -38, 87)
    end
    toggleButton:SetScript("OnClick", function ()
        Stats:ToggleWindow()
    end)

    mainFrame:SetScript("OnShow", function ()
        toggleButton:SetText("< ECS")
        if OutfitterFrame ~= nil and OutfitterButtonFrame ~= nil then
            OutfitterFrame:SetPoint("TOPLEFT", OutfitterButtonFrame  , "TOPRIGHT", -34 + ExtendedCharacterStats.general.window.width, -38)
        end
        Stats.UpdateInformation()
    end)
    mainFrame:SetScript("OnHide", function ()
        toggleButton:SetText("ECS >")
        if OutfitterFrame ~= nil and OutfitterButtonFrame ~= nil then
            OutfitterFrame:SetPoint("TOPLEFT", OutfitterButtonFrame  , "TOPRIGHT", -34, -38)
        end
    end)

    PaperDollItemsFrame:HookScript("OnShow", function()
        if ExtendedCharacterStats.general.statsWindowClosedOnOpen then
            Stats:HideWindow()
        end

        if ECS.IsSoD then
            -- next frame
            C_Timer.After(0, function ()
                if EngravingFrame then
                    if EngravingFrame:IsShown() then
                        mainFrame:ClearAllPoints()
                        mainFrame:SetPoint("LEFT", EngravingFrame, "RIGHT", 10, 19)
                    end

                    if (not engravingFrameHooked) then
                        EngravingFrame:HookScript("OnShow", function ()
                            mainFrame:ClearAllPoints()
                            mainFrame:SetPoint("LEFT", EngravingFrame, "RIGHT", 10, 19)
                        end)
                        EngravingFrame:HookScript("OnHide", function ()
                            mainFrame:ClearAllPoints()
                            mainFrame:SetPoint("LEFT", PaperDollItemsFrame, "RIGHT", ecs.general.window.xOffset, ecs.general.window.yOffset)
                        end)
                        engravingFrameHooked = true
                    end
                end
            end)
        end
    end)

    _CreateStatInfos()
    Config.CreateWindow()
end

function Stats:UpdateWindowSize()
    _Stats.frame:SetSize(ExtendedCharacterStats.general.window.width, ExtendedCharacterStats.general.window.height)
    _Stats.frame.configButton:SetSize(ExtendedCharacterStats.general.window.width- 10, 20)
end

function Stats:UpdateSettingsButtonText()
    _Stats.frame.configButton:SetText(i18n("Settings"))
end

--- Toogles the stats window
function Stats:ToggleWindow()
    local toggleButton = _G["ECS_ToggleButton"]
    if (not toggleButton) then
        error("ECS Toggle Button could not be found")
        return
    end

    _Stats.frame:SetShown(not _Stats.frame:IsShown())
end

function Stats:HideWindow()
    local toggleButton = _G["ECS_ToggleButton"]
    if (not toggleButton) then
        error("ECS Toggle Button could not be found")
        return
    end
    _Stats.frame:SetShown(false)
end

function Stats:ShowWindow()
    _Stats.frame:SetShown(true)
end

function Stats:GetFrame()
    return _Stats.frame
end

---@return table<string, StatsHeader|StatsText>
function Stats:GetDisplayedLines()
    return _Stats.displayedLines
end

--- Helper function to iterate all field of a given category and create them if they should be displayed
---@param category Category|SubCategory
_CreateStatInfo = function(category, ...)
    if (not ECS.IsWotlk) and category.isTbcOnly then
        return
    end

    if category.display then
        _CreateHeader(category.refName, i18n(category.text), category.isSubGroup)
        local stats = {...}
        -- Loop through all stats
        for _, stat in pairs(stats) do
            if type(stat) == "table" and stat.display and ((not stat.isTbcOnly) or ECS.IsWotlk) then
                _CreateText(stat.refName, _FormatStatsText(stat), category.isSubGroup)
            end
        end
    end
end

---@param stat StatsEntry
_FormatStatsText = function(stat)
    local statText = i18n(stat.text) .. ": "
    local statValue = Data.GetStatInfo(stat.refName)

    if (not ExtendedCharacterStats.general.addColorsToStatTexts) then
        return Utils.Colorize(statText, colors.GRAY) .. Utils.Colorize(statValue, colors.WHITE)
    end

    local textColor = stat.textColor or colors.DEFENSE_SECONDARY
    local statColor = stat.statColor or colors.DEFENSE_PRIMARY

    return Utils.Colorize(statText, textColor) .. Utils.Colorize(statValue, statColor)
end

--- Creates all categories with headers and their child values
_CreateStatInfos = function()
    local profile = ExtendedCharacterStats.profile

    local category = profile.general
    _CreateStatInfo(category, category.movementSpeed)

    category = profile.melee
    if ECS.IsWotlk then
        _CreateStatInfo(category, category.attackPower, category.crit, category.penetration, category.penetrationRating, category.expertise,
                category.expertiseRating, category.hasteRating, category.hasteBonus)
    else
        _CreateStatInfo(category, category.attackPower, category.crit)
    end
    if category.display then
        category = category.hit
        _CreateStatInfo(category, category.rating, category.bonus, category.sameLevel, category.bossLevel)

        if(ECS.IsClassic) then
            category = profile.melee.glance
            _CreateStatInfo(category, category.sameLevel, category.damageSameLevel, category.bossLevel,  category.damageBossLevel)
        end

        category = profile.melee.attackSpeed
        _CreateStatInfo(category, category.mainHand, category.offHand)
    end

    category = profile.ranged
    if ECS.IsWotlk then
        _CreateStatInfo(category, category.attackPower, category.crit, category.penetration, category.penetrationRating,
                category.hasteRating, category.hasteBonus, category.attackSpeed)
    else
        _CreateStatInfo(category, category.attackPower, category.crit, category.attackSpeed)
    end

    if category.display then
        category = category.hit
        _CreateStatInfo(category, category.rating, category.bonus, category.sameLevel, category.bossLevel)
    end

    category = profile.defense
    _CreateStatInfo(category, category.armor, category.meleeCritReduction, category.rangedCritReduction, category.spellCritReduction, category.avoidance, category.avoidanceBoss,
            category.defenseRating, category.defense, category.blockChance, category.blockValue, category.parry, category.dodge, category.resilience)

    category = profile.regen
    _CreateStatInfo(category, category.mp5Items, category.mp5Spirit, category.mp5Buffs, category.mp5Casting, category.mp5NotCasting)

    category = profile.spell
    if ECS.IsWotlk then
        _CreateStatInfo(category, category.hasteRating, category.hasteBonus, category.penetration)

        if category.display then
            category = category.hit
            _CreateStatInfo(category, category.rating, category.bonus, category.sameLevel, category.bossLevel)
        end

        category = profile.spellBonus
        local spell = profile.spell
        local spellCrit = spell.crit
        _CreateStatInfo(
                category,
                category.bonusHealing,
                spell.arcane.display and category.arcaneDmg or nil,
                spell.arcane.display and spellCrit.arcane or nil,
                spell.fire.display and category.fireDmg or nil,
                spell.fire.display and spellCrit.fire or nil,
                spell.frost.display and category.frostDmg or nil,
                spell.frost.display and spellCrit.frost or nil,
                spell.holy.display and category.holyDmg or nil,
                spell.holy.display and spellCrit.holy or nil,
                spell.nature.display and category.natureDmg or nil,
                spell.nature.display and spellCrit.nature or nil,
                spell.physical.display and category.physicalDmg or nil,
                spell.physical.display and spellCrit.physical or nil,
                spell.shadow.display and category.shadowDmg or nil,
                spell.shadow.display and spellCrit.shadow or nil
        )
    else
        local spellBonus = profile.spellBonus
        local spell = profile.spell
        local spellCrit = spell.crit
        local spellHit = spell.hit
        _CreateStatInfo(
                category,
                category.penetration,
                spellBonus.bonusHealing,
                spell.arcane.display and spellBonus.arcaneDmg or nil,
                spell.arcane.display and spellCrit.display and spellCrit.arcane or nil,
                spell.arcane.display and spellHit.bonus.display and spellHit.arcaneHitBonus or nil,
                spell.arcane.display and spellHit.sameLevel.display and spellHit.arcaneMissChance or nil,
                spell.arcane.display and spellHit.bossLevel.display and spellHit.arcaneMissChanceBoss or nil,
                spell.fire.display and spellBonus.fireDmg or nil,
                spell.fire.display and spellCrit.display and spellCrit.fire or nil,
                spell.fire.display and spellHit.bonus.display and spellHit.fireHitBonus or nil,
                spell.fire.display and spellHit.sameLevel.display and spellHit.fireMissChance or nil,
                spell.fire.display and spellHit.bossLevel.display and spellHit.fireMissChanceBoss or nil,
                spell.frost.display and spellBonus.frostDmg or nil,
                spell.frost.display and spellCrit.display and spellCrit.frost or nil,
                spell.frost.display and spellHit.bonus.display and spellHit.frostHitBonus or nil,
                spell.frost.display and spellHit.sameLevel.display and spellHit.frostMissChance or nil,
                spell.frost.display and spellHit.bossLevel.display and spellHit.frostMissChanceBoss or nil,
                spell.holy.display and spellBonus.holyDmg or nil,
                spell.holy.display and spellCrit.display and spellCrit.holy or nil,
                spell.holy.display and spellHit.bonus.display and spellHit.holyHitBonus or nil,
                spell.holy.display and spellHit.sameLevel.display and spellHit.holyMissChance or nil,
                spell.holy.display and spellHit.bossLevel.display and spellHit.holyMissChanceBoss or nil,
                spell.nature.display and spellBonus.natureDmg or nil,
                spell.nature.display and spellCrit.display and spellCrit.nature or nil,
                spell.nature.display and spellHit.bonus.display and spellHit.natureHitBonus or nil,
                spell.nature.display and spellHit.sameLevel.display and spellHit.natureMissChance or nil,
                spell.nature.display and spellHit.bossLevel.display and spellHit.natureMissChanceBoss or nil,
                spell.physical.display and spellBonus.physicalDmg or nil,
                spell.physical.display and spellCrit.display and spellCrit.physical or nil,
                spell.physical.display and spellHit.bonus.display and spellHit.physicalHitBonus or nil,
                spell.physical.display and spellHit.sameLevel.display and spellHit.physicalMissChance or nil,
                spell.physical.display and spellHit.bossLevel.display and spellHit.physicalMissChanceBoss or nil,
                spell.shadow.display and spellBonus.shadowDmg or nil,
                spell.shadow.display and spellCrit.display and spellCrit.shadow or nil,
                spell.shadow.display and spellHit.bonus.display and spellHit.shadowHitBonus or nil,
                spell.shadow.display and spellHit.sameLevel.display and spellHit.shadowMissChance or nil,
                spell.shadow.display and spellHit.bossLevel.display and spellHit.shadowMissChanceBoss or nil
        )
    end
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
    header:SetPoint("TOPLEFT", xOffSet,  lastYOffset)
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
    stat:SetPoint("TOPLEFT", xOffSet,  lastYOffset)
    stat:SetText(displayText)
    stat:SetFont(STANDARD_TEXT_FONT,  ExtendedCharacterStats.general.statFontSize)
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
function Stats.RebuildStatInfos()
    local stats = _Stats.displayedLines
    lastYOffset = 20

    for _, entry in pairs(stats) do
        Stats:RecycleFrame(entry)
    end

    _Stats.displayedLines = {}
    _CreateStatInfos()
end

--- Read the loaded profile and update all enabled elements
function Stats.UpdateInformation()

    -- Loop through all categories
    for _, category in pairs(ExtendedCharacterStats.profile) do
        if category and category.display then
            -- Loop through all stats
            _UpdateStats(category)
        end
    end
end

--- Updates all existing stats of a given category
---@param category Category|SubCategory
_UpdateStats = function(category)
    for _, stat in pairs(category) do
        if type(stat) == "table" then
            if stat.isSubGroup then
                for _, subStat in pairs(stat) do
                    if type(subStat) == "table" and subStat.display then
                        _UpdateItem(subStat.refName, _FormatStatsText(subStat))
                    end
                end
            elseif stat.display and stat.refName and stat.text then
                _UpdateItem(stat.refName, _FormatStatsText(stat))
            elseif stat.display then
                _UpdateStats(stat)
            end
        end
    end
end

--- Updates a single existing stat value
---@param refName string
---@param text string
_UpdateItem = function(refName, text)
    local stats = _Stats.displayedLines

    local stat = stats[refName]
    if stat then
        stat:SetText(text)
    end
end
