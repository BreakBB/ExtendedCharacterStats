------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------
local _, core = ...
core.ECSConfig = {}
core.DisplayItems = {}

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

local function GetDefaultProfile()
    return {

        Defense = {
            Display = true,
            RefName = "DefenseHeader",
            Text = "Defense",

            Block = {Display = true, RefName = "BlockChance", Text = "Block: "},

            Parry = {Display = true, RefName = "ParryChance", Text = "Parry: "},

            Dodge = {Display = true, RefName = "DodgeChance", Text = "Dodge: "}
        },

        Regen = {
            Display = true,
            RefName = "ManaHeader",
            Text = "Mana",

            MP5Casting = {Display = true, RefName = "MP5Casting", Text = "MP5 (Casting): "},

            MP5NotCasting = {Display = true, RefName = "MP5NotCasting", Text = "MP5 (Not Casting): "},

            MP5Current = {Display = true, RefName = "MP5Current", Text = "MP5: "}
        },

        Melee = {
            Display = true,
            RefName = "MeleeHeader",
            Text = "Melee",

            Hit = {Display = true, RefName = "MeleeHit", Text = "Hit Modifier: "},

            Crit = {Display = true, RefName = "MeleeCritChance", Text = "Crit: "}
        },

        Ranged = {
            Display = true,
            RefName = "RangedHeader",
            Text = "Ranged",

            Hit = {Display = true, RefName = "RangedHit", Text = "Hit Modifier: "},

            Crit = {Display = true, RefName = "RangedCritChance", Text = "Crit: "}
        },

        Spell = {
            Display = true,
            RefName = "SpellHeader",
            Text = "Spell",

            Hit = {Display = true, RefName = "SpellHit", Text = "Hit Modifier: "},

            Crit = {Display = true, RefName = "SpellCritChance", Text = "Crit: "}
        },

        SpellBonus = {
            Display = true,
            RefName = "SpellBonusHeader",
            Text = "Spell Bonus",

            BonusHealing = {Display = true, RefName = "BonusHealing", Text = "Bonus Healing: "},

            ShadowDmg = {Display = true, RefName = "ShadowDmg", Text = "Shadow Damage: "},

            ShadowCrit = {Display = true, RefName = "ShadowCritChance", Text = "Shadow Crit: "},

            HolyDmg = {Display = true, RefName = "HolyDmg", Text = "Holy Damage: "},

            HolyCrit = {Display = true, RefName = "HolyCritChance", Text = "Holy Crit: "},

            FireDmg = {Display = true, RefName = "FireDmg", Text = "Fire Damage: "},

            FireCrit = {Display = true, RefName = "FireCritChance", Text = "Fire Crit: "},

            FrostDmg = {Display = true, RefName = "FrostDmg", Text = "Frost Damage: "},

            FrostCrit = {Display = true, RefName = "FrostCritChance", Text = "Frost Crit: "},

            ArcaneDmg = {Display = true, RefName = "ArcaneDmg", Text = "Arcane Damage: "},

            ArcaneCrit = {Display = true, RefName = "ArcaneCritChance", Text = "Arcane Crit: "},

            NatureDmg = {Display = true, RefName = "NatureDmg", Text = "Nature Damage: "},

            NatureCrit = {Display = true, RefName = "NatureCritChance", Text = "Nature Crit: "},

            PhysicalDmg = {Display = true, RefName = "PhysicalDmg", Text = "Physical Damage: "},

            PhysicalCrit = {Display = true, RefName = "PhysicalCritChance", Text = "Physical Crit: "}
        }
    }
end

