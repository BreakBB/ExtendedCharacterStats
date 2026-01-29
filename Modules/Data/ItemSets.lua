---@class Data
local Data = ECSLoader:ImportModule("Data")

local _, _, classId = UnitClass("player")
local setNames = Data.setNames

local itemSets = {
    [setNames.AUGURS_REGALIA] = {
        [19609] = true,
        [19828] = true,
        [19829] = true,
        [19830] = true,
        [19956] = true
    },
    [setNames.BLOODSOUL_EMBRACE] = {
        [19690] = true,
        [19691] = true,
        [19692] = true,
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
    [setNames.DAWN_OF_TRANSCENDENCE] = {
        [231155] = true,
        [231156] = true,
        [231157] = true,
        [231158] = true,
        [231159] = true,
        [231160] = true,
        [231161] = true,
        [231162] = true,
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
    [setNames.FEL_IRON_CHAIN] = {
        [23490] = true,
        [23491] = true,
        [23494] = true,
        [23493] = true,
    },
    [setNames.FREETHINKERS_ARMOR] = {
        [19588] = true,
        [19825] = true,
        [19826] = true,
        [19827] = true,
        [19952] = true
    },
    [setNames.GREEN_DRAGON_MAIL] = {
        [15045] = true,
        [15046] = true,
        [20296] = true,
    },
    [setNames.HARUSPEXS_GARB] = {
        [19613] = true,
        [19838] = true,
        [19839] = true,
        [19840] = true,
        [19955] = true,
    },
    [setNames.LIVING_GREEN_DRAGON_MAIL] = {
        [227877] = true,
        [227878] = true,
        [227879] = true,
    },
    [setNames.PRIMAL_MOONCLOTH] = {
        [21873] = true,
        [21874] = true,
        [21875] = true,
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
    [setNames.STORMRAGE_RAIMENT] = {
        [16897] = true,
        [16898] = true,
        [16899] = true,
        [16900] = true,
        [16901] = true,
        [16902] = true,
        [16903] = true,
        [16904] = true,
    },
    [setNames.SYMBOLS_OF_UNENDING_LIFE] = {
        [233417] = true,
        [233418] = true,
        [233419] = true
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
        [22464] = true,
        [22465] = true,
        [22466] = true,
        [22467] = true,
        [22468] = true,
        [22469] = true,
        [22470] = true,
        [22471] = true,
        [23065] = true
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
    [setNames.WINDHAWK_ARMOR] = {
        [29522] = true,
        [29523] = true,
        [29524] = true,
    },
}

function Data:HasSetBonusIncreasedExpertise2()
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

function Data:HasSetBonusIncreasedExpertise5()
    if classId == Data.DRUID then
        return Data:IsSetBonusActive(setNames.SYMBOLS_OF_UNENDING_LIFE, 3)
    end
end

---@return number
function Data:GetSetBonusModifierMP5()
    local mod = 0
    if (ECS.IsClassic and Data:IsSetBonusActive(setNames.GREEN_DRAGON_MAIL, 3)) then
        mod = mod + 0.15
    end
    if (ECS.IsClassic and (
        (classId == Data.DRUID and Data:IsSetBonusActive(setNames.STORMRAGE_RAIMENT, 3)) or
        (classId == Data.PRIEST and Data:IsSetBonusActive(setNames.VESTMENTS_OF_TRANSCENDENCE, 3))
    )) then
        mod = mod + 0.15
    end
    if (ECS.IsSoD and Data:IsSetBonusActive(setNames.LIVING_GREEN_DRAGON_MAIL, 3)) then
        mod = mod + 0.15
    end
    if (ECS.IsSoD and Data:IsSetBonusActive(setNames.DAWN_OF_TRANSCENDENCE, 2)) then
        mod = mod + 0.15
    end
    if Data:IsSetBonusActive(setNames.PRIMAL_MOONCLOTH, 3) then
        mod = mod + 0.05
    end
    return mod
end

---@return number
function Data:GetSetBonusValueMP5()
    local bonus = 0
    if (classId == Data.DRUID and Data:IsSetBonusActive(setNames.HARUSPEXS_GARB, 2)) or
        (classId == Data.SHAMAN and Data:IsSetBonusActive(setNames.AUGURS_REGALIA, 2)) or
        (classId == Data.PALADIN and Data:IsSetBonusActive(setNames.FREETHINKERS_ARMOR, 2)
    ) then
        bonus = bonus + (ECS.IsWotlk and 5 or 4)
    end
    if (ECS.IsSoD and Data:IsSetBonusActive(setNames.LIVING_GREEN_DRAGON_MAIL, 2)) then
        bonus = bonus + 3
    end
    if Data:IsSetBonusActive(setNames.GREEN_DRAGON_MAIL, 2) then
        bonus = bonus + (ECS.IsWotlk and 4 or 3)
    end
    if (not ECS.IsClassic and Data:IsSetBonusActive(setNames.GREEN_DRAGON_MAIL, 3)) then
        bonus = bonus + (ECS.IsWotlk and 25 or 20)
    end
    if (not ECS.IsClassic and (
            (classId == Data.DRUID and Data:IsSetBonusActive(setNames.STORMRAGE_RAIMENT, 3)) or
            (classId == Data.PRIEST and Data:IsSetBonusActive(setNames.VESTMENTS_OF_TRANSCENDENCE, 3))
        )
    ) then
        bonus = bonus + (ECS.IsWotlk and 25 or 20)
    end
    if Data:IsSetBonusActive(setNames.BLOODSOUL_EMBRACE, 3) then
        bonus = bonus + (ECS.IsWotlk and 15 or 12)
    end
    if Data:IsSetBonusActive(setNames.FEL_IRON_CHAIN, 4) then
        bonus = bonus + (ECS.IsWotlk and 10 or 8)
    end
    if Data:IsSetBonusActive(setNames.WINDHAWK_ARMOR, 3) then
        bonus = bonus + (ECS.IsWotlk and 10 or 8)
    end
    return bonus
end

---@return boolean
function Data:HasNatureCritBonusModifier()
    if classId == Data.SHAMAN then
        return Data:IsSetBonusActive(setNames.TEN_STORMS, 5)
    end
    return false
end

---@param setName string
---@param bonusLevel number
---@return boolean
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
