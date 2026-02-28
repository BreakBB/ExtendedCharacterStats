local ECSLoader = ECSLoader
local floor = math.floor
local GetBuffDataByIndex = C_UnitAuras.GetBuffDataByIndex
local GetCombatRating = GetCombatRating
local GetCombatRatingBonus = GetCombatRatingBonus
local GetDebuffDataByIndex = C_UnitAuras.GetDebuffDataByIndex
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemLink = GetInventoryItemLink
local IsClassic = ECS.IsClassic
local IsSoD = ECS.IsSoD
local IsSpellKnown = C_SpellBook.IsSpellKnown
local IsTBC = ECS.IsTBC
local IsWotlk = ECS.IsWotlk
local OffhandHasShield = C_PaperDollInfo.OffhandHasShield
local UnitArmor = UnitArmor
local UnitClass = UnitClass
local UnitDefense = UnitDefense
local UnitLevel = UnitLevel

---@class Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")
---@type Utils
local Utils = ECSLoader:ImportModule("Utils")

local _Defense = {}

local _, _, classId = UnitClass("player")

local MAX_SKILL = (UnitLevel("player")) * 5
-- Every 25 defense reduce the chance to be critically hit by 1 %
local DEFENSE_FOR_CRIT_REDUCTION = 25

---@return number
function Data:GetArmorValue()
    local _, effectiveArmor = UnitArmor("player")
    return DataUtils:Round(effectiveArmor, 2)
end

---@return number, number, number
function _Defense:GetCritReduction()
    local defBonus = Data:GetDefenseValue()

    local buffBonus = 0
    local meleeCritReduction = 0
    local rangedCritReduction = 0
    local spellCritReduction = 0
    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            buffBonus = buffBonus + (Data.Aura.CritReductionAll[aura.spellId] or 0)
            meleeCritReduction = meleeCritReduction + (Data.Aura.CritReductionMelee[aura.spellId] or 0)
            if IsWotlk and aura.spellId == 22812 and IsSpellKnown(63058) then
                buffBonus = buffBonus + 25 -- Glyph of Barkskin
            end
        end
    until (not aura)
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            buffBonus = buffBonus + (Data.Aura.CritReductionAll[aura.spellId] or 0)
            meleeCritReduction = meleeCritReduction + (Data.Aura.CritReductionMelee[aura.spellId] or 0)
            spellCritReduction = spellCritReduction + (Data.Aura.CritReductionSpell[aura.spellId] or 0)
            if IsWotlk and aura.spellId == 12579 then
                spellCritReduction = spellCritReduction - 1 * aura.applications -- Winter's Chill
            elseif IsSoD and aura.spellId == 1231399 then -- Legislate
                buffBonus = buffBonus - 3 * aura.applications
            end
        end
    until (not aura)

    -- Only the defense value above 350 counts towards crit immunity
    local critReductionFromDefense =  (defBonus - MAX_SKILL) / DEFENSE_FOR_CRIT_REDUCTION
    if critReductionFromDefense < 0 then
        critReductionFromDefense = 0
    end
    local critReducingFromResilience = GetCombatRatingBonus(15)

    if classId == Data.DRUID then
        local coeff = IsWotlk and 2 or 1
        meleeCritReduction = meleeCritReduction + coeff * DataUtils:GetActiveTalentSpell({33853,33855,33856}) -- Survival of the Fittest
    elseif classId == Data.PRIEST then
        if IsTBC then
            spellCritReduction = spellCritReduction + 2 * DataUtils:GetActiveTalentSpell({14910,33371})  -- shadow resilience
        end
    elseif classId == Data.ROGUE then
        local mod = 1 * DataUtils:GetActiveTalentSpell({30892,30893}) -- Sleight of Hand
        meleeCritReduction = meleeCritReduction + mod
        rangedCritReduction = rangedCritReduction + mod
    elseif classId == Data.WARLOCK then
        if not IsClassic then
            local mod = 1 * DataUtils:GetActiveTalentSpell({30319,30320,30321}) -- Demonic Resilience
            meleeCritReduction = meleeCritReduction + mod
            rangedCritReduction = rangedCritReduction + mod
        end
    end

    if IsSoD then
        if classId == Data.DRUID or classId == Data.ROGUE then
            local chestRune = DataUtils.GetRuneForEquipSlot(Utils.CHAR_EQUIP_SLOTS.Chest)
            if chestRune and (chestRune == 6710 or chestRune == 6972) then
                meleeCritReduction = meleeCritReduction + 6 -- survival of the fittest / Just a Flesh Wound
            end
        end
    end

    meleeCritReduction = meleeCritReduction + critReductionFromDefense + critReducingFromResilience + buffBonus
    rangedCritReduction = rangedCritReduction + critReductionFromDefense + critReducingFromResilience + buffBonus
    spellCritReduction = spellCritReduction + critReducingFromResilience + buffBonus

    return meleeCritReduction, rangedCritReduction, spellCritReduction
