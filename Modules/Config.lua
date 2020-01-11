------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------
local _, core = ...
---@class ECSConfig
core.ECSConfig = {}
core.displayedStats = {}

local ECSConfig = core.ECSConfig

local ECSMainWindow
local settingsFrame

------------------------------------------------------------------
-- Defaults
------------------------------------------------------------------

-- Font for the header display
local headerFont = "GameFontNormal"

-- Font for the stat display
local statFont = "GameFontHighlightSmall"

------------------------------------------------------------------
-- Helper functions
------------------------------------------------------------------

-- Toggles the display of the window
-- if the window is hidden or closed, it will be displayed
-- if the window is visible, it will be hidden
local function Toggle()
    local menu = ECSMainWindow
    menu:SetShown(not menu:IsShown())
end

local function Config()
    settingsFrame:SetShown(not settingsFrame:IsShown())
end

function HandleSlash(msg)
    local cmd = string.lower(msg) or "help"

    if cmd == "toggle" then
        Toggle()

    elseif cmd == "config" then
        Config()

    else
        print("Available Commmands")
        print("/ecs toggle - Toggles the visibility of the GUI")
        print("/ecs config - Opens up the configuration window")
    end
end

------------------------------------------------------------------
-- Configuration Frame
------------------------------------------------------------------

local leftOffset = -30
local rightOffset = -30

function ECSConfig:CreateConfigWindow()

    -- Create Config Window
    settingsFrame = CreateFrame("Frame", "ECS_ConfigFrame", UIParent, "BasicFrameTemplateWithInset")
    settingsFrame:SetSize(350, 600) -- Width, Height
    settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    settingsFrame.title = settingsFrame:CreateFontString(nil, "OVERLAY")
    settingsFrame.title:SetFontObject("GameFontHighlight")
    settingsFrame.title:SetPoint("CENTER", settingsFrame.TitleBg, "CENTER", 5, 0)
    settingsFrame.title:SetText("Extended Character Stats Settings")
    settingsFrame:SetShown(false)

    -- Loop through all available items
    -- Display them as checkbox
    -- If checked it should be displayed
    -- If the header is unchecked, children will not be allowed to be displayed

    -- Melee
    -- ExtendedCharacterStats.profile.melee.display
    CreateMeleeOptions()

    -- Defense
    -- ExtendedCharacterStats.profile.defense.display
    CreateDefenseOptions()

    -- Regen
    -- ExtendedCharacterStats.profile.Regen.display
    CreateRegenOptions()

    -- Ranged
    -- ExtendedCharacterStats.profile.ranged.display
    CreateRangedOptions()

    -- Spell
    -- ExtendedCharacterStats.profile.spell.display
    CreateSpellOptions()

    -- SpellBonus
    -- ExtendedCharacterStats.profile.SpellBonus.display
    CreateSpellBonusOptions(rightOffset)

    local saveButton = CreateFrame("Button", nil, settingsFrame, "OptionsButtonTemplate")
    saveButton:SetPoint("BOTTOM", 0, 10) -- pos, y, x
    saveButton:SetSize(320, 40)
    saveButton:SetText("Apply")
    saveButton:SetScript("OnClick", function() ReloadUI() end)

    return settingsFrame
end

