---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")

local _GetMP5ValueOnItems, _GetTalentModifier, _GetAuraModifier

local _, _, classId = UnitClass("player")

-- Get MP5 from items
function Data:GetMP5FromItems()
    local mp5 = _GetMP5ValueOnItems()
    mp5 = mp5 + Data:GetSetBonusValueMP5()
    return mp5
end

_GetMP5ValueOnItems = function ()
    local mp5 = 0
    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local stats = GetItemStats(itemLink)
            if stats then
                local statMP5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"]
                if statMP5 then
                    mp5 = mp5 + statMP5 + 1
                end
            end
        end
    end

    return mp5
end

local lastManaReg = 0

function Data:GetMP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return DataUtils:Round(base, 0) * 5
end

-- Get manaregen while casting
function Data:GetMP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = lastManaReg
    end
    lastManaReg = casting

    local mod = _GetTalentModifier()
    if Data:HasSetBonusModifierMP5() then
        mod = mod + 0.15
    end
    mod = mod + _GetAuraModifier()
    if mod == 0 then
        casting = 0
    end
    casting = casting * mod

    local mp5Items = Data:GetMP5FromItems()
    casting = (casting * 5) + mp5Items

    return DataUtils:Round(casting, 2)
end

_GetTalentModifier = function()
    local mod = 0

    if classId == Data.PRIEST then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 8)
        mod = points * 0.05 -- 0-15% from Meditation
    elseif classId == Data.MAGE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 12)
        mod = points * 0.05 -- 0-15% Arcane Meditation
    elseif classId == Data.DRUID then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(3, 6)
        mod = points * 0.05 -- 0-15% from Reflection
    end

    return mod
end

_GetAuraModifier = function ()
    local mod = 0

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 6117 or spellId == 22782 or spellId == 22783 then
            mod = mod + 0.3 -- 30% from Mage Armor
        end
    end

    return mod
end