end

---@return string
function Data:GetMeleeCritReduction()
    local melee, _, _ = _Defense:GetCritReduction()
    return DataUtils:Round(melee, 2) .. "%"
end

---@return string
function Data:GetRangedCritReduction()
    local _, ranged, _ = _Defense:GetCritReduction()
    return DataUtils:Round(ranged, 2) .. "%"
end

---@return string
function Data:GetSpellCritReduction()
    local _, _, spell = _Defense:GetCritReduction()
    return DataUtils:Round(spell, 2) .. "%"
end

---@param enemyLevel number
---@return number
function _Defense:GetEnemyMissChance(enemyLevel)
    local enemyAttackRating = enemyLevel * 5

    local miss
    if IsWotlk then
        local defense = floor(GetCombatRatingBonus(CR_DEFENSE_SKILL))
        local enemyMissCoef = classId == Data.DRUID and 0.972 or 0.956 -- 0.972 for bears
        local baseMissChance = 5 - (enemyAttackRating - select(1, UnitDefense("player"))) * 0.04 -- vs lvl 80
        if defense > 0 then -- avoid possible division by 0
            local enemyMissChance = baseMissChance + 1 / (0.0625 + enemyMissCoef / (defense * 0.04))
            miss = enemyMissChance
        else
            miss = baseMissChance
        end
    else
        local defense = Data:GetDefenseValue()
        local enemyMissChance = 5 + (((defense) - enemyAttackRating) * .04)
        miss = enemyMissChance
    end
    return miss
end

---@return number
function _Defense:GetBlockChance()
    local block = 0
    if IsSpellKnown(107) and OffhandHasShield() then
       block = GetBlockChance()
    end
    return block
end

---@return number
function _Defense:GetParryChance()
    local parry = 0
    if IsSpellKnown(3127) or IsSpellKnown(18848) or IsSpellKnown(3124) then
        parry = GetParryChance()
    end
    return parry
end

---@return number
function _Defense:GetDodgeChance()
    local dodge = 0
    if IsSpellKnown(81) then
        dodge = GetDodgeChance()
    end
    return dodge
end

---@param enemyLevel number
---@return number
function _Defense:GetAvoidance(enemyLevel)
    return _Defense:GetEnemyMissChance(enemyLevel) + _Defense:GetBlockChance() + _Defense:GetParryChance() + _Defense:GetDodgeChance()
end

---@return number
function Data:GetDefenseRating()
    if (not CR_DEFENSE_SKILL) then
        return 0
    end

    return DataUtils:Round(GetCombatRating(CR_DEFENSE_SKILL), 2)
end

---@return number
function Data:GetDefenseValue()
    local skillRank, skillModifier = UnitDefense("player")
    return skillRank + skillModifier
end

---@return string
function Data:GetDodgeChance()
    return DataUtils:Round(_Defense:GetDodgeChance(), 2) .. "%"
end

---@return string
function Data:GetParryChance()
    return DataUtils:Round(_Defense:GetParryChance(), 2) .. "%"
end

---@return string
function Data:GetBlockChance()
    return DataUtils:Round(_Defense:GetBlockChance(), 2) .. "%"
end

---@param enemyLevel number
---@return string
function Data:GetAvoidance(enemyLevel)
    return DataUtils:Round(_Defense:GetAvoidance(enemyLevel), 2) .. "%"
end

---@return number
function Data:GetBlockValue()
    local blockValue = 0
    if IsSpellKnown(107) and OffhandHasShield() then
        blockValue = blockValue + GetShieldBlock() + _Defense:GetEnchantsBlockValue()
    end
    return DataUtils:Round(blockValue, 2)
end

---@return number
function Data:GetResilienceRating()
    return DataUtils:Round(GetCombatRating(15), 2)
end

---@return number
function _Defense:GetEnchantsBlockValue()
    local mod = 0
    for i = 1, 18 do
        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            local enchant = DataUtils:GetEnchantFromItemLink(itemLink)
            if enchant then
                mod = mod + (Data.Enchant.BlockValue[itemLink] or 0)
            end
        end
    end
    return mod
end

