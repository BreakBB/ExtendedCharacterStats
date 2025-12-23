---@type Data
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
    [setNames.GREEN_DRAGON_MAIL] = {
        [15045] = true,
        [15046] = true,
        [20296] = true,
    },
    [setNames.LIVING_GREEN_DRAGON_MAIL] = {
        [227877] = true,
        [227878] = true,
        [227879] = true,
    },
}

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
    if (ECS.IsSod and Data:IsSetBonusActive(setNames.LIVING_GREEN_DRAGON_MAIL, 3)) then
        mod = mod + 0.15
    end
    if (ECS.IsSod and Data:IsSetBonusActive(setNames.DAWN_OF_TRANSCENDENCE, 2)) then
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
    if (ECS.IsSod and Data:IsSetBonusActive(setNames.LIVING_GREEN_DRAGON_MAIL, 2)) then
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

function Data:HasNatureCritBonusModifier()
    if classId == Data.SHAMAN then
        return Data:IsSetBonusActive(setNames.TEN_STORMS, 5)
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