function ECSConfig:GetProfileData()
    -- core.ECSConfig.currentProfile = GetDefaultProfile();
    return ExtendedCharacterStats.Profile or GetDefaultProfile()
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
    settingsFrame.title:SetText("Extended Character Stats Configuration")
    settingsFrame:SetShown(false)

    -- Loop through all available items
    -- Display them as checkbox
    -- If checked it should be displayed
    -- If the header is unchecked, children will not be allowed to be displayed

    -- Ranged
    -- ExtendedCharacterStats.Profile.Ranged.Display
    CreateRangedOptions()

    -- Defense
    -- ExtendedCharacterStats.Profile.Defense.Display
    CreateDefenseOptions()

    -- Melee
    -- ExtendedCharacterStats.Profile.Melee.Display
    CreateMeleeOptions()

    -- Spell
    -- ExtendedCharacterStats.Profile.Spell.Display
    CreateSpellOptions()

    -- Regen
    -- ExtendedCharacterStats.Profile.Regen.Display
    CreateRegenOptions()

    -- SpellBonus
    -- ExtendedCharacterStats.Profile.SpellBonus.Display
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
        ExtendedCharacterStats.Profile.Ranged.Display = not ExtendedCharacterStats.Profile.Ranged.Display
        local show = ExtendedCharacterStats.Profile.Ranged.Display
        ShowRanged:SetChecked(show)
    end)

    ShowRanged:SetScript("OnUpdate", function()
        ShowRanged:SetChecked(ExtendedCharacterStats.Profile.Ranged.Display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowRangedHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedHit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Ranged.Hit.Display = not ExtendedCharacterStats.Profile.Ranged.Hit.Display
        local show = ExtendedCharacterStats.Profile.Ranged.Hit.Display
        ShowRangedHit:SetChecked(show)
    end)

    ShowRangedHit:SetScript("OnUpdate", function()
        ShowRangedHit:SetChecked(ExtendedCharacterStats.Profile.Ranged.Hit.Display)
    end)

    -- Crit
    local ShowRangedCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Ranged.Crit.Display = not ExtendedCharacterStats.Profile.Ranged.Crit.Display
        local show = ExtendedCharacterStats.Profile.Ranged.Crit.Display
        ShowRangedCrit:SetChecked(show)
    end)

    ShowRangedCrit:SetScript("OnUpdate", function()
        ShowRangedCrit:SetChecked(ExtendedCharacterStats.Profile.Ranged.Crit.Display)
    end)
end

function CreateDefenseOptions()

    -- Create Header Options
    local ShowDefense = CreateCheckBox(20, leftOffset, "Defense", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowDefense:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Defense.Display = not ExtendedCharacterStats.Profile.Defense.Display
        local show = ExtendedCharacterStats.Profile.Defense.Display
        ShowDefense:SetChecked(show)
    end)

    ShowDefense:SetScript("OnUpdate", function()
        ShowDefense:SetChecked(ExtendedCharacterStats.Profile.Defense.Display)
    end)

    -- Create Sub-Header Options

    -- Dodge
    local ShowDodge = CreateCheckBox(40, leftOffset, "Dodge", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowDodge:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Defense.Dodge.Display = not ExtendedCharacterStats.Profile.Defense.Dodge.Display
        local show = ExtendedCharacterStats.Profile.Defense.Dodge.Display
        ShowDodge:SetChecked(show)
    end)

    ShowDodge:SetScript("OnUpdate", function()
        ShowDodge:SetChecked(ExtendedCharacterStats.Profile.Defense.Dodge.Display)
    end)

    -- Parry
    local ShowParry = CreateCheckBox(40, leftOffset, "Parry", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowParry:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Defense.Parry.Display = not ExtendedCharacterStats.Profile.Defense.Parry.Display
        local show = ExtendedCharacterStats.Profile.Defense.Parry.Display
        ShowParry:SetChecked(show)
    end)

    ShowParry:SetScript("OnUpdate", function()
        ShowParry:SetChecked(ExtendedCharacterStats.Profile.Defense.Parry.Display)
    end)

    -- Block
    local ShowBlock = CreateCheckBox(40, leftOffset, "Block", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowBlock:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Defense.Block.Display = not ExtendedCharacterStats.Profile.Defense.Block.Display
        local show = ExtendedCharacterStats.Profile.Defense.Block.Display
        ShowBlock:SetChecked(show)
    end)

    ShowBlock:SetScript("OnUpdate", function()
        ShowBlock:SetChecked(ExtendedCharacterStats.Profile.Defense.Block.Display)
    end)
