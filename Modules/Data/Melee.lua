---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Melee = {}
local _, _, classId = UnitClass("player")

---@return string
function Data:GetMeleeAttackPower()
    local melee, posBuff, negBuff = UnitAttackPower("player")
    return melee + posBuff + negBuff
end

---@return string
function Data:GetMeleeAttackSpeedMainHand()
    local mainHand, _ = UnitAttackSpeed("player")
    return DataUtils:Round(mainHand, 2)
end

---@return string
function Data:GetMeleeAttackSpeedOffHand()
    local _, offHand = UnitAttackSpeed("player")
    return DataUtils:Round(offHand, 2)
end

---@return string
function Data:MeleeCrit()
    return DataUtils:Round(GetCritChance(), 2) .. "%"
end

---@return string
function Data:MeleeHitBonus()
    return DataUtils:Round(_Melee:GetHitRatingBonus(), 2) .. "%"
end

---@return number
function Data:MeleeHitRating()
    return GetCombatRating(CR_HIT_MELEE)
end

---@return number
function _Melee:GetHitRatingBonus()
    if CR_HIT_MELEE then
        return GetCombatRatingBonus(CR_HIT_MELEE) + _Melee:GetHitTalentBonus() + _Melee:GetHitFromBuffs()
    end
    -- GetHitModifier returns nil on dungeon entering/teleport
    return (GetHitModifier() or 0) + _Melee.GetHitFromRunes()
end

function _Melee:GetHitTalentBonus()
    local mod = 0

    if classId == Data.WARRIOR and ECS.IsWotlk then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 18)
        mod = points * 1 -- 0-3% Precision
    end

    if ECS.IsWotlk and classId == Data.HUNTER then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 27)
        mod = points * 1 -- 0-3% Focused Aim
    end

    if classId == Data.SHAMAN then
        if ECS.IsWotlk then
            if Data:GetMeleeAttackSpeedOffHand() > 0 then
                local _, _, _, _, dualWielding, _, _, _ = GetTalentInfo(2, 19)
                mod = mod + dualWielding * 2 -- 0-6% Dual Wielding Specialization
            end
        else
            local _, _, _, _, naturesGuidance, _, _, _ = GetTalentInfo(3, 3)
            mod = naturesGuidance * 1 -- 0-3% Nature's Guidance
        end
    end

    if ECS.IsTBC and classId == Data.PALADIN then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 15)
        mod = points * 1 -- 0-3% Precision
    end

    if classId == Data.ROGUE then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 1)
        mod = points * 1 -- 0-5% Precision
    end

    -- This assumes a DK is dual wielding and not only using a one-hand main hand weapon
    if classId == Data.DEATHKNIGHT and Data:GetMeleeAttackSpeedOffHand() > 0 then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(2, 16)
        mod = points * 1 -- 0-3% Nerves of Cold Steel
    end

    return mod
end

function _Melee:GetHitFromBuffs()
    local mod = 0
    local otherDraeneiInGroup = false

    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId, _ = UnitAura("player", i, "HELPFUL")
        if spellId == nil then
            break
        end

        if spellId == 6562 then
            mod = mod + 1 -- 1% from Heroic Presence
            otherDraeneiInGroup = true
        end
    end

    if (not otherDraeneiInGroup) and (IsSpellKnown(6562) or IsSpellKnown(28878)) then
        mod = mod + 1
    end

    return mod
end

function _Melee.GetHitFromRunes()
    local mod = 0

    if (not ECS.IsSoD) then
        return mod
    end

    local finger1Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger1)
    local finger2Rune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Finger2)

    if classId == Data.DRUID and (finger1Rune == 51245 or finger2Rune == 51245) and DataUtils:IsShapeshifted() then
        mod = mod + 3 -- 3% from Feral Combat Specialization Rune
    end

    return mod
end

---@return string
function Data:MeleeHitMissChanceSameLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = playerLevel * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = 5
    else
        missChance = DataUtils.GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    if Data:GetMeleeAttackSpeedOffHand() > 0 then
        missChance = missChance + 19;
    end

    local hitValue = _Melee:GetHitRatingBonus()
    missChance = missChance - hitValue

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

---@return string
function Data:MeleeHitMissChanceBossLevel()
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + 3) * 5

    local missChance
    if DataUtils:IsShapeshifted() then
        missChance = ECS.IsWotlk and 8 or 9
    else
        missChance = DataUtils.GetMissChanceByDifference(mainBase + mainMod, enemyDefenseValue)
    end

    if Data:GetMeleeAttackSpeedOffHand() > 0 then
        missChance = missChance + 19;
    end

    local hitValue = _Melee:GetHitRatingBonus()
    missChance = missChance - hitValue

    if missChance < 0 then
        missChance = 0
    elseif missChance > 100 then
        missChance = 100
    end

    return DataUtils:Round(missChance, 2) .. "%"
