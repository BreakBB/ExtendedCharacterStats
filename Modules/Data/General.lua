---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _HP5 = {}
local IsSpellKnown = C_SpellBook.IsSpellKnown
local _, _, classId = UnitClass("player")

---@return string
function Data:GetMovementSpeed()
    local _, runSpeed, flightSpeed, swimSpeed = GetUnitSpeed("player")

    local currentSpeed

    if (not ECS.IsClassic) and IsFlying() then
        currentSpeed = flightSpeed
    elseif IsSwimming() then
        currentSpeed = swimSpeed
    else
        currentSpeed = runSpeed
    end

    currentSpeed = currentSpeed / 7 * 100
    return DataUtils:Round(currentSpeed, 0) .. "%"
end

---@return number, number
function Data:GetHP5()
    local bonusHp5 = ECS.IsClassic and _HP5:GetHP5FromSpirit() or 5 * GetUnitHealthRegenRateFromSpirit("player")
    local bonusCombatHp5 = 0
    local mod = 1
    local talentMod = _HP5:GetDemonicAegisTalentModifier() + 1
    local combatModifier = 0
    local maxhealth = UnitHealthMax("player")

    if IsSpellKnown(20555) then -- Troll passive
        mod = mod + 0.1
        combatModifier = combatModifier + 0.1
    end

    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local stats = GetItemStats(itemLink)
            if stats then
                local statHP5 = stats["ITEM_MOD_HEALTH_REGENERATION_SHORT"]
                if statHP5 then
                    bonusHp5 = bonusHp5 + statHP5 + 1
                end
            end
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                bonusCombatHp5 = bonusCombatHp5 + (Data.Enchant.CombatHealthRegen[enchant] or 0)
            end
        end
    end

    local i = 1
    repeat
        local aura = C_UnitAuras.GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            local DemonicAegis = (Data.Aura.IsFelOrDemonArmor[aura.spellId] and talentMod or 1)
            if aura.spellId == 2645 and IsSpellKnown(59289) then
                bonusHp5 = bonusHp5 + 0.01 * 5 * maxhealth -- Glyph of Ghost Wolf
            end
            mod = mod + (Data.Aura.HealthRegenModifier[aura.spellId] or 0)
            bonusHp5 = bonusHp5 + (Data.Aura.HealthRegen[aura.spellId] or 0) * DemonicAegis
            bonusHp5 = bonusHp5 + (Data.Aura.PercentageHealthRegen[aura.spellId] or 0) * maxhealth * DemonicAegis
        end
        i = i + 1
    until (not aura)

    i = 1
    repeat
        local aura = C_UnitAuras.GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            bonusHp5 = bonusHp5 + (Data.Aura.PercentageHealthRegen[aura.spellId] or 0) * maxhealth
            mod = mod + (Data.Aura.HealthRegenModifier[aura.spellId] or 0)
        end
        i = i + 1
    until (not aura)

    local hp5 = bonusHp5 * mod
    local combatHp5 = bonusCombatHp5 * mod + hp5 * combatModifier
    return hp5, combatHp5
end

---@return number
function _HP5:GetHP5FromSpirit()
    local c = Data.SpiritToHP5Constants[classId]
    local spirit, _, _, _ = UnitStat("player", LE_UNIT_STAT_SPIRIT)
    local hp5 = c[1] * spirit
    if spirit >= 50 then
        hp5 = hp5 + c[2]
    else
        hp5 = hp5 + c[2] * spirit / 50
    end
    return DataUtils:Round(hp5 * 5, 2)
end

---@return number
function _HP5:GetDemonicAegisTalentModifier()
    return 0.1 * DataUtils:GetActiveTalentSpell({30143,30144,30145}) -- Demonic Aegis
end
