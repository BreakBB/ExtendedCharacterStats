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
    [setNames.DREADNOUGHTS_BATTLEGEAR] = {
        [236005] = true,
        [246006] = true,
        [236007] = true,
        [236008] = true,
        [236009] = true,
        [236010] = true,
        [236011] = true,
        [236012] = true,
        [236013] = true
    },
    [setNames.BONESCYTHE_LEATHERS] = {
        [236032] = true,
        [236033] = true,
        [236034] = true,
        [236035] = true,
        [236036] = true,
        [236037] = true,
        [236038] = true,
        [236039] = true,
        [236040] = true
    },
    [setNames.THE_EARTHSHATTERERS_RESOLVE] = {
        [236160] = true,
        [236162] = true,
        [236163] = true,
        [236164] = true,
        [236165] = true,
        [236166] = true,
        [236167] = true,
        [236168] = true,
        [236169] = true
    },
    [setNames.REDEMPTION_BULWARK] = {
        [236133] = true,
        [236134] = true,
        [236135] = true,
        [236136] = true,
        [236137] = true,
        [236138] = true,
        [236139] = true,
        [236140] = true,
        [236141] = true
    },
    [setNames.PLAGUEHEART_STITCHINGS] = {
        [236068] = true,
        [236069] = true,
        [236070] = true,
        [236071] = true,
        [236072] = true,
        [236073] = true,
        [236074] = true,
        [236075] = true,
        [236076] = true
    },
    [setNames.DREAMWALKER_GUARDIAN] = {
        [236201] = true,
        [236202] = true,
        [236203] = true,
        [236204] = true,
        [236205] = true,
        [236206] = true,
        [236207] = true,
        [236208] = true,
        [236209] = true
    },
}

function Data:HasSetBonusIncreasedExperise()
    if classId == Data.WARRIOR then
        return Data:IsSetBonusActive(setNames.DREADNOUGHTS_BATTLEGEAR, 2)
    elseif classId == Data.DRUID then
        return Data:IsSetBonusActive(setNames.DREAMWALKER_GUARDIAN, 2)
    elseif classId == Data.SHAMAN then
        return Data:IsSetBonusActive(setNames.THE_EARTHSHATTERERS_RESOLVE, 2)
    elseif classId == Data.PALADIN then
        return Data:IsSetBonusActive(setNames.REDEMPTION_BULWARK, 2)
    elseif classId == Data.ROGUE then
        return Data:IsSetBonusActive(setNames.BONESCYTHE_LEATHERS, 2)
    elseif classId == Data.WARLOCK then
        return Data:IsSetBonusActive(setNames.PLAGUEHEART_STITCHINGS, 2)
    end
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
