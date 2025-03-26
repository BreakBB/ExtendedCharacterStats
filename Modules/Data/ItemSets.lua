---@type Data
local Data = ECSLoader:ImportModule("Data")

local _, _, classId = UnitClass("player")
local setNames = Data.setNames

local itemSets = {
    [setNames.BATTLEGEAR_OF_MIGHT] = {
        [16861] = true,
        [16862] = true,
        [16863] = true,
        [16864] = true,
        [16865] = true,
        [16866] = true,
        [16867] = true,
        [16868] = true
    },
    [setNames.STORMRAGE_RAIMENT] = {
        [16899] = true,
        [16900] = true,
        [16901] = true,
        [16902] = true,
        [16903] = true,
        [16904] = true,
        [16897] = true,
        [16898] = true
    },
    [setNames.VESTMENTS_OF_TRANSCENDENCE] = {
        [16919] = true,
        [16920] = true,
        [16921] = true,
        [16922] = true,
        [16923] = true,
        [16924] = true,
        [16925] = true,
        [16926] = true
    },
    [setNames.TEN_STORMS] = {
        [16943] = true,
        [16944] = true,
        [16945] = true,
        [16946] = true,
        [16947] = true,
        [16948] = true,
        [16949] = true,
        [16950] = true
    },
    [setNames.THE_EARTHSHATTERER] = {
        [22468] = true,
        [22470] = true,
        [22469] = true,
        [22466] = true,
        [22465] = true,
        [22467] = true,
        [22464] = true,
        [22471] = true,
        [23065] = true
    },
    [setNames.HARUSPEXS_GARB] = {
        [19613] = true,
        [19838] = true,
        [19839] = true,
        [19840] = true,
        [19955] = true
    },
    [setNames.AUGURS_REGALIA] = {
        [19609] = true,
        [19828] = true,
        [19829] = true,
        [19830] = true,
        [19956] = true
    },
    [setNames.FREETHINKERS_ARMOR] = {
        [19588] = true,
        [19825] = true,
        [19826] = true,
        [19827] = true,
        [19952] = true
    },
    [setNames.CHAIN_OF_THE_SCARLET_CRUSADE] = {
        [10328] = true,
        [10329] = true,
        [10330] = true,
        [10331] = true,
        [10332] = true,
        [10333] = true
    },
    [setNames.THE_TWIN_BLADES_OF_AZZINOTH] = {
        [32837] = true,
        [32838] = true
    },
}

function Data:HasDemonSlaying200()
    if classId == Data.ROGUE or classId == Data.WARRIOR then
        return Data:IsSetBonusActive(setNames.THE_TWIN_BLADES_OF_AZZINOTH, 2)
    end
    return false
end

function Data:HasUndeadSlayer15()
    return Data:IsSetBonusActive(setNames.CHAIN_OF_THE_SCARLET_CRUSADE, 5)
end

function Data:HasSetBonusModifierMP5()
    if classId == Data.PRIEST then
        return Data:IsSetBonusActive(setNames.VESTMENTS_OF_TRANSCENDENCE, 3)
    elseif classId == Data.DRUID then
        return Data:IsSetBonusActive(setNames.STORMRAGE_RAIMENT, 3)
    end
end

function Data:GetSetBonusValueMP5()
    if (classId == Data.DRUID and Data:IsSetBonusActive(setNames.HARUSPEXS_GARB, 2))
        or (classId == Data.SHAMAN and Data:IsSetBonusActive(setNames.AUGURS_REGALIA, 2))
        or (classId == Data.PALADIN and Data:IsSetBonusActive(setNames.FREETHINKERS_ARMOR, 2)) then
        return 4
    end

    return 0
end

function Data:HasNatureCritBonusModifier()
    if classId == Data.SHAMAN then
        return Data:IsSetBonusActive(setNames.TEN_STORMS, 5)
    end
    return false
end

function Data:HasSetBonusModifierBlockValue()
    if classId == Data.WARRIOR then
        return Data:IsSetBonusActive(setNames.BATTLEGEAR_OF_MIGHT, 3)
    end

    return false
end

function Data:IsSetBonusActive(setName, bonusLevel)
    local setItems = itemSets[setName]
    if (not setItems) then
        return false
    end

    local equippedPieces = 0
    for slot = 1, 17 do
        local itemID = GetInventoryItemID("player", slot)
        if setItems[itemID] then
            equippedPieces = equippedPieces + 1
        end
    end
    return (equippedPieces >= bonusLevel)
end