end

function Data:GlanceHitChanceSameLevel()
    return Data:GlanceHitChanceByLevel(0)
end

function Data:GlanceHitChanceBossLevel()
    return Data:GlanceHitChanceByLevel(3)
end

---@return string
function Data:GlanceHitChanceByLevel(level)
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + level) * 5

    local glancingChance = DataUtils:GetGlancingChanceByDifference(playerLevel, mainBase + mainMod, enemyDefenseValue)

    return DataUtils:Round(glancingChance*100, 2) .. "%"
end

function Data:GlanceDamageSameLevel()
    return Data:GlanceDamageByLevel(0)
end

function Data:GlanceDamageBossLevel()
    return Data:GlanceDamageByLevel(3)
end
---@return string
function Data:GlanceDamageByLevel(level)
    local mainBase, mainMod, _, _ = UnitAttackBothHands("player")
    local playerLevel = UnitLevel("player")
    local enemyDefenseValue = (playerLevel + level) * 5

    local glancePenalty = DataUtils:GetGlancingDamage(mainBase + mainMod, enemyDefenseValue)

    return DataUtils:Round(glancePenalty*100, 2) .. "%"
end
---@return number
function Data:GetExpertise()
    local expertise, _ = GetExpertise()

	if ECS.IsSoD then
		local increased_expertise_2 = {233640, 234985, 236300, 233614}
		for _, itemId in pairs(increased_expertise_2) do
			if C_Item.IsEquippedItem(itemId) then
				expertise = expertise + 2
			end
		end

		local increased_expertise_1 = {233585, 234650, 233397, 233693, 233692, 233401, 233689, 236130, 236056, 236022, 233635, 237512, 236034, 236032, 236030, 236023, 236039, 236038, 236036, 236035, 236037, 236026, 236031, 236033, 236029, 236040, 235888, 233651, 233658, 233376, 236051, 236055, 236052, 236050, 236054, 233634, 234984, 233659, 233662, 233663, 233661, 234748, 236020, 236012, 236005, 236010, 236019, 236007, 236016, 236006, 236008, 236009, 236011, 236021, 236209, 236201, 236206, 236215, 236205, 236204, 236203, 236208, 236211, 236212, 236218, 236202, 236210, 236171, 236172, 236175, 236174, 236170, 233637, 233582, 233711, 233412, 233413, 233415, 236222, 236309, 233579, 233618, 236339, 237275, 236260, 236319, 233992, 236139, 236207, 233642, 236304, 236262, 233612, 236125, 236133, 236141, 236137, 236138, 236129, 236128, 236136, 236135, 236140, 236124, 236134, 236013, 233600, 233442, 235005, 236216, 236176, 236311, 233699, 233700, 233668, 233665, 233666, 236306, 236341, 236293, 236263, 236255}
		for _, itemId in pairs(increased_expertise_1) do
			if C_Item.IsEquippedItem(itemId) then
				expertise = expertise + 1
			end
		end

		local timeworn_expertise = {234018, 234022, 234027, 234031, 234035}
		for _, itemId in pairs(timeworn_expertise) do
			if C_Item.IsEquippedItem(itemId) then
				expertise = expertise + 1 * timeworn
			end
		end

		if Data:HasSetBonusIncreasedExpertise() then
			expertise = expertise + 2
		end

		if classId == Data.DRUID then
		end
	end

    return DataUtils:Round(expertise, 0)
end

---@return number
function Data:GetExpertiseRating()
    local expertiseRating = GetCombatRating(CR_EXPERTISE)
    return DataUtils:Round(expertiseRating, 0)
end

---@return string
function Data:GetArmorPenetration()
    local armorPenetration = GetArmorPenetration()

    if ECS.IsWotlk and classId == Data.WARRIOR then
        local _, isActive = GetShapeshiftFormInfo(1)
        if isActive then
            armorPenetration = armorPenetration + 10 -- 10% from Battle Stance
        end
    end

    if classId == Data.DEATHKNIGHT then
        local _, _, _, _, points, _, _, _ = GetTalentInfo(1, 24)
        armorPenetration = armorPenetration + points * 2 -- 0-10% Blood Gorged
    end

    return DataUtils:Round(armorPenetration, 2) .. "%"
end

---@return string
function Data:GetArmorPenetrationRating()
    local armorPenetrationRating = GetCombatRating(CR_ARMOR_PENETRATION)
    return DataUtils:Round(armorPenetrationRating, 0)
end

---@return number
function Data:GetMeleeHasteRating()
    local hasteRating = GetCombatRating(CR_HASTE_MELEE)
    return DataUtils:Round(hasteRating, 0)
end

---@return string
function Data:GetMeleeHasteBonus()
    local hasteBonus = GetCombatRatingBonus(CR_HASTE_MELEE)
    return DataUtils:Round(hasteBonus, 2) .. "%"
end

