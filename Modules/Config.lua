------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Config
local Config = ECSLoader:CreateModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")
---@type GearInfos
local GearInfos = ECSLoader:ImportModule("GearInfos")

------------------------------------------------------------------
-- Configuration Frame
------------------------------------------------------------------

-- Forward declaration
local _CreateCheckBox

local leftOffset = -30
local rightOffset = -30

function Config:CreateWindow()

    -- Create Config Window
    local settingsFrame = CreateFrame("Frame", "ECS_ConfigFrame", UIParent, "BasicFrameTemplateWithInset")
    table.insert(UISpecialFrames, settingsFrame:GetName())
    settingsFrame:SetSize(350, 450) -- Width, Height
    settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 100) -- Point, relativeFrame, relativePoint, xOffset, yOffset
    settingsFrame:SetFrameStrata("DIALOG")
    settingsFrame:Hide()
    settingsFrame.title = settingsFrame:CreateFontString(nil, "OVERLAY")
    settingsFrame.title:SetFontObject("GameFontHighlight")
    settingsFrame.title:SetPoint("CENTER", settingsFrame.TitleBg, "CENTER", 0, 0)
    settingsFrame.title:SetText("Extended Character Stats Settings")
    _Config.frame = settingsFrame

    local showQualityColors = _CreateCheckBox(20, leftOffset, "Show quality colors", "TOPLEFT")
    showQualityColors:SetScript("OnClick", function ()
        local value = not ExtendedCharacterStats.general.showQualityColors
        GearInfos:ToggleColorFrames(value)

        ExtendedCharacterStats.general.showQualityColors = value
    end)
    showQualityColors:SetChecked(ExtendedCharacterStats.general.showQualityColors)
    leftOffset = leftOffset - 25

    -- Melee
    -- ExtendedCharacterStats.profile.melee
    Config:CreateMeleeOptions()

    -- Ranged
    -- ExtendedCharacterStats.profile.ranged
    Config:CreateRangedOptions()

    -- Defense
    -- ExtendedCharacterStats.profile.defense
    Config:CreateDefenseOptions()

    -- Regen
    -- ExtendedCharacterStats.profile.regen
    Config:CreateRegenOptions()

    -- Spell
    -- ExtendedCharacterStats.profile.spell
    Config:CreateSpellOptions()

    rightOffset = rightOffset - 25

    -- SpellBonus
    -- ExtendedCharacterStats.profile.SpellBonus
    Config:CreateSpellBonusOptions()

    local closeButton = CreateFrame("Button", nil, settingsFrame, "OptionsButtonTemplate")
    closeButton:SetPoint("BOTTOM", 0, 10) -- pos, y, x
    closeButton:SetSize(150, 30)
    closeButton:SetText("Close")
    closeButton:SetScript("OnClick", function()
        settingsFrame:Hide()
    end)
end

function Config:ToggleWindow()
    _Config.frame:SetShown(not _Config.frame:IsShown())
end

_CreateCheckBox = function(yOffset, xOffset, text, position)
    local checkbox = CreateFrame("CheckButton", nil, _Config.frame, "UICheckButtonTemplate")
    checkbox:SetSize(20, 20)
    checkbox:SetPoint(position, yOffset, xOffset)
    checkbox.text:SetText(text)
    return checkbox
end

