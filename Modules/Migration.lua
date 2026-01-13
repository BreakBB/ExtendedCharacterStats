---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@type Profile
local Profile = ECSLoader:ImportModule("Profile")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

---@param profileVersion number
function Migration:ToLatestProfileVersion(profileVersion)
    if profileVersion < 20 then
        ---@class ECSProfile
        Profile:Reset()
        ECS:Print(i18n("Profile has been reset due to a major update.")) -- v4.0.0 because of major spell restructuring
        return
    end

    local defaultProfile = Profile:GetDefaultProfile()
    if profileVersion < 21 then
        ExtendedCharacterStats.general.qualityColorsIntensity = defaultProfile.general.qualityColorsIntensity
    end
    if profileVersion < 22 then
        ExtendedCharacterStats.profile.defense.meleeCritReduction = defaultProfile.profile.defense.meleeCritReduction
        ExtendedCharacterStats.profile.defense.rangedCritReduction = defaultProfile.profile.defense.rangedCritReduction
        ExtendedCharacterStats.profile.defense.spellCritReduction = defaultProfile.profile.defense.spellCritReduction
        ExtendedCharacterStats.profile.defense.avoidanceBoss = defaultProfile.profile.defense.avoidanceBoss

        ExtendedCharacterStats.profile.defense.critImmunity = nil
        ExtendedCharacterStats.profile.defense.critReduction = nil
    end
    if profileVersion < 23 then
        ExtendedCharacterStats.profile.defense.defenseRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.defense.resilience.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.expertise.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.expertiseRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.hasteBonus.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.hasteRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.hit.Rating.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.penetration.isTbcOnly = nil
        ExtendedCharacterStats.profile.melee.penetrationRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.ranged.hasteBonus.isTbcOnly = nil
        ExtendedCharacterStats.profile.ranged.hasteRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.ranged.hit.rating.isTbcOnly = nil
        ExtendedCharacterStats.profile.ranged.penetration.isTbcOnly = nil
        ExtendedCharacterStats.profile.ranged.penetrationRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.spell.hasteBonus.isTbcOnly = nil
        ExtendedCharacterStats.profile.spell.hasteRating.isTbcOnly = nil
        ExtendedCharacterStats.profile.spell.hit.rating.isTbcOnly = nil
    end
end