end

function CreateMeleeOptions()

    -- Create Header Options
    local ShowMelee = CreateCheckBox(20, leftOffset, "Melee", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMelee:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Melee.Display = not ExtendedCharacterStats.Profile.Melee.Display
        local show = ExtendedCharacterStats.Profile.Melee.Display
        ShowMelee:SetChecked(show)
    end)

    ShowMelee:SetScript("OnUpdate", function()
        ShowMelee:SetChecked(ExtendedCharacterStats.Profile.Melee.Display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowMeleeHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeHit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Melee.Hit.Display = not ExtendedCharacterStats.Profile.Melee.Hit.Display
        local show = ExtendedCharacterStats.Profile.Melee.Hit.Display
        ShowMeleeHit:SetChecked(show)
    end)

    ShowMeleeHit:SetScript("OnUpdate", function()
        ShowMeleeHit:SetChecked(ExtendedCharacterStats.Profile.Melee.Hit.Display)
    end)

    -- Crit
    local ShowMeleeCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Melee.Crit.Display = not ExtendedCharacterStats.Profile.Melee.Crit.Display
        local show = ExtendedCharacterStats.Profile.Melee.Crit.Display
        ShowMeleeCrit:SetChecked(show)
    end)

    ShowMeleeCrit:SetScript("OnUpdate", function()
        ShowMeleeCrit:SetChecked(ExtendedCharacterStats.Profile.Melee.Crit.Display)
    end)
end

function CreateSpellOptions()

    -- Create Header Options
    local ShowSpell = CreateCheckBox(20, leftOffset, "Spell", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpell:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Spell.Display = not ExtendedCharacterStats.Profile.Spell.Display
        local show = ExtendedCharacterStats.Profile.Spell.Display
        ShowSpell:SetChecked(show)
    end)

    ShowSpell:SetScript("OnUpdate", function()
        ShowSpell:SetChecked(ExtendedCharacterStats.Profile.Spell.Display)
    end)

    -- Create Sub-Header Options

    -- Hit
    local ShowSpellHit = CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellHit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Spell.Hit.Display = not ExtendedCharacterStats.Profile.Spell.Hit.Display
        local show = ExtendedCharacterStats.Profile.Spell.Hit.Display
        ShowSpellHit:SetChecked(show)
    end)

    ShowSpellHit:SetScript("OnUpdate", function()
        ShowSpellHit:SetChecked(ExtendedCharacterStats.Profile.Spell.Hit.Display)
    end)

    -- Crit
    local ShowSpellCrit = CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Spell.Crit.Display = not ExtendedCharacterStats.Profile.Spell.Crit.Display
        local show = ExtendedCharacterStats.Profile.Spell.Crit.Display
        ShowSpellCrit:SetChecked(show)
    end)

    ShowSpellCrit:SetScript("OnUpdate", function()
        ShowSpellCrit:SetChecked(ExtendedCharacterStats.Profile.Spell.Crit.Display)
    end)
end