function CreateRangedOptions()

    -- Create Header Options
    local ShowRanged = CreateCheckBox(20, leftOffset, "Ranged", "TOPLEFT")
    leftOffset = leftOffset - 30
    ShowRanged:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.ranged.display = not ExtendedCharacterStats.profile.ranged.display
        local show = ExtendedCharacterStats.profile.ranged.display
        ShowRanged:SetChecked(show)
    end)

    ShowRanged:SetScript("OnUpdate", function()
        ShowRanged:SetChecked(ExtendedCharacterStats.profile.ranged.display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowRangedHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedHit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.ranged.hit.display = not ExtendedCharacterStats.profile.ranged.hit.display
        local show = ExtendedCharacterStats.profile.ranged.hit.display
        ShowRangedHit:SetChecked(show)
    end)

    ShowRangedHit:SetScript("OnUpdate", function()
        ShowRangedHit:SetChecked(ExtendedCharacterStats.profile.ranged.hit.display)
    end)

    -- Crit
    local ShowRangedCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.ranged.crit.display = not ExtendedCharacterStats.profile.ranged.crit.display
        local show = ExtendedCharacterStats.profile.ranged.crit.display
        ShowRangedCrit:SetChecked(show)
    end)

    ShowRangedCrit:SetScript("OnUpdate", function()
        ShowRangedCrit:SetChecked(ExtendedCharacterStats.profile.ranged.crit.display)
    end)
end

function CreateDefenseOptions()

    -- Create Header Options
    local ShowDefense = CreateCheckBox(20, leftOffset, "Defense", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowDefense:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.defense.display = not ExtendedCharacterStats.profile.defense.display
        local show = ExtendedCharacterStats.profile.defense.display
        ShowDefense:SetChecked(show)
    end)

    ShowDefense:SetScript("OnUpdate", function()
        ShowDefense:SetChecked(ExtendedCharacterStats.profile.defense.display)
    end)

    -- Create Sub-Header Options

    -- Dodge
    local ShowDodge = CreateCheckBox(40, leftOffset, "Dodge", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowDodge:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.defense.dodge.display = not ExtendedCharacterStats.profile.defense.dodge.display
        local show = ExtendedCharacterStats.profile.defense.dodge.display
        ShowDodge:SetChecked(show)
    end)

    ShowDodge:SetScript("OnUpdate", function()
        ShowDodge:SetChecked(ExtendedCharacterStats.profile.defense.dodge.display)
    end)

    -- Parry
    local ShowParry = CreateCheckBox(40, leftOffset, "Parry", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowParry:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.defense.parry.display = not ExtendedCharacterStats.profile.defense.parry.display
        local show = ExtendedCharacterStats.profile.defense.parry.display
        ShowParry:SetChecked(show)
    end)

    ShowParry:SetScript("OnUpdate", function()
        ShowParry:SetChecked(ExtendedCharacterStats.profile.defense.parry.display)
    end)

    -- Block
    local ShowBlock = CreateCheckBox(40, leftOffset, "Block", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowBlock:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.defense.block.display = not ExtendedCharacterStats.profile.defense.block.display
        local show = ExtendedCharacterStats.profile.defense.block.display
        ShowBlock:SetChecked(show)
    end)

    ShowBlock:SetScript("OnUpdate", function()
        ShowBlock:SetChecked(ExtendedCharacterStats.profile.defense.block.display)
    end)
end

function CreateMeleeOptions()

    -- Create Header Options
    local ShowMelee = CreateCheckBox(20, leftOffset, "Melee", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMelee:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.melee.display = not ExtendedCharacterStats.profile.melee.display
        local show = ExtendedCharacterStats.profile.melee.display
        ShowMelee:SetChecked(show)
    end)

    ShowMelee:SetScript("OnUpdate", function()
        ShowMelee:SetChecked(ExtendedCharacterStats.profile.melee.display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowMeleeHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeHit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.melee.hit.display = not ExtendedCharacterStats.profile.melee.hit.display
        local show = ExtendedCharacterStats.profile.melee.hit.display
        ShowMeleeHit:SetChecked(show)
    end)

    ShowMeleeHit:SetScript("OnUpdate", function()
        ShowMeleeHit:SetChecked(ExtendedCharacterStats.profile.melee.hit.display)
    end)

    -- Crit
    local ShowMeleeCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.melee.crit.display = not ExtendedCharacterStats.profile.melee.crit.display
        local show = ExtendedCharacterStats.profile.melee.crit.display
        ShowMeleeCrit:SetChecked(show)
    end)

    ShowMeleeCrit:SetScript("OnUpdate", function()
        ShowMeleeCrit:SetChecked(ExtendedCharacterStats.profile.melee.crit.display)
    end)