function Config:CreateMeleeOptions()
    -- Create Header Options
    local ShowMelee = _CreateCheckBox(20, leftOffset, "Melee", "TOPLEFT")
    local ShowMeleeHitBonus, ShowMeleeMissSameLevel, ShowMeleeMissBossLevel, ShowMeleeCrit -- forward declaration
    leftOffset = leftOffset - 15
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
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[meleeProfile.refName])
            Stats:RecycleFrame(lines[meleeProfile.hit.refName])
            Stats:RecycleFrame(lines[meleeProfile.hit.bonus.refName])
            Stats:RecycleFrame(lines[meleeProfile.hit.sameLevel.refName])
            Stats:RecycleFrame(lines[meleeProfile.hit.bossLevel.refName])
            Stats:RecycleFrame(lines[meleeProfile.crit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowMelee:SetChecked(meleeProfile.display)

    -- Create Sub-Header Options

    -- Hit Bonus
    ShowMeleeHitBonus = _CreateCheckBox(40, leftOffset, "Hit Bonus", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowMeleeHitBonus:SetScript("OnClick", function()
        local show = not meleeProfile.hit.bonus.display
        ExtendedCharacterStats.profile.melee.hit.bonus.display = show
        ShowMeleeHitBonus:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[meleeProfile.hit.bonus.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowMeleeHitBonus:SetChecked(meleeProfile.hit.bonus.display)

    -- Miss Chance (Same Level)
    ShowMeleeMissSameLevel = _CreateCheckBox(40, leftOffset, "Miss Chance", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowMeleeMissSameLevel:SetScript("OnClick", function()
        local show = not meleeProfile.hit.sameLevel.display
        ExtendedCharacterStats.profile.melee.hit.sameLevel.display = show
        ShowMeleeMissSameLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[meleeProfile.hit.sameLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowMeleeMissSameLevel:SetChecked(meleeProfile.hit.sameLevel.display)

    -- Miss Chance (Playerlevel + 3)
    ShowMeleeMissBossLevel = _CreateCheckBox(40, leftOffset, "Miss Chance (+3)", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowMeleeMissBossLevel:SetScript("OnClick", function()
        local show = not meleeProfile.hit.bossLevel.display
        ExtendedCharacterStats.profile.melee.hit.bossLevel.display = show
        ShowMeleeMissBossLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[meleeProfile.hit.bossLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowMeleeMissBossLevel:SetChecked(meleeProfile.hit.bossLevel.display)

    -- Crit
    ShowMeleeCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowMeleeCrit:SetScript("OnClick", function()
        local show = not meleeProfile.crit.display
        ExtendedCharacterStats.profile.melee.crit.display = show
        ShowMeleeCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[meleeProfile.crit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowMeleeCrit:SetChecked(meleeProfile.crit.display)
    leftOffset = leftOffset - 5
end

function Config:CreateRangedOptions()

    -- Create Header Options
    local ShowRanged = _CreateCheckBox(20, leftOffset, "Ranged", "TOPLEFT")
    local ShowRangedHitBonus, ShowRangedMissChanceSameLevel, ShowRangedMissChanceBossLevel, ShowRangedCrit -- forward declaration
    leftOffset = leftOffset - 15
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
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[rangedProfile.refName])
            Stats:RecycleFrame(lines[rangedProfile.hit.refName])
            Stats:RecycleFrame(lines[rangedProfile.hit.bonus.refName])
            Stats:RecycleFrame(lines[rangedProfile.hit.sameLevel.refName])
            Stats:RecycleFrame(lines[rangedProfile.hit.bossLevel.refName])
            Stats:RecycleFrame(lines[rangedProfile.crit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRanged:SetChecked(rangedProfile.display)

    -- Create Sub-Header Options

    -- Hit Bonus
    ShowRangedHitBonus = _CreateCheckBox(40, leftOffset, "Hit Bonus", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRangedHitBonus:SetScript("OnClick", function()
        local show = not rangedProfile.hit.bonus.display
        ExtendedCharacterStats.profile.ranged.hit.bonus.display = show
        ShowRangedHitBonus:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[rangedProfile.hit.bonus.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRangedHitBonus:SetChecked(rangedProfile.hit.bonus.display)

    -- Miss Chance
    ShowRangedMissChanceSameLevel = _CreateCheckBox(40, leftOffset, "Miss Chance", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRangedMissChanceSameLevel:SetScript("OnClick", function()
        local show = not rangedProfile.hit.sameLevel.display
        ExtendedCharacterStats.profile.ranged.hit.sameLevel.display = show
        ShowRangedMissChanceSameLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[rangedProfile.hit.sameLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRangedMissChanceSameLevel:SetChecked(rangedProfile.hit.sameLevel.display)

    -- Miss Chance (+3)
    ShowRangedMissChanceBossLevel = _CreateCheckBox(40, leftOffset, "Miss Chance (+3)", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRangedMissChanceBossLevel:SetScript("OnClick", function()
        local show = not rangedProfile.hit.bossLevel.display
        ExtendedCharacterStats.profile.ranged.hit.bossLevel.display = show
        ShowRangedMissChanceBossLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[rangedProfile.hit.bossLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRangedMissChanceBossLevel:SetChecked(rangedProfile.hit.bossLevel.display)

    -- Crit
    ShowRangedCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRangedCrit:SetScript("OnClick", function()
        local show = not rangedProfile.crit.display
        ExtendedCharacterStats.profile.ranged.crit.display = show
        ShowRangedCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[rangedProfile.hit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRangedCrit:SetChecked(rangedProfile.crit.display)
    leftOffset = leftOffset - 5
end

function Config:CreateDefenseOptions()

    -- Create Header Options
    local ShowDefense = _CreateCheckBox(20, leftOffset, "Defense", "TOPLEFT")
    local ShowBlock, ShowParry, ShowDodge -- forward declaration
    leftOffset = leftOffset - 15
    local defenseProfile = ExtendedCharacterStats.profile.defense

    ShowDefense:SetScript("OnClick", function()
        local show = not defenseProfile.display
        ExtendedCharacterStats.profile.defense.display = show
        ShowDefense:SetChecked(show)
        ShowBlock:SetEnabled(show)
        ShowParry:SetEnabled(show)
        ShowDodge:SetEnabled(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[defenseProfile.refName])
            Stats:RecycleFrame(lines[defenseProfile.block.refName])
            Stats:RecycleFrame(lines[defenseProfile.parry.refName])
            Stats:RecycleFrame(lines[defenseProfile.dodge.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowDefense:SetChecked(defenseProfile.display)

    -- Create Sub-Header Options

    -- Block
    ShowBlock = _CreateCheckBox(40, leftOffset, "Block", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowBlock:SetScript("OnClick", function()
        local show = not defenseProfile.block.display
        ExtendedCharacterStats.profile.defense.block.display = show
        ShowBlock:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[defenseProfile.block.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowBlock:SetChecked(ExtendedCharacterStats.profile.defense.block.display)

    -- Parry
    ShowParry = _CreateCheckBox(40, leftOffset, "Parry", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowParry:SetScript("OnClick", function()
        local show = not defenseProfile.parry.display
        ExtendedCharacterStats.profile.defense.parry.display = show
        ShowParry:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[defenseProfile.parry.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowParry:SetChecked(defenseProfile.parry.display)

    -- Dodge
    ShowDodge = _CreateCheckBox(40, leftOffset, "Dodge", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowDodge:SetScript("OnClick", function()
        local show = not defenseProfile.dodge.display
        ExtendedCharacterStats.profile.defense.dodge.display = show
        ShowDodge:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[defenseProfile.dodge.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowDodge:SetChecked(defenseProfile.dodge.display)
    leftOffset = leftOffset - 5
end

function Config:CreateRegenOptions()

    -- Create Header Options
    local ShowRegen = _CreateCheckBox(20, leftOffset, "Mana", "TOPLEFT")
    local ShowRegenItems, ShowRegenSpirit, ShowRegenCasting -- forward declaration
    leftOffset = leftOffset - 15
    local regenProfile = ExtendedCharacterStats.profile.regen

    ShowRegen:SetScript("OnClick", function()
        local show = not regenProfile.display
        ExtendedCharacterStats.profile.regen.display = show
        ShowRegen:SetChecked(show)
        ShowRegenItems:SetEnabled(show)
        ShowRegenSpirit:SetEnabled(show)
        ShowRegenCasting:SetEnabled(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[regenProfile.refName])
            Stats:RecycleFrame(lines[regenProfile.mp5Items.refName])
            Stats:RecycleFrame(lines[regenProfile.mp5Spirit.refName])
            Stats:RecycleFrame(lines[regenProfile.mp5Casting.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRegen:SetChecked(ExtendedCharacterStats.profile.regen.display)

    -- Create Sub-Header Options

    -- MP5 from Items
    ShowRegenItems = _CreateCheckBox(40, leftOffset, "MP5 (Items)", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRegenItems:SetScript("OnClick", function()
        local show = not regenProfile.mp5Items.display
        ExtendedCharacterStats.profile.regen.mp5Items.display = show
        ShowRegenItems:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[regenProfile.mp5Items.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRegenItems:SetChecked(regenProfile.mp5Items.display)

    -- MP5 from Spirit
    ShowRegenSpirit = _CreateCheckBox(40, leftOffset, "MP5 (Spirit)", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRegenSpirit:SetScript("OnClick", function()
        local show = not regenProfile.mp5Spirit.display
        ExtendedCharacterStats.profile.regen.mp5Spirit.display = show
        ShowRegenSpirit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[regenProfile.mp5Spirit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRegenSpirit:SetChecked(regenProfile.mp5Spirit.display)

    -- Casting Regen
    ShowRegenCasting = _CreateCheckBox(40, leftOffset, "Casting", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowRegenCasting:SetScript("OnClick", function()
        local show = not regenProfile.mp5Casting.display
        ExtendedCharacterStats.profile.regen.mp5Casting.display = show
        ShowRegenCasting:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[regenProfile.mp5Casting.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowRegenCasting:SetChecked(regenProfile.mp5Casting.display)
    leftOffset = leftOffset - 5
end

function Config:CreateSpellOptions()

    -- Create Header Options
    local ShowSpell = _CreateCheckBox(20, leftOffset, "Spell", "TOPLEFT")
    local ShowSpellHitBonus, ShowSpellMissChanceSameLevel, ShowSpellMissChanceBossLevel, ShowSpellCrit -- forward declaration
    leftOffset = leftOffset - 15
    local spellProfile = ExtendedCharacterStats.profile.spell

    ShowSpell:SetScript("OnClick", function()
        local show = not spellProfile.display
        ExtendedCharacterStats.profile.spell.display = show
        ExtendedCharacterStats.profile.spell.hit.display = show
        ShowSpell:SetChecked(show)
        ShowSpellHitBonus:SetEnabled(show)
        ShowSpellMissChanceSameLevel:SetEnabled(show)
        ShowSpellMissChanceBossLevel:SetEnabled(show)
        ShowSpellCrit:SetEnabled(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellProfile.refName])
            Stats:RecycleFrame(lines[spellProfile.hit.refName])
            Stats:RecycleFrame(lines[spellProfile.hit.bonus.refName])
            Stats:RecycleFrame(lines[spellProfile.hit.sameLevel.refName])
            Stats:RecycleFrame(lines[spellProfile.hit.bossLevel.refName])
            Stats:RecycleFrame(lines[spellProfile.crit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpell:SetChecked(spellProfile.display)
    -- Create Sub-Header Options

    -- Hit Bonus
    ShowSpellHitBonus = _CreateCheckBox(40, leftOffset, "Hit", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowSpellHitBonus:SetScript("OnClick", function()
        local show = not spellProfile.hit.bonus.display
        ExtendedCharacterStats.profile.spell.hit.bonus.display = show
        ShowSpellHitBonus:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellProfile.hit.bonus.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpellHitBonus:SetChecked(spellProfile.hit.bonus.display)

    -- Miss Chance
    ShowSpellMissChanceSameLevel = _CreateCheckBox(40, leftOffset, "Miss Chance", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowSpellMissChanceSameLevel:SetScript("OnClick", function()
        local show = not spellProfile.hit.sameLevel.display
        ExtendedCharacterStats.profile.spell.hit.sameLevel.display = show
        ShowSpellMissChanceSameLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellProfile.hit.sameLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpellMissChanceSameLevel:SetChecked(spellProfile.hit.sameLevel.display)

    -- Miss Chance (+3)
    ShowSpellMissChanceBossLevel = _CreateCheckBox(40, leftOffset, "Miss Chance (+3)", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowSpellMissChanceBossLevel:SetScript("OnClick", function()
        local show = not spellProfile.hit.bossLevel.display
        ExtendedCharacterStats.profile.spell.hit.bossLevel.display = show
        ShowSpellMissChanceBossLevel:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellProfile.hit.bossLevel.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpellMissChanceBossLevel:SetChecked(spellProfile.hit.bossLevel.display)

    -- Crit
    ShowSpellCrit = _CreateCheckBox(40, leftOffset, "Crit", "TOPLEFT")
    leftOffset = leftOffset - 15

    ShowSpellCrit:SetScript("OnClick", function()
        local show = not spellProfile.crit.display
        ExtendedCharacterStats.profile.spell.crit.display = show
        ShowSpellCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellProfile.crit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpellCrit:SetChecked(spellProfile.crit.display)
    leftOffset = leftOffset - 5
end

function Config:CreateSpellBonusOptions()

    -- Create Header Options
    local ShowSpellBonus = _CreateCheckBox(-150, rightOffset, "Spell Bonus", "TOPRIGHT")
    local ShowBonusHealing, ShowArcaneDmg, ShowArcaneCrit, ShowFireDmg, ShowFireCrit, ShowFrostDmg,
        ShowFrostCrit, ShowHolyDmg, ShowHolyCrit, ShowNatureDmg, ShowNatureCrit, ShowPhysicalDmg,
        ShowPhysicalCrit, ShowShadowDmg, ShowShadowCrit -- forward declaration
    rightOffset = rightOffset - 15
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
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.bonusHealing.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.arcaneDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.arcaneCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.fireDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.fireCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.frostDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.frostCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.holyDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.holyCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.natureDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.natureCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.physicalDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.physicalCrit.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.shadowDmg.refName])
            Stats:RecycleFrame(lines[spellBonusProfile.shadowCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowSpellBonus:SetChecked(spellBonusProfile.display)

    -- Create Sub-Header Options

    ShowBonusHealing = _CreateCheckBox(-130, rightOffset, "Bonus Healing", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowBonusHealing:SetScript("OnClick", function()
        local show = not spellBonusProfile.bonusHealing.display
        ExtendedCharacterStats.profile.spellBonus.bonusHealing.display = show
        ShowBonusHealing:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.bonusHealing.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowBonusHealing:SetChecked(spellBonusProfile.bonusHealing.display)

    ShowArcaneDmg = _CreateCheckBox(-130, rightOffset, "Arcane Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowArcaneDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.arcaneDmg.display
        ExtendedCharacterStats.profile.spellBonus.arcaneDmg.display = show
        ShowArcaneDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.arcaneDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowArcaneDmg:SetChecked(spellBonusProfile.arcaneDmg.display)

    ShowArcaneCrit = _CreateCheckBox(-130, rightOffset, "Arcane Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowArcaneCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.arcaneCrit.display
        ExtendedCharacterStats.profile.spellBonus.arcaneCrit.display = show
        ShowArcaneCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.arcaneCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowArcaneCrit:SetChecked(spellBonusProfile.arcaneCrit.display)

    ShowFireDmg = _CreateCheckBox(-130, rightOffset, "Fire Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowFireDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.fireDmg.display
        ExtendedCharacterStats.profile.spellBonus.fireDmg.display = show
        ShowFireDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.fireDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowFireDmg:SetChecked(spellBonusProfile.fireDmg.display)

    ShowFireCrit = _CreateCheckBox(-130, rightOffset, "Fire Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowFireCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.fireCrit.display
        ExtendedCharacterStats.profile.spellBonus.fireCrit.display = show
        ShowFireCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.fireCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowFireCrit:SetChecked(spellBonusProfile.fireCrit.display)

    ShowFrostDmg = _CreateCheckBox(-130, rightOffset, "Frost Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowFrostDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.frostDmg.display
        ExtendedCharacterStats.profile.spellBonus.frostDmg.display = show
        ShowFrostDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.frostDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowFrostDmg:SetChecked(spellBonusProfile.frostDmg.display)

    ShowFrostCrit = _CreateCheckBox(-130, rightOffset, "Frost Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowFrostCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.frostCrit.display
        ExtendedCharacterStats.profile.spellBonus.frostCrit.display = show
        ShowFrostCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.frostCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowFrostCrit:SetChecked(spellBonusProfile.frostCrit.display)

    ShowHolyDmg = _CreateCheckBox(-130, rightOffset, "Holy Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowHolyDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.holyDmg.display
        ExtendedCharacterStats.profile.spellBonus.holyDmg.display = show
        ShowHolyDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.holyDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowHolyDmg:SetChecked(spellBonusProfile.holyDmg.display)

    ShowHolyCrit = _CreateCheckBox(-130, rightOffset, "Holy Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowHolyCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.holyCrit.display
        ExtendedCharacterStats.profile.spellBonus.holyCrit.display = show
        ShowHolyCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.holyCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowHolyCrit:SetChecked(spellBonusProfile.holyCrit.display)

    ShowNatureDmg = _CreateCheckBox(-130, rightOffset, "Nature Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowNatureDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.natureDmg.display
        ExtendedCharacterStats.profile.spellBonus.natureDmg.display = show
        ShowNatureDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.natureDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowNatureDmg:SetChecked(spellBonusProfile.natureDmg.display)

    ShowNatureCrit = _CreateCheckBox(-130, rightOffset, "Nature Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowNatureCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.natureCrit.display
        ExtendedCharacterStats.profile.spellBonus.natureCrit.display = show
        ShowNatureCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.natureCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowNatureCrit:SetChecked(spellBonusProfile.natureCrit.display)

    ShowPhysicalDmg = _CreateCheckBox(-130, rightOffset, "Physical Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowPhysicalDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.physicalDmg.display
        ExtendedCharacterStats.profile.spellBonus.physicalDmg.display = show
        ShowPhysicalDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.physicalDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowPhysicalDmg:SetChecked(spellBonusProfile.physicalDmg.display)

    ShowPhysicalCrit = _CreateCheckBox(-130, rightOffset, "Physical Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowPhysicalCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.physicalCrit.display
        ExtendedCharacterStats.profile.spellBonus.physicalCrit.display = show
        ShowPhysicalCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.physicalCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowPhysicalCrit:SetChecked(spellBonusProfile.physicalCrit.display)

    ShowShadowDmg = _CreateCheckBox(-130, rightOffset, "Shadow Damage", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowShadowDmg:SetScript("OnClick", function()
        local show = not spellBonusProfile.shadowDmg.display
        ExtendedCharacterStats.profile.spellBonus.shadowDmg.display = show
        ShowShadowDmg:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.shadowDmg.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowShadowDmg:SetChecked(spellBonusProfile.shadowDmg.display)

    ShowShadowCrit = _CreateCheckBox(-130, rightOffset, "Shadow Crit", "TOPRIGHT")
    rightOffset = rightOffset - 15

    ShowShadowCrit:SetScript("OnClick", function()
        local show = not spellBonusProfile.shadowCrit.display
        ExtendedCharacterStats.profile.spellBonus.shadowCrit.display = show
        ShowShadowCrit:SetChecked(show)
        if not show then
            local lines = Stats:GetDisplayedLines()
            Stats:RecycleFrame(lines[spellBonusProfile.shadowCrit.refName])
        end
        Stats:RebuildStatInfos()
    end)
    ShowShadowCrit:SetChecked(spellBonusProfile.shadowCrit.display)
    leftOffset = leftOffset - 5
end