function CreateRegenOptions()

    -- Create Header Options
    local ShowRegen = CreateCheckBox(20, leftOffset, "Regen", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegen:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Regen.Display = not ExtendedCharacterStats.Profile.Regen.Display
        local show = ExtendedCharacterStats.Profile.Regen.Display
        ShowRegen:SetChecked(show)
    end)

    ShowRegen:SetScript("OnUpdate", function()
        ShowRegen:SetChecked(ExtendedCharacterStats.Profile.Regen.Display)
    end)

    -- Create Sub-Header Options

    -- Casting Regen
    local ShowRegenCasting = CreateCheckBox(40, leftOffset, "Casting", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenCasting:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Regen.MP5Casting.Display = not ExtendedCharacterStats.Profile.Regen.MP5Casting.Display
        local show = ExtendedCharacterStats.Profile.Regen.MP5Casting.Display
        ShowRegenCasting:SetChecked(show)
    end)

    ShowRegenCasting:SetScript("OnUpdate", function()
        ShowRegenCasting:SetChecked(ExtendedCharacterStats.Profile.Regen.MP5Casting.Display)
    end)

    -- Not Casting Regen
    local ShowRegenNotCasting = CreateCheckBox(40, leftOffset, "Not Casting", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenNotCasting:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Regen.MP5NotCasting.Display = not ExtendedCharacterStats.Profile.Regen.MP5NotCasting.Display
        local show = ExtendedCharacterStats.Profile.Regen.MP5NotCasting.Display
        ShowRegenNotCasting:SetChecked(show)
    end)

    ShowRegenNotCasting:SetScript("OnUpdate", function()
        ShowRegenNotCasting:SetChecked(ExtendedCharacterStats.Profile.Regen.MP5NotCasting.Display)
    end)

    -- Current Regen
    local ShowCurrentRegen = CreateCheckBox(40, leftOffset, "Current", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowCurrentRegen:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.Regen.MP5Current.Display = not ExtendedCharacterStats.Profile.Regen.MP5Current.Display
        local show = ExtendedCharacterStats.Profile.Regen.MP5Current.Display
        ShowCurrentRegen:SetChecked(show)
    end)

    ShowCurrentRegen:SetScript("OnUpdate", function()
        ShowCurrentRegen:SetChecked(ExtendedCharacterStats.Profile.Regen.MP5Current.Display)
    end)
end