---@return table<number>
function Data:GetMechanicResistance()
    local resistance = {
        ["charm"] = 0,
        ["curse"] = 0,
        ["disease"] = 0,
        ["disorient"] = 0,
        ["fleeing"] = 0,
        ["horror"] = 0,
        ["interrupt"] = 0,
        ["poison"] = 0,
        ["root"] = 0,
        ["silence"] = 0,
        ["snare"] = 0,
        ["stun"] = 0,
    }

    if IsSpellKnown(20573) then -- Hardiness
        if IsClassic then
            resistance.stun = resistance.stun + 25
        elseif IsTBC then
            resistance.stun = resistance.stun + 15
        end
    end

    for i = 1, 18 do
        local id, _ = GetInventoryItemID("player", i)
        resistance.disorient = resistance.disorient + (Data.Item.ResistDisorient[id] or 0)
        resistance.fleeing = resistance.fleeing + (Data.Item.ResistFleeing[id] or 0)
        resistance.silence = resistance.silence + (Data.Item.ResistSilence[id] or 0)
        resistance.stun = resistance.stun + (Data.Item.ResistStun[id] or 0)

        local itemLink = GetInventoryItemLink("player", i)
        if itemLink then
            -- Check for socketed gems (TODO: check for socket bonus)
            local gems = DataUtils:GetSocketedGemsFromItemLink(itemLink)
            if gems then
                for j = 1, 3 do
                    if gems[j] then
                        resistance.root = resistance.root + (Data.Gem.ResistRoot[gems[j]] or 0)
                        resistance.snare = resistance.snare + (Data.Gem.ResistRoot[gems[j]] or 0)
                        resistance.stun = resistance.stun + (Data.Gem.ResistStun[gems[j]] or 0)
                    end
                end
            end
        end
    end

    local i = 1
    repeat
        local aura = GetBuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            resistance.interrupt = resistance.interrupt + (Data.Aura.ResistInterrupt[aura.spellId] or 0)
            -- if aura.spellId == 19746 then
            --     TODO: improved concentration aura
            --     resistance.silence = resistance.silence + (IsWotlk and 0 or 15)  -- Concentration Aura
            --     resistance.interrupt
            -- end
        end
    until not aura
    i = 1
    repeat
        local aura = GetDebuffDataByIndex("player", i)
        i = i + 1
        if aura and aura.spellId then
            if aura.spellId == 27182 then -- Nether Affliction
                resistance.fleeing = resistance.fleeing - 10
                resistance.horror = resistance.horror - 10
            end
        end
    until not aura

    if not IsWotlk then
        if classId == Data.DRUID then
            local mod = 5 * DataUtils:GetActiveTalentSpell({ 33851, 33852, 33957 }) -- Primal Tenacity
            resistance.stun = resistance.stun + mod
            resistance.fleeing = resistance.fleeing + mod
        elseif classId == Data.HUNTER then
            local mod = 5 * DataUtils:GetActiveTalentSpell({ 19290, 19294, 24283 }) -- Surefooted
            resistance.root = resistance.root + mod
            resistance.snare = resistance.snare + mod
        elseif classId == Data.PALADIN then
            resistance.stun = resistance.stun + 5 * DataUtils:GetActiveTalentSpell({ 31844, 31845 }) -- Stoicism
            local mod = 5 * DataUtils:GetActiveTalentSpell({ 9453, 25836 }) -- Unyielding Faith
            resistance.disorient = resistance.disorient + mod
            resistance.fleeing = resistance.fleeing + mod
            mod = 5 * DataUtils:GetActiveTalentSpell({ 31822, 31823, 31824 }) -- Pure of Heart
            resistance.curse = resistance.curse + mod
            resistance.disease = resistance.disease + mod
        elseif classId == Data.PRIEST then
            local mod = 3 * DataUtils:GetActiveTalentSpell({ 14522, 14788, 14789, 14790, 14791 }) -- Unbreakable Will
            resistance.stun = resistance.stun + mod
            resistance.fleeing = resistance.fleeing + mod
            resistance.silence = resistance.silence + mod
        elseif classId == Data.ROGUE then
            resistance.poison = resistance.poison + 15 * DataUtils:GetActiveTalentSpell({ 31226, 31227 }) -- Master Poisoner
            local mod = 5 * DataUtils:GetActiveTalentSpell({ 31208, 31209 }) -- Fleet Footed
            resistance.root = resistance.root + mod
            resistance.snare = resistance.snare + mod
            mod = 5 * DataUtils:GetActiveTalentSpell({ 31130, 31131 }) -- Nerves of Steel
            resistance.stun = resistance.stun + mod
            resistance.fleeing = resistance.fleeing + mod
        elseif classId == Data.SHAMAN then
            if IsClassic then
                local mod = 5 * DataUtils:GetActiveTalentSpell({ 30864, 30865, 30866 }) -- Focused Mind
                resistance.interrupt = resistance.interrupt + mod
                resistance.silence = resistance.silence + mod
            end
        elseif classId == Data.WARRIOR then
            local mod = 3 * DataUtils:GetActiveTalentSpell({ 12300, 12959, 12960, 12961, 12962 }) -- Iron Will
            resistance.stun = resistance.stun + mod
            resistance.charm = resistance.charm + mod
        end
    end
    return resistance
end