end

function CreateSpellOptions()

    -- Create Header Options
    local ShowSpell = CreateCheckBox(20, leftOffset, "Spell", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpell:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spell.display = not ExtendedCharacterStats.profile.spell.display
        local show = ExtendedCharacterStats.profile.spell.display
        ShowSpell:SetChecked(show)
    end)

    ShowSpell:SetScript("OnUpdate", function()
        ShowSpell:SetChecked(ExtendedCharacterStats.profile.spell.display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowSpellHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellHit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spell.hit.display = not ExtendedCharacterStats.profile.spell.hit.display
        local show = ExtendedCharacterStats.profile.spell.hit.display
        ShowSpellHit:SetChecked(show)
    end)

    ShowSpellHit:SetScript("OnUpdate", function()
        ShowSpellHit:SetChecked(ExtendedCharacterStats.profile.spell.hit.display)
    end)

    -- Crit
    local ShowSpellCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spell.crit.display = not ExtendedCharacterStats.profile.spell.crit.display
        local show = ExtendedCharacterStats.profile.spell.crit.display
        ShowSpellCrit:SetChecked(show)
    end)

    ShowSpellCrit:SetScript("OnUpdate", function()
        ShowSpellCrit:SetChecked(ExtendedCharacterStats.profile.spell.crit.display)
    end)
end

function CreateRegenOptions()

    -- Create Header Options
    local ShowRegen = CreateCheckBox(20, leftOffset, "Regen", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegen:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.regen.display = not ExtendedCharacterStats.profile.regen.display
        local show = ExtendedCharacterStats.profile.regen.display
        ShowRegen:SetChecked(show)
    end)

    ShowRegen:SetScript("OnUpdate", function()
        ShowRegen:SetChecked(ExtendedCharacterStats.profile.regen.display)
    end)

    -- Create Sub-Header Options

    -- Casting Regen
    -- local ShowRegenCasting = CreateCheckBox(40, leftOffset, "Casting", "TOPLEFT")
    -- leftOffset = leftOffset - 30

    -- ShowRegenCasting:SetScript("OnClick", function()
    --     ExtendedCharacterStats.profile.regen.mp5Casting.display = not ExtendedCharacterStats.profile.regen.mp5Casting.display
    --     local show = ExtendedCharacterStats.profile.regen.mp5Casting.display
    --     ShowRegenCasting:SetChecked(show)
    -- end)

    -- ShowRegenCasting:SetScript("OnUpdate", function()
    --     ShowRegenCasting:SetChecked(ExtendedCharacterStats.profile.regen.mp5Casting.display)
    -- end)

    -- Not Casting Regen
    local ShowRegenNotCasting = CreateCheckBox(40, leftOffset, "Not Casting", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenNotCasting:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.regen.mp5NotCasting.display = not ExtendedCharacterStats.profile.regen.mp5NotCasting.display
        local show = ExtendedCharacterStats.profile.regen.mp5NotCasting.display
        ShowRegenNotCasting:SetChecked(show)
    end)

    ShowRegenNotCasting:SetScript("OnUpdate", function()
        ShowRegenNotCasting:SetChecked(ExtendedCharacterStats.profile.regen.mp5NotCasting.display)
    end)

    -- Current Regen
    -- local ShowCurrentRegen = CreateCheckBox(40, leftOffset, "Current", "TOPLEFT")
    -- leftOffset = leftOffset - 30

    -- ShowCurrentRegen:SetScript("OnClick", function()
    --     ExtendedCharacterStats.profile.regen.mp5Current.display = not ExtendedCharacterStats.profile.regen.mp5Current.display
    --     local show = ExtendedCharacterStats.profile.regen.mp5Current.display
    --     ShowCurrentRegen:SetChecked(show)
    -- end)

    -- ShowCurrentRegen:SetScript("OnUpdate", function()
    --     ShowCurrentRegen:SetChecked(ExtendedCharacterStats.profile.regen.mp5Current.display)
    -- end)
