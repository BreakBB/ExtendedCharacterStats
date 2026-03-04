local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetDebuffDataByIndex = C_UnitAuras.GetDebuffDataByIndex
local IsClassic = ECS.IsClassic
local IsWotlk = ECS.IsWotlk
local max = math.max
local pairs = pairs
local playerLevel = UnitLevel("player")
local UnitClass = UnitClass
local GetInventoryItemID = GetInventoryItemID

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _General = {}

local _, _, classId = UnitClass("player")
local DRUID = Data.DRUID
local ROGUE = Data.ROGUE

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

---@return number
function Data:GetInvisibility()
    local inv = 0

    -- buffs
    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            for _, Id in pairs(Data.Aura.Invisibility) do
                inv = max(inv, (Id[aura.spellId] or 0))
            end
        end
        i = i + 1
    until (not aura)

    -- debuffs
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            for _, Id in pairs(Data.Aura.Invisibility) do
                inv = max(inv, (Id[aura.spellId] or 0))
            end
        end
        i = i + 1
    until (not aura)

    return DataUtils:Round(inv, 2)
end

---@return number
function Data:GetStealthValue()
    return _General:GetStealth() + _General:GetModStealthEffectiveness()
end

---@return number
function _General:GetStealth()
    local stealth = 0
    local prowlOrStealth = false

    for i = 1, 18 do
        local id, _ = GetInventoryItemID("player", i)
        stealth = stealth + (Data.Item.StealthEffectiveness[id] or 0)
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                stealth = stealth + (Data.Enchant.StealthEffectiveness[enchant] or 0)
            end
        end
    end

    -- buffs
    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            if classId == ROGUE or classId == DRUID then
                -- check if character is prowling or stealthing
                prowlOrStealth = prowlOrStealth or Data.Aura.IsProwlOrStealth[aura.spellId]
            end
            stealth = max(stealth, (Data.Aura.Stealth[aura.spellId] or 0))
            if aura.spellId == 58984 then -- Shadowmeld
                stealth = max(stealth, playerLevel * 5)
            end
        end
        i = i + 1
    until (not aura)

    -- debuffs
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            stealth = max(stealth, (Data.Aura.Stealth[aura.spellId] or 0))
        end
        i = i + 1
    until (not aura)

    -- wotlk stealth/prowl stealth level is dependent on level
    if prowlOrStealth and IsWotlk then
        stealth = max(stealth, playerLevel * 5)
    end

    return stealth
end

---@return number
function _General:GetModStealthEffectiveness()
    local stealth = 0
    local prowlOrStealth = false
    local hasShadowmeldBonus = false

    -- buffs
    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        if aura and aura.spellId then
            if classId == Data.ROGUE or classId == Data.DRUID then
                -- check if character is prowling or stealthing
                prowlOrStealth = prowlOrStealth or Data.Aura.IsProwlOrStealth[aura.spellId]
            end
            stealth = stealth + (Data.Aura.StealthEffectiveness[aura.spellId] or 0)
            if aura.spellId == 58984 then -- Shadowmeld
                hasShadowmeldBonus = true
            end
        end
        i = i + 1
    until (not aura)

    -- debuffs
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        if aura and aura.spellId then
            stealth = stealth + (Data.Aura.StealthEffectiveness[aura.spellId] or 0)
        end
        i = i + 1
    until (not aura)

    if (prowlOrStealth or hasShadowmeldBonus) and IsPlayerSpell(21009) then
        stealth = stealth + 5 -- Shadowmeld passive / elusiveness
    end

    -- talents
    if prowlOrStealth then
        if classId == DRUID then
            local coeff = (IsClassic and 3 or 5)
            stealth = stealth + coeff * DataUtils:GetActiveTalentSpell(Data.Talent[DRUID].FERAL_INSTINCT) -- Feral Instinct
        elseif classId == ROGUE then
            local coeff = (IsWotlk and 5 or 3)
            stealth = stealth + coeff * DataUtils:GetActiveTalentSpell(Data.Talent[ROGUE].MASTER_OF_DECEPTION) -- Master of Deception
        end
    end
    return stealth
end