---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


local _IsTranscendenceSetPiece, _IsStormrageSetPiece, _IsZandalarSetPiece

local _, _, classId = UnitClass("player")

-- Get MP5 from items
function Data:MP5FromItems()
    local mp5 = 0
    local setCounterZandalar = 0
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

        if itemLink and (classId == Data.DRUID or classId == Data.SHAMAN or classId == Data.PALADIN) then
            local itemName = C_Item.GetItemNameByID(itemLink)
            if itemName then
                if _IsZandalarSetPiece(itemName) then
                    setCounterZandalar = setCounterZandalar + 1
                end
            end
        end
    end

    if setCounterZandalar >= 2 then
        mp5 = mp5 + 4
    end

    return mp5
end

local lastManaReg = 0

-- Get MP5 from spirit
function Data:MP5FromSpirit()
    local base, _ = GetManaRegen() -- Returns mana reg per 1 second
    if base < 1 then
        base = lastManaReg
    end
    lastManaReg = base
    return DataUtils:Round(base, 0) * 5
end

local function _GetTalentModifierMP5()
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

local function _HasT2SetBonusModifierMP5()
    local hasSetBonus = false
    local setCounterT2 = 0
    local setCounterZandalar = 0

    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local itemName = C_Item.GetItemNameByID(GetInventoryItemLink("player", i))

            if itemName then
                if classId == Data.PRIEST then
                    if _IsTranscendenceSetPiece(itemName) then
                        setCounterT2 = setCounterT2 + 1
                    end
                elseif classId == Data.DRUID then
                    if _IsStormrageSetPiece(itemName) then
                        setCounterT2 = setCounterT2 + 1
                    elseif _IsZandalarSetPiece(itemName) then
                        setCounterZandalar = setCounterZandalar + 1
                    end
                elseif classId == Data.SHAMAN or classId == Data.PALADIN then
                    if _IsZandalarSetPiece(itemName) then
                        setCounterZandalar = setCounterZandalar + 1
                    end
                end
            end
        end
    end

    if setCounterT2 >= 3 then
        hasSetBonus = true
    end

    return hasSetBonus
end

_IsTranscendenceSetPiece = function(itemName)
    return string.sub(itemName, -13) == "Transcendence" or string.sub(itemName, -11) == "Erhabenheit" or string.sub(itemName, -13) == "Trascendencia" or string.sub(itemName, -13) == "transcendance" or string.sub(itemName, -14) == "Transcendência"
end

_IsStormrageSetPiece = function(itemName)
    return string.sub(itemName, 1, 9) == "Stormrage" or string.sub(itemName, -9) == "Stormrage" or string.sub(itemName, -10) == "Tempestira" or string.sub(itemName, -11) == "Tempesfúria"
end

_IsZandalarSetPiece = function (itemName)
    return string.sub(itemName, 1, 8) == "Zandalar" or string.sub(itemName, 1, 17) == "Zandalarianischer" or string.sub(itemName, -8) == "Zandalar" or string.sub(itemName, -9) == "zandalar" or string.sub(itemName, -8 ) == "Zandalar"
end

-- Get manaregen while casting
function Data:MP5WhileCasting()
    local _, casting = GetManaRegen() -- Returns mana reg per 1 second
    if casting < 1 then
        casting = lastManaReg
    end
    lastManaReg = casting

    local mod = _GetTalentModifierMP5()
    if _HasT2SetBonusModifierMP5() then
        mod = mod + 0.15
    end
    if mod > 0 then
        casting = casting * mod
    end

    local mp5Items = Data:MP5FromItems()
    casting = (casting * 5) + mp5Items

    return DataUtils:Round(casting, 2)
end