end

function CreateSpellBonusOptions()

    -- Create Header Options
    local ShowSpellBonus = CreateCheckBox(-150, rightOffset, "Spell Bonus", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowSpellBonus:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.display = not ExtendedCharacterStats.profile.spellBonus.display
        local show = ExtendedCharacterStats.profile.spellBonus.display
        ShowSpellBonus:SetChecked(show)
    end)

    ShowSpellBonus:SetScript("OnUpdate", function()
        ShowSpellBonus:SetChecked(ExtendedCharacterStats.profile.spellBonus.display)
    end)

    -- Create Sub-Header Options
    local ShowPhysicalDmg = CreateCheckBox(-130, rightOffset, "Physical Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.physicalDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.physicalDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.physicalDmg.display
        ShowPhysicalDmg:SetChecked(show)
    end)

    ShowPhysicalDmg:SetScript("OnUpdate", function()
        ShowPhysicalDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.physicalDmg.display)
    end)

    local ShowPhysicalCrit = CreateCheckBox(-130, rightOffset, "Physical Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.physicalCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.physicalCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.physicalCrit.display
        ShowPhysicalCrit:SetChecked(show)
    end)

    ShowPhysicalCrit:SetScript("OnUpdate", function()
        ShowPhysicalCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.physicalCrit.display)
    end)

    local ShowArcaneDmg = CreateCheckBox(-130, rightOffset, "Arcane Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display
        ShowArcaneDmg:SetChecked(show)
    end)

    ShowArcaneDmg:SetScript("OnUpdate", function()
        ShowArcaneDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display)
    end)

    local ShowArcaneCrit = CreateCheckBox(-130, rightOffset, "Arcane Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display
        ShowArcaneCrit:SetChecked(show)
    end)

    ShowArcaneCrit:SetScript("OnUpdate", function()
        ShowArcaneCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display)
    end)

    local ShowNatureDmg = CreateCheckBox(-130, rightOffset, "Nature Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.natureDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.natureDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.natureDmg.display
        ShowNatureDmg:SetChecked(show)
    end)

    ShowNatureDmg:SetScript("OnUpdate", function()
        ShowNatureDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.natureDmg.display)
    end)

    local ShowNatureCrit = CreateCheckBox(-130, rightOffset, "Nature Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.natureCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.natureCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.natureCrit.display
        ShowNatureCrit:SetChecked(show)
    end)

    ShowNatureCrit:SetScript("OnUpdate", function()
        ShowNatureCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.natureCrit.display)
    end)

    local ShowHolyDmg = CreateCheckBox(-130, rightOffset, "Holy Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.holyDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.holyDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.holyDmg.display
        ShowHolyDmg:SetChecked(show)
    end)

    ShowHolyDmg:SetScript("OnUpdate", function()
        ShowHolyDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.holyDmg.display)
    end)

    local ShowHolyCrit = CreateCheckBox(-130, rightOffset, "Holy Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.holyCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.holyCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.holyCrit.display
        ShowHolyCrit:SetChecked(show)
    end)

    ShowHolyCrit:SetScript("OnUpdate", function()
        ShowHolyCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.holyCrit.display)
    end)

    local ShowFrostDmg = CreateCheckBox(-130, rightOffset, "Frost Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.frostDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.frostDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.frostDmg.display
        ShowFrostDmg:SetChecked(show)
    end)

    ShowFrostDmg:SetScript("OnUpdate", function()
        ShowFrostDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.frostDmg.display)
    end)

    local ShowFrostCrit = CreateCheckBox(-130, rightOffset, "Frost Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.frostCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.frostCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.frostCrit.display
        ShowFrostCrit:SetChecked(show)
    end)

    ShowFrostCrit:SetScript("OnUpdate", function()
        ShowFrostCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.frostCrit.display)
    end)

    local ShowFireDmg = CreateCheckBox(-130, rightOffset, "Fire Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.fireDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.fireDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.fireDmg.display
        ShowFireDmg:SetChecked(show)
    end)

    ShowFireDmg:SetScript("OnUpdate", function()
        ShowFireDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.fireDmg.display)
    end)

    local ShowFireCrit = CreateCheckBox(-130, rightOffset, "Fire Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.fireCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.fireCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.fireCrit.display
        ShowFireCrit:SetChecked(show)
    end)

    ShowFireCrit:SetScript("OnUpdate", function()
        ShowFireCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.fireCrit.display)
    end)

    local ShowShadowDmg = CreateCheckBox(-130, rightOffset, "Shadow Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.shadowDmg.display =
            not ExtendedCharacterStats.profile.spellBonus.shadowDmg.display
        local show = ExtendedCharacterStats.profile.spellBonus.shadowDmg.display
        ShowShadowDmg:SetChecked(show)
    end)

    ShowShadowDmg:SetScript("OnUpdate", function()
        ShowShadowDmg:SetChecked(ExtendedCharacterStats.profile.spellBonus.shadowDmg.display)
    end)

    local ShowShadowCrit = CreateCheckBox(-130, rightOffset, "Shadow Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.shadowCrit.display =
            not ExtendedCharacterStats.profile.spellBonus.shadowCrit.display
        local show = ExtendedCharacterStats.profile.spellBonus.shadowCrit.display
        ShowShadowCrit:SetChecked(show)
    end)

    ShowShadowCrit:SetScript("OnUpdate", function()
        ShowShadowCrit:SetChecked(ExtendedCharacterStats.profile.spellBonus.shadowCrit.display)
    end)

    local ShowBonusHealing = CreateCheckBox(-130, rightOffset, "Bonus Healing", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowBonusHealing:SetScript("OnClick", function()
        ExtendedCharacterStats.profile.spellBonus.bonusHealing.display =
            not ExtendedCharacterStats.profile.spellBonus.bonusHealing.display
        local show = ExtendedCharacterStats.profile.spellBonus.bonusHealing.display
        ShowBonusHealing:SetChecked(show)
    end)

    ShowBonusHealing:SetScript("OnUpdate", function()
        ShowBonusHealing:SetChecked(ExtendedCharacterStats.profile.spellBonus.bonusHealing.display)
    end)
end

function CreateCheckBox(yOffset, xOffset, text, position)
    local checkbox = CreateFrame("CheckButton", nil, settingsFrame, "UICheckButtonTemplate")
    checkbox:SetPoint(position, yOffset, xOffset)
    checkbox.text:SetText(text)
    return checkbox
end

------------------------------------------------------------------
-- Config functions
------------------------------------------------------------------

-- Creates the main frame for the application
function ECSConfig:CreateWindow()
    ECSMainWindow = CreateFrame("Frame", "ECS_StatsFrame", PaperDollItemsFrame, "BasicFrameTemplateWithInset")
    ECSMainWindow:SetSize(ExtendedCharacterStats.windowSize.width, ExtendedCharacterStats.windowSize.height) -- Width, Height
    ECSMainWindow:SetPoint("RIGHT", PaperDollItemsFrame, "RIGHT", ExtendedCharacterStats.windowSize.xOffset,
                           ExtendedCharacterStats.windowSize.yOffset) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    ECSMainWindow.title = ECSMainWindow:CreateFontString(nil, "OVERLAY")
    ECSMainWindow.title:SetFontObject("GameFontHighlight")
    ECSMainWindow.title:SetPoint("CENTER", ECSMainWindow.TitleBg, "CENTER", 5, 0)
    ECSMainWindow.title:SetText("Extended Character Stats " .. core.Utils:GetAddonVersionString())

    ECSMainWindow.configButton = CreateFrame("Button", nil, ECSMainWindow, "GameMenuButtonTemplate")
    ECSMainWindow.configButton:SetText("Settings")
    -- ECSMainWindow.configButton:SetNormalFontObject("GameFontNormalLarge")
    ECSMainWindow.configButton:SetSize(ExtendedCharacterStats.windowSize.width - 10, 20)
    ECSMainWindow.configButton:SetPoint("CENTER", ECSMainWindow, "TOP", -1, -35)
    ECSMainWindow.configButton:SetScript("OnClick", function ()
        Config()
    end)

    ECSMainWindow.ScrollFrame = CreateFrame("ScrollFrame", nil, ECSMainWindow, "UIPanelScrollFrameTemplate")
    ECSMainWindow.ScrollFrame:SetPoint("TOPLEFT", ECSMainWindow, "TOPLEFT", -35, -50)
    ECSMainWindow.ScrollFrame:SetPoint("BOTTOMRIGHT", ECSMainWindow, "BOTTOMRIGHT", -35, 10)

    ECSMainWindow.ScrollChild = CreateFrame("Frame", nil, ECSMainWindow.ScrollFrame)
    ECSMainWindow.ScrollChild:SetSize(ExtendedCharacterStats.windowSize.width, ExtendedCharacterStats.windowSize.height)
    ECSMainWindow.ScrollFrame:SetScrollChild(ECSMainWindow.ScrollChild)

    local function _CreateStatInfo(category)
        if category.display then
            ECSConfig:CreateHeader(category.refName, category.text)

            -- Loop through all stats
            for _, stat in pairs(category) do
                if type(stat) == "table" and stat.display == true then
                    -- Create the item
                    ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
                end
            end
        end
    end

    local category = ExtendedCharacterStats.profile.melee
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.hit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.crit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    category = ExtendedCharacterStats.profile.ranged
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.hit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.crit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    category = ExtendedCharacterStats.profile.defense
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.block
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.parry
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.dodge
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    category = ExtendedCharacterStats.profile.regen
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.mp5NotCasting
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    category = ExtendedCharacterStats.profile.spell
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.hit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.crit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    category = ExtendedCharacterStats.profile.spellBonus
    if category.display then
        ECSConfig:CreateHeader(category.refName, category.text)
        local stat = category.bonusHealing
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.arcaneDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.arcaneCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.fireDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.fireCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.frostDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.frostCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.holyDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.holyCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.natureDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.natureCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.physicalDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.physicalCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.shadowDmg
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
        stat = category.shadowCrit
        if stat.display then
            ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
        end
    end

    ECSConfig:CreateConfigWindow()

    return ECSMainWindow
end

local lastYOffset = 20

-- Creates a new header on the UI
function ECSConfig:CreateHeader(name, displayText)
    lastYOffset = lastYOffset - 20
    local newHeader = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", headerFont)
    newHeader:SetPoint("TOPLEFT", 50, lastYOffset)
    newHeader:SetText(displayText)
    core.displayedStats[name] = newHeader
end

-- Creates a new information text on the UI
function ECSConfig:CreateText(name, displayText)
    lastYOffset = lastYOffset - 15
    local newStat = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", statFont)
    newStat:SetPoint("TOPLEFT", 60, lastYOffset)
    newStat:SetText(displayText)
    core.displayedStats[name] = newStat
end

function ECSConfig:UpdateItem(refName, text)

    local stat = core.displayedStats[refName]
    if stat then
        stat:SetText(text)
    end
end

--- Read the loaded profile and update all enabled elements
function ECSConfig:UpdateInformation()
    print("[ECSConfig:UpdateInformation]")

    -- Loop through all categories
    for _, category in pairs(ExtendedCharacterStats.profile) do
        if category.display == true then

            -- Loop through all stats
            for _, stat in pairs(category) do
                if type(stat) == "table" and stat.display == true then
                    ECSConfig:UpdateItem(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
                end
            end
        end
    end
end

-- Slash Command for toggling the display
SLASH_ECS1 = "/ecs"
SlashCmdList["ECS"] = HandleSlash