function CreateSpellBonusOptions()

    -- Create Header Options
    local ShowSpellBonus = CreateCheckBox(-150, rightOffset, "Spell Bonus", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowSpellBonus:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.Display = not ExtendedCharacterStats.Profile.SpellBonus.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.Display
        ShowSpellBonus:SetChecked(show)
    end)

    ShowSpellBonus:SetScript("OnUpdate", function()
        ShowSpellBonus:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.Display)
    end)

    -- Create Sub-Header Options
    local ShowPhysicalDmg = CreateCheckBox(-130, rightOffset, "Physical Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.PhysicalDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.PhysicalDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.PhysicalDmg.Display
        ShowPhysicalDmg:SetChecked(show)
    end)

    ShowPhysicalDmg:SetScript("OnUpdate", function()
        ShowPhysicalDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.PhysicalDmg.Display)
    end)

    local ShowPhysicalCrit = CreateCheckBox(-130, rightOffset, "Physical Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.PhysicalCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.PhysicalCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.PhysicalCrit.Display
        ShowPhysicalCrit:SetChecked(show)
    end)

    ShowPhysicalCrit:SetScript("OnUpdate", function()
        ShowPhysicalCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.PhysicalCrit.Display)
    end)

    local ShowArcaneDmg = CreateCheckBox(-130, rightOffset, "Arcane Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.ArcaneDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.ArcaneDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.ArcaneDmg.Display
        ShowArcaneDmg:SetChecked(show)
    end)

    ShowArcaneDmg:SetScript("OnUpdate", function()
        ShowArcaneDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.ArcaneDmg.Display)
    end)

    local ShowArcaneCrit = CreateCheckBox(-130, rightOffset, "Arcane Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.ArcaneCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.ArcaneCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.ArcaneCrit.Display
        ShowArcaneCrit:SetChecked(show)
    end)

    ShowArcaneCrit:SetScript("OnUpdate", function()
        ShowArcaneCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.ArcaneCrit.Display)
    end)

    local ShowNatureDmg = CreateCheckBox(-130, rightOffset, "Nature Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.NatureDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.NatureDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.NatureDmg.Display
        ShowNatureDmg:SetChecked(show)
    end)

    ShowNatureDmg:SetScript("OnUpdate", function()
        ShowNatureDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.NatureDmg.Display)
    end)

    local ShowNatureCrit = CreateCheckBox(-130, rightOffset, "Nature Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.NatureCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.NatureCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.NatureCrit.Display
        ShowNatureCrit:SetChecked(show)
    end)

    ShowNatureCrit:SetScript("OnUpdate", function()
        ShowNatureCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.NatureCrit.Display)
    end)

    local ShowHolyDmg = CreateCheckBox(-130, rightOffset, "Holy Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.HolyDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.HolyDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.HolyDmg.Display
        ShowHolyDmg:SetChecked(show)
    end)

    ShowHolyDmg:SetScript("OnUpdate", function()
        ShowHolyDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.HolyDmg.Display)
    end)

    local ShowHolyCrit = CreateCheckBox(-130, rightOffset, "Holy Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.HolyCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.HolyCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.HolyCrit.Display
        ShowHolyCrit:SetChecked(show)
    end)

    ShowHolyCrit:SetScript("OnUpdate", function()
        ShowHolyCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.HolyCrit.Display)
    end)

    local ShowFrostDmg = CreateCheckBox(-130, rightOffset, "Frost Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.FrostDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.FrostDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.FrostDmg.Display
        ShowFrostDmg:SetChecked(show)
    end)

    ShowFrostDmg:SetScript("OnUpdate", function()
        ShowFrostDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.FrostDmg.Display)
    end)

    local ShowFrostCrit = CreateCheckBox(-130, rightOffset, "Frost Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.FrostCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.FrostCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.FrostCrit.Display
        ShowFrostCrit:SetChecked(show)
    end)

    ShowFrostCrit:SetScript("OnUpdate", function()
        ShowFrostCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.FrostCrit.Display)
    end)

    local ShowFireDmg = CreateCheckBox(-130, rightOffset, "Fire Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.FireDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.FireDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.FireDmg.Display
        ShowFireDmg:SetChecked(show)
    end)

    ShowFireDmg:SetScript("OnUpdate", function()
        ShowFireDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.FireDmg.Display)
    end)

    local ShowFireCrit = CreateCheckBox(-130, rightOffset, "Fire Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.FireCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.FireCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.FireCrit.Display
        ShowFireCrit:SetChecked(show)
    end)

    ShowFireCrit:SetScript("OnUpdate", function()
        ShowFireCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.FireCrit.Display)
    end)

    local ShowShadowDmg = CreateCheckBox(-130, rightOffset, "Shadow Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowDmg:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.ShadowDmg.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.ShadowDmg.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.ShadowDmg.Display
        ShowShadowDmg:SetChecked(show)
    end)

    ShowShadowDmg:SetScript("OnUpdate", function()
        ShowShadowDmg:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.ShadowDmg.Display)
    end)

    local ShowShadowCrit = CreateCheckBox(-130, rightOffset, "Shadow Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowCrit:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.ShadowCrit.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.ShadowCrit.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.ShadowCrit.Display
        ShowShadowCrit:SetChecked(show)
    end)

    ShowShadowCrit:SetScript("OnUpdate", function()
        ShowShadowCrit:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.ShadowCrit.Display)
    end)

    local ShowBonusHealing = CreateCheckBox(-130, rightOffset, "Bonus Healing", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowBonusHealing:SetScript("OnClick", function()
        ExtendedCharacterStats.Profile.SpellBonus.BonusHealing.Display =
            not ExtendedCharacterStats.Profile.SpellBonus.BonusHealing.Display
        local show = ExtendedCharacterStats.Profile.SpellBonus.BonusHealing.Display
        ShowBonusHealing:SetChecked(show)
    end)

    ShowBonusHealing:SetScript("OnUpdate", function()
        ShowBonusHealing:SetChecked(ExtendedCharacterStats.Profile.SpellBonus.BonusHealing.Display)
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
    ECSMainWindow:SetSize(ExtendedCharacterStats.WindowSize.Width, ExtendedCharacterStats.WindowSize.Height) -- Width, Height
    ECSMainWindow:SetPoint("RIGHT", PaperDollItemsFrame, "RIGHT", ExtendedCharacterStats.WindowSize.xOffset,
                           ExtendedCharacterStats.WindowSize.yOffset) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    ECSMainWindow.title = ECSMainWindow:CreateFontString(nil, "OVERLAY")
    ECSMainWindow.title:SetFontObject("GameFontHighlight")
    ECSMainWindow.title:SetPoint("CENTER", ECSMainWindow.TitleBg, "CENTER", 5, 0)
    ECSMainWindow.title:SetText("Extended Character Stats " .. core.Utils:GetAddonVersionString())

    ECSMainWindow.ScrollFrame = CreateFrame("ScrollFrame", nil, ECSMainWindow, "UIPanelScrollFrameTemplate")
    ECSMainWindow.ScrollFrame:SetPoint("TOPLEFT", ECSMainWindow, "TOPLEFT", -35, -30)
    ECSMainWindow.ScrollFrame:SetPoint("BOTTOMRIGHT", ECSMainWindow, "BOTTOMRIGHT", -35, 10)

    ECSMainWindow.ScrollChild = CreateFrame("Frame", nil, ECSMainWindow.ScrollFrame)
    ECSMainWindow.ScrollChild:SetSize(ExtendedCharacterStats.WindowSize.Width, ExtendedCharacterStats.WindowSize.Height)
    ECSMainWindow.ScrollFrame:SetScrollChild(ECSMainWindow.ScrollChild)

    -- Read the loaded profile and create elements from that
    for a, b in pairs(ExtendedCharacterStats.Profile) do
        -- Looping through profile
        -- Create the Headers

        if (b.Display == true) then
            ECSConfig:CreateHeader(b.RefName, b.Text)
        end

        if type(b) == "table" and b.Display == true then
            -- Loop through all sub items

            for c, d in pairs(b) do

                -- If item is table
                if type(d) == "table" then

                    -- Check if item should be created
                    if d.Display == true then
                        -- Create the item
                        ECSConfig:CreateText(d.RefName, d.Text .. core.ECSData:GetStatInfo(d.RefName))
                    end
                end
            end
        end
    end

    ECSConfig:CreateConfigWindow()

    return ECSMainWindow
end

-- Gets the yOffset of the last item in the displayitems array
function ECSConfig:GetLastItemPosition()
    local lastY = nil

    for k, v in pairs(core.DisplayItems) do
        _, _, _, _, lastY = v:GetPoint()
    end

    return lastY
end

-- Creates a new header on the UI
function ECSConfig:CreateHeader(name, displayText)
    local yOffset = ECSConfig:GetLastItemPosition() or 10
    yOffset = yOffset - 20
    local newHeader = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", headerFont)
    newHeader:SetPoint("TOPLEFT", 50, yOffset)
    newHeader:SetText(displayText)
    table.insert(core.DisplayItems, newHeader)
end

-- Creates a new information text on the UI
function ECSConfig:CreateText(name, displayText)
    local yOffset = ECSConfig:GetLastItemPosition() or 0
    yOffset = yOffset - 15
    local newStat = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", statFont)
    newStat:SetPoint("TOPLEFT", 60, yOffset)
    newStat:SetText(displayText)
    table.insert(core.DisplayItems, newStat)
end

function ECSConfig:UpdateItem(refName, text)

    for k, v in pairs(core.DisplayItems) do
        if (v:GetName() == refName) then
            v:SetText(text)
        end
    end
end

-- Update all the displayed information
function ECSConfig:UpdateInformation()

    -- Read the loaded profile and update elements enabled
    for a, b in pairs(ExtendedCharacterStats.Profile) do
        -- Looping through profile

        if type(b) == "table" and b.Display == true then
            -- Loop through all sub items

            for c, d in pairs(b) do

                -- If item is table
                if type(d) == "table" then

                    -- Check if item is displayed
                    if d.Display == true then
                        ECSConfig:UpdateItem(d.RefName, d.Text .. core.ECSData:GetStatInfo(d.RefName))
                    end
                end
            end
        end
    end
end

-- Slash Command for toggling the display
SLASH_ECS1 = "/ecs"
SlashCmdList["ECS"] = HandleSlash
