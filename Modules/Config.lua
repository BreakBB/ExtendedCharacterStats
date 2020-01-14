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
local function _ToggleMainWindow()
    ECSMainWindow:SetShown(not ECSMainWindow:IsShown())
end

local function _ToggleConfigWindow()
    settingsFrame:SetShown(not settingsFrame:IsShown())
end

local function _HandleSlash(msg)
    local cmd = string.lower(msg) or "help"

    if cmd == "toggle" then
        _ToggleMainWindow()

    elseif cmd == "config" then
        _ToggleConfigWindow()

    else
        print("Available Commmands")
        print("/ecs toggle - Toggles the visibility of the GUI")
        print("/ecs config - Opens up the configuration window")
    end
end

-- Slash Command for toggling the display
SLASH_ECS1 = "/ecs"
SlashCmdList["ECS"] = _HandleSlash

------------------------------------------------------------------
-- Configuration Frame
------------------------------------------------------------------

local leftOffset = -30
local rightOffset = -30

function ECSConfig:CreateConfigWindow()

    -- Create Config Window
    settingsFrame = CreateFrame("Frame", "ECS_ConfigFrame", UIParent, "BasicFrameTemplateWithInset")
    table.insert(UISpecialFrames, settingsFrame:GetName())
    settingsFrame:SetSize(350, 600) -- Width, Height
    settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    settingsFrame:Hide()
    settingsFrame.title = settingsFrame:CreateFontString(nil, "OVERLAY")
    settingsFrame.title:SetFontObject("GameFontHighlight")
    settingsFrame.title:SetPoint("CENTER", settingsFrame.TitleBg, "CENTER", 5, 0)
    settingsFrame.title:SetText("Extended Character Stats Settings")

    -- Melee
    -- ExtendedCharacterStats.profile.melee
    ECSConfig:CreateMeleeOptions()

    -- Ranged
    -- ExtendedCharacterStats.profile.ranged
    ECSConfig:CreateRangedOptions()

    -- Defense
    -- ExtendedCharacterStats.profile.defense
    ECSConfig:CreateDefenseOptions()

    -- Regen
    -- ExtendedCharacterStats.profile.regen
    ECSConfig:CreateRegenOptions()

    -- Spell
    -- ExtendedCharacterStats.profile.spell
    ECSConfig:CreateSpellOptions()

    -- SpellBonus
    -- ExtendedCharacterStats.profile.SpellBonus
    ECSConfig:CreateSpellBonusOptions()

    local saveButton = CreateFrame("Button", nil, settingsFrame, "OptionsButtonTemplate")
    saveButton:SetPoint("BOTTOM", 0, 10) -- pos, y, x
    saveButton:SetSize(320, 40)
    saveButton:SetText("Close")
    saveButton:SetScript("OnClick", function()
        settingsFrame:Hide()
    end)

    return settingsFrame
end

local function _CreateCheckBox(yOffset, xOffset, text, position)
    local checkbox = CreateFrame("CheckButton", nil, settingsFrame, "UICheckButtonTemplate")
    checkbox:SetPoint(position, yOffset, xOffset)
    checkbox.text:SetText(text)
    return checkbox
end

function ECSConfig:CreateMeleeOptions()
    -- Create Header Options
    local ShowMelee = _CreateCheckBox(20, leftOffset, "Melee", "TOPLEFT")
    local ShowMeleeHitBonus, ShowMeleeMissSameLevel, ShowMeleeMissBossLevel, ShowMeleeCrit -- forward declaration
    leftOffset = leftOffset - 30
    local meleeProfile = ExtendedCharacterStats.profile.melee

    ShowMelee:SetScript("OnClick", function()
        local show = not meleeProfile.display
        ExtendedCharacterStats.profile.melee.display = show
        ExtendedCharacterStats.profile.melee.hit.display = show
        ShowMelee:SetChecked(show)
        ShowMeleeHitBonus:SetEnabled(show)
        ShowMeleeMissSameLevel:SetEnabled(show)
        ShowMeleeMissBossLevel:SetEnabled(show)
        ShowMeleeCrit:SetEnabled(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.bonus.refName])
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.sameLevel.refName])
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.bossLevel.refName])
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.crit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowMelee:SetChecked(meleeProfile.display)

    -- Create Sub-Header Options

    -- Hit Bonus
    ShowMeleeHitBonus = _CreateCheckBox(40, leftOffset, "Hit Bonus", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeHitBonus:SetScript("OnClick", function()
        local show = not meleeProfile.hit.bonus.display
        ExtendedCharacterStats.profile.melee.hit.bonus.display = show
        ShowMeleeHitBonus:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.bonus.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowMeleeHitBonus:SetChecked(meleeProfile.hit.bonus.display)

    -- Miss Chance (Same Level)
    ShowMeleeMissSameLevel = _CreateCheckBox(40, leftOffset, "Miss Chance", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeMissSameLevel:SetScript("OnClick", function()
        local show = not meleeProfile.hit.sameLevel.display
        ExtendedCharacterStats.profile.melee.hit.sameLevel.display = show
        ShowMeleeMissSameLevel:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.sameLevel.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowMeleeMissSameLevel:SetChecked(meleeProfile.hit.sameLevel.display)

    -- Miss Chance (Playerlevel + 3)
    ShowMeleeMissBossLevel = _CreateCheckBox(40, leftOffset, "Miss Chance (+3)", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeMissBossLevel:SetScript("OnClick", function()
        local show = not meleeProfile.hit.bossLevel.display
        ExtendedCharacterStats.profile.melee.hit.bossLevel.display = show
        ShowMeleeMissBossLevel:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.hit.bossLevel.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowMeleeMissBossLevel:SetChecked(meleeProfile.hit.bossLevel.display)

    -- Crit
    ShowMeleeCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowMeleeCrit:SetScript("OnClick", function()
        local show = not meleeProfile.crit.display
        ExtendedCharacterStats.profile.melee.crit.display = show
        ShowMeleeCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[meleeProfile.crit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowMeleeCrit:SetChecked(meleeProfile.crit.display)
end

function ECSConfig:CreateRangedOptions()

    -- Create Header Options
    local ShowRanged = _CreateCheckBox(20, leftOffset, "Ranged", "TOPLEFT")
    local ShowRangedHitBonus, ShowRangedMissChanceSameLevel, ShowRangedMissChanceBossLevel, ShowRangedCrit -- forward declaration
    leftOffset = leftOffset - 30
    local rangedProfile = ExtendedCharacterStats.profile.ranged

    ShowRanged:SetScript("OnClick", function()
        local show = not rangedProfile.display
        ExtendedCharacterStats.profile.ranged.display = show
        ExtendedCharacterStats.profile.ranged.hit.display = show
        ShowRanged:SetChecked(show)
        ShowRangedHitBonus:SetEnabled(show)
        ShowRangedMissChanceSameLevel:SetEnabled(show)
        ShowRangedMissChanceBossLevel:SetEnabled(show)
        ShowRangedCrit:SetEnabled(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.bonus.refName])
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.sameLevel.refName])
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.bossLevel.refName])
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.crit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRanged:SetChecked(rangedProfile.display)

    -- Create Sub-Header Options

    -- Hit Bonus
    ShowRangedHitBonus = _CreateCheckBox(40, leftOffset, "Hit Bonus", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedHitBonus:SetScript("OnClick", function()
        local show = not rangedProfile.hit.bonus.display
        ExtendedCharacterStats.profile.ranged.hit.bonus.display = show
        ShowRangedHitBonus:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.bonus.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRangedHitBonus:SetChecked(rangedProfile.hit.bonus.display)

    -- Miss Chance
    ShowRangedMissChanceSameLevel = _CreateCheckBox(40, leftOffset, "Miss Chance", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedMissChanceSameLevel:SetScript("OnClick", function()
        local show = not rangedProfile.hit.sameLevel.display
        ExtendedCharacterStats.profile.ranged.hit.sameLevel.display = show
        ShowRangedMissChanceSameLevel:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.sameLevel.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRangedMissChanceSameLevel:SetChecked(rangedProfile.hit.sameLevel.display)

    -- Miss Chance (+3)
    ShowRangedMissChanceBossLevel = _CreateCheckBox(40, leftOffset, "Miss Chance (+3)", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedMissChanceBossLevel:SetScript("OnClick", function()
        local show = not rangedProfile.hit.bossLevel.display
        ExtendedCharacterStats.profile.ranged.hit.bossLevel.display = show
        ShowRangedMissChanceBossLevel:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.bossLevel.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRangedMissChanceBossLevel:SetChecked(rangedProfile.hit.bossLevel.display)

    -- Crit
    ShowRangedCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRangedCrit:SetScript("OnClick", function()
        local show = not rangedProfile.crit.display
        ExtendedCharacterStats.profile.ranged.crit.display = show
        ShowRangedCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[rangedProfile.hit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRangedCrit:SetChecked(rangedProfile.crit.display)
end

function ECSConfig:CreateDefenseOptions()

    -- Create Header Options
    local ShowDefense = _CreateCheckBox(20, leftOffset, "Defense", "TOPLEFT")
    local ShowBlock, ShowParry, ShowDodge -- forward declaration
    leftOffset = leftOffset - 30
    local defenseProfile = ExtendedCharacterStats.profile.defense

    ShowDefense:SetScript("OnClick", function()
        local show = not defenseProfile.display
        ExtendedCharacterStats.profile.defense.display = show
        ShowDefense:SetChecked(show)
        ShowBlock:SetEnabled(show)
        ShowParry:SetEnabled(show)
        ShowDodge:SetEnabled(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.block.refName])
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.parry.refName])
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.dodge.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowDefense:SetChecked(defenseProfile.display)

    -- Create Sub-Header Options

    -- Block
    ShowBlock = _CreateCheckBox(40, leftOffset, "Block", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowBlock:SetScript("OnClick", function()
        local show = not defenseProfile.block.display
        ExtendedCharacterStats.profile.defense.block.display = show
        ShowBlock:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.block.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowBlock:SetChecked(ExtendedCharacterStats.profile.defense.block.display)

    -- Parry
    ShowParry = _CreateCheckBox(40, leftOffset, "Parry", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowParry:SetScript("OnClick", function()
        local show = not defenseProfile.parry.display
        ExtendedCharacterStats.profile.defense.parry.display = show
        ShowParry:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.parry.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowParry:SetChecked(defenseProfile.parry.display)

    -- Dodge
    ShowDodge = _CreateCheckBox(40, leftOffset, "Dodge", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowDodge:SetScript("OnClick", function()
        local show = not defenseProfile.dodge.display
        ExtendedCharacterStats.profile.defense.dodge.display = show
        ShowDodge:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[defenseProfile.dodge.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowDodge:SetChecked(defenseProfile.dodge.display)
end

function ECSConfig:CreateRegenOptions()

    -- Create Header Options
    local ShowRegen = _CreateCheckBox(20, leftOffset, "Mana", "TOPLEFT")
    local ShowRegenSpirit -- forward declaration
    leftOffset = leftOffset - 30
    local regenProfile = ExtendedCharacterStats.profile.regen

    ShowRegen:SetScript("OnClick", function()
        local show = not regenProfile.display
        ExtendedCharacterStats.profile.regen.display = show
        ShowRegen:SetChecked(show)
        ShowRegenSpirit:SetEnabled(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[regenProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[regenProfile.mp5Spirit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRegen:SetChecked(ExtendedCharacterStats.profile.regen.display)

    -- Create Sub-Header Options

    -- MP5 from Items
    local ShowRegenItems = _CreateCheckBox(40, leftOffset, "MP5 (Items)", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenItems:SetScript("OnClick", function()
        local show = not regenProfile.mp5Items.display
        ExtendedCharacterStats.profile.regen.mp5Items.display = show
        ShowRegenItems:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[regenProfile.mp5Items.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRegenItems:SetChecked(regenProfile.mp5Items.display)

    -- MP5 from Spirit
    ShowRegenSpirit = _CreateCheckBox(40, leftOffset, "MP5 (Spirit)", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenSpirit:SetScript("OnClick", function()
        local show = not regenProfile.mp5Spirit.display
        ExtendedCharacterStats.profile.regen.mp5Spirit.display = show
        ShowRegenSpirit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[regenProfile.mp5Spirit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRegenSpirit:SetChecked(regenProfile.mp5Spirit.display)

    -- Casting Regen
    local ShowRegenCasting = _CreateCheckBox(40, leftOffset, "Casting", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowRegenCasting:SetScript("OnClick", function()
        local show = not regenProfile.mp5Casting.display
        ExtendedCharacterStats.profile.regen.mp5Casting.display = show
        ShowRegenCasting:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[regenProfile.mp5Casting.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowRegenCasting:SetChecked(regenProfile.mp5Casting.display)
end

function ECSConfig:CreateSpellOptions()

    -- Create Header Options
    local ShowSpell = _CreateCheckBox(20, leftOffset, "Spell", "TOPLEFT")
    local ShowSpellHit, ShowSpellCrit -- forward declaration
    leftOffset = leftOffset - 30
    local spellProfile = ExtendedCharacterStats.profile.spell

    ShowSpell:SetScript("OnClick", function()
        local show = not spellProfile.display
        ExtendedCharacterStats.profile.spell.display = show
        ShowSpell:SetChecked(show)
        ShowSpellHit:SetEnabled(show)
        ShowSpellCrit:SetEnabled(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellProfile.hit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellProfile.crit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowSpell:SetChecked(spellProfile.display)
    -- Create Sub-Header Options

    -- Hit
    ShowSpellHit = _CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellHit:SetScript("OnClick", function()
        local show = not spellProfile.hit.display
        ExtendedCharacterStats.profile.spell.hit.display = show
        ShowSpellHit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellProfile.hit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowSpellHit:SetChecked(spellProfile.hit.display)

    -- Crit
    ShowSpellCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 30

    ShowSpellCrit:SetScript("OnClick", function()
        local show = not spellProfile.crit.display
        ExtendedCharacterStats.profile.spell.crit.display = show
        ShowSpellCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellProfile.crit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowSpellCrit:SetChecked(spellProfile.crit.display)
end

function ECSConfig:CreateSpellBonusOptions()

    -- Create Header Options
    local ShowSpellBonus = _CreateCheckBox(-150, rightOffset, "Spell Bonus", "TOPRIGHT")
    local ShowBonusHealing, ShowArcaneDmg, ShowArcaneCrit, ShowFireDmg, ShowFireCrit, ShowFrostDmg,
        ShowFrostCrit, ShowHolyDmg, ShowHolyCrit, ShowNatureDmg, ShowNatureCrit, ShowPhysicalDmg,
        ShowPhysicalCrit, ShowShadowDmg, ShowShadowCrit -- forward declaration
    rightOffset = rightOffset - 30
    local spellBonusProfile = ExtendedCharacterStats.profile.spellBonus

    ShowSpellBonus:SetScript("OnClick", function()
        local show = not spellBonusProfile.display
        ExtendedCharacterStats.profile.spellBonus.display = show
        ShowSpellBonus:SetChecked(show)
        ShowBonusHealing:SetEnabled(show)
        ShowArcaneDmg:SetEnabled(show)
        ShowArcaneCrit:SetEnabled(show)
        ShowFireDmg:SetEnabled(show)
        ShowFireCrit:SetEnabled(show)
        ShowFrostDmg:SetEnabled(show)
        ShowFrostCrit:SetEnabled(show)
        ShowHolyDmg:SetEnabled(show)
        ShowHolyCrit:SetEnabled(show)
        ShowNatureDmg:SetEnabled(show)
        ShowNatureCrit:SetEnabled(show)
        ShowPhysicalDmg:SetEnabled(show)
        ShowPhysicalCrit:SetEnabled(show)
        ShowShadowDmg:SetEnabled(show)
        ShowShadowCrit:SetEnabled(show)

        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.bonusHealing.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.arcaneDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.arcaneCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.fireDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.fireCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.frostDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.frostCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.holyDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.holyCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.natureDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.natureCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.physicalDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.physicalCrit.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.shadowDmg.refName])
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.shadowCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowSpellBonus:SetChecked(spellBonusProfile.display)

    -- Create Sub-Header Options

    ShowBonusHealing = _CreateCheckBox(-130, rightOffset, "Bonus Healing", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowBonusHealing:SetScript("OnClick", function()
        local show = not spellBonusProfile.bonusHealing.display
        ExtendedCharacterStats.profile.spellBonus.bonusHealing.display = show
        ShowBonusHealing:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.bonusHealing.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowBonusHealing:SetChecked(spellBonusProfile.bonusHealing.display)

    ShowArcaneDmg = _CreateCheckBox(-130, rightOffset, "Arcane Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.arcaneDmg.display
        ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = show
        ShowArcaneDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.arcaneDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowArcaneDmg:SetChecked(spellBonusProfile.arcaneDmg.display)

    ShowArcaneCrit = _CreateCheckBox(-130, rightOffset, "Arcane Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowArcaneCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.arcaneCrit.display
        ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display = show
        ShowArcaneCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.arcaneCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowArcaneCrit:SetChecked(spellBonusProfile.arcaneCrit.display)

    ShowFireDmg = _CreateCheckBox(-130, rightOffset, "Fire Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.fireDmg.display
        ExtendedCharacterStats.profile.spellBonus.fireDmg.display = show
        ShowFireDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.fireDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowFireDmg:SetChecked(spellBonusProfile.fireDmg.display)

    ShowFireCrit = _CreateCheckBox(-130, rightOffset, "Fire Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFireCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.fireCrit.display
        ExtendedCharacterStats.profile.spellBonus.fireCrit.display = show
        ShowFireCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.fireCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowFireCrit:SetChecked(spellBonusProfile.fireCrit.display)

    ShowFrostDmg = _CreateCheckBox(-130, rightOffset, "Frost Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.frostDmg.display
        ExtendedCharacterStats.profile.spellBonus.frostDmg.display = show
        ShowFrostDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.frostDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowFrostDmg:SetChecked(spellBonusProfile.frostDmg.display)

    ShowFrostCrit = _CreateCheckBox(-130, rightOffset, "Frost Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowFrostCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.frostCrit.display
        ExtendedCharacterStats.profile.spellBonus.frostCrit.display = show
        ShowFrostCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.frostCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowFrostCrit:SetChecked(spellBonusProfile.frostCrit.display)

    ShowHolyDmg = _CreateCheckBox(-130, rightOffset, "Holy Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.holyDmg.display
        ExtendedCharacterStats.profile.spellBonus.holyDmg.display = show
        ShowHolyDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.holyDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowHolyDmg:SetChecked(spellBonusProfile.holyDmg.display)

    ShowHolyCrit = _CreateCheckBox(-130, rightOffset, "Holy Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowHolyCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.holyCrit.display
        ExtendedCharacterStats.profile.spellBonus.holyCrit.display = show
        ShowHolyCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.holyCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowHolyCrit:SetChecked(spellBonusProfile.holyCrit.display)

    ShowNatureDmg = _CreateCheckBox(-130, rightOffset, "Nature Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.natureDmg.display
        ExtendedCharacterStats.profile.spellBonus.natureDmg.display = show
        ShowNatureDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.natureDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowNatureDmg:SetChecked(spellBonusProfile.natureDmg.display)

    ShowNatureCrit = _CreateCheckBox(-130, rightOffset, "Nature Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowNatureCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.natureCrit.display
        ExtendedCharacterStats.profile.spellBonus.natureCrit.display = show
        ShowNatureCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.natureCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowNatureCrit:SetChecked(spellBonusProfile.natureCrit.display)

    ShowPhysicalDmg = _CreateCheckBox(-130, rightOffset, "Physical Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.physicalDmg.display
        ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = show
        ShowPhysicalDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.physicalDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowPhysicalDmg:SetChecked(spellBonusProfile.physicalDmg.display)

    ShowPhysicalCrit = _CreateCheckBox(-130, rightOffset, "Physical Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowPhysicalCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.physicalCrit.display
        ExtendedCharacterStats.profile.spellBonus.physicalCrit.display = show
        ShowPhysicalCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.physicalCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowPhysicalCrit:SetChecked(spellBonusProfile.physicalCrit.display)

    ShowShadowDmg = _CreateCheckBox(-130, rightOffset, "Shadow Damage", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.shadowDmg.display
        ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = show
        ShowShadowDmg:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.shadowDmg.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowShadowDmg:SetChecked(spellBonusProfile.shadowDmg.display)

    ShowShadowCrit = _CreateCheckBox(-130, rightOffset, "Shadow Crit", "TOPRIGHT")
    rightOffset = rightOffset - 30

    ShowShadowCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.shadowCrit.display
        ExtendedCharacterStats.profile.spellBonus.shadowCrit.display = show
        ShowShadowCrit:SetChecked(show)
        if not show then
            ECSConfig:RecycleFrame(core.displayedStats[spellBonusProfile.shadowCrit.refName])
        end
        ECSConfig:RebuildStatInfos()
    end)
    ShowShadowCrit:SetChecked(spellBonusProfile.shadowCrit.display)
end

function ECSConfig:UpdateShownStats()
    
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
    ECSMainWindow.configButton:SetSize(ExtendedCharacterStats.windowSize.width - 10, 20)
    ECSMainWindow.configButton:SetPoint("CENTER", ECSMainWindow, "TOP", -1, -35)
    ECSMainWindow.configButton:SetScript("OnClick", function ()
        _ToggleConfigWindow()
    end)

    ECSMainWindow.ScrollFrame = CreateFrame("ScrollFrame", nil, ECSMainWindow, "UIPanelScrollFrameTemplate")
    ECSMainWindow.ScrollFrame:SetPoint("TOPLEFT", ECSMainWindow, "TOPLEFT", -35, -50)
    ECSMainWindow.ScrollFrame:SetPoint("BOTTOMRIGHT", ECSMainWindow, "BOTTOMRIGHT", -35, 10)

    ECSMainWindow.ScrollChild = CreateFrame("Frame", nil, ECSMainWindow.ScrollFrame)
    ECSMainWindow.ScrollChild:SetSize(ExtendedCharacterStats.windowSize.width, ExtendedCharacterStats.windowSize.height)
    ECSMainWindow.ScrollFrame:SetScrollChild(ECSMainWindow.ScrollChild)


    local toggleButton = CreateFrame("Button", "ECS_ToggleButton", CharacterModelFrame, "GameMenuButtonTemplate")
    toggleButton:SetText("ECS")
    toggleButton:SetSize(33, 16)
    toggleButton:SetPoint("BOTTOMRIGHT", CharacterModelFrame, "BOTTOMRIGHT", 0, 10)
    toggleButton:SetScript("OnClick", function ()
        _ToggleMainWindow()
    end)


    ECSConfig:CreateStatInfos()
    ECSConfig:CreateConfigWindow()

    return ECSMainWindow
end

local function _CreateStatInfo(category, ...)
    if category.display == true then
        ECSConfig:CreateHeader(category.refName, category.text, category.isSubGroup)
        local stats = {...}
        -- Loop through all stats
        for _, stat in pairs(stats) do
            if type(stat) == "table" and stat.display == true then
                ECSConfig:CreateText(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName), category.isSubGroup)
            end
        end
    end
end

function ECSConfig:CreateStatInfos()
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
    _CreateStatInfo(category, category.hit, category.crit)

    category = profile.spellBonus
    _CreateStatInfo(
        category, category.bonusHealing, category.arcaneDmg, category.arcaneCrit, category.fireDmg,
        category.fireCrit, category.frostDmg, category.frostCrit, category.holyDmg,
        category.holyCrit, category.natureDmg, category.natureCrit, category.physicalDmg,
        category.physicalCrit, category.shadowDmg, category.shadowCrit
    )
end

local framePool = {}
local lastYOffset = 20

-- Creates a new header on the UI
function ECSConfig:CreateHeader(name, displayText, isSubHeader)
    local xOffSet = 50
    if isSubHeader then
        xOffSet = 60
    end
    lastYOffset = lastYOffset - 20
    local header = table.remove(framePool)
    if not header then
        header = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", headerFont)
    else
        header:SetFontObject(headerFont)
    end
    header:SetPoint("TOPLEFT", xOffSet, lastYOffset)
    header:SetText(displayText)
    header:Show()
    core.displayedStats[name] = header
end

-- Creates a new information text on the UI
function ECSConfig:CreateText(name, displayText, isSubText)
    local xOffSet = 60
    if isSubText then
        xOffSet = 70
    end
    lastYOffset = lastYOffset - 15
    local stat = table.remove(framePool)
    if not stat then
        stat = ECSMainWindow.ScrollChild:CreateFontString(name, "OVERLAY", statFont)
    else
        stat:SetFontObject(statFont)
    end
    stat:SetPoint("TOPLEFT", xOffSet, lastYOffset)
    stat:SetText(displayText)
    stat:Show()
    core.displayedStats[name] = stat
end

function ECSConfig:RecycleFrame(frame)
    frame:Hide()
    table.insert(framePool, frame)
end

function ECSConfig:RebuildStatInfos()
    lastYOffset = 20

    for _, entry in pairs(core.displayedStats) do
        entry:Hide()
    end

    ECSConfig:CreateStatInfos()
end

function ECSConfig:UpdateItem(refName, text)

    local stat = core.displayedStats[refName]
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
                        ECSConfig:UpdateItem(subStat.refName, subStat.text .. core.ECSData:GetStatInfo(subStat.refName))
                    end
                end
            elseif stat.display == true then
                ECSConfig:UpdateItem(stat.refName, stat.text .. core.ECSData:GetStatInfo(stat.refName))
            end
        end
    end
end

--- Read the loaded profile and update all enabled elements
function ECSConfig:UpdateInformation()

    -- Loop through all categories
    for _, category in pairs(ExtendedCharacterStats.profile) do
        if category.display == true then
            -- Loop through all stats
            _UpdateStats(category)
        end
    end
end
