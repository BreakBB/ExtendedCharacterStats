---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@type Profile
local Profile = ECSLoader:ImportModule("Profile")
---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

---@param profileVersion number
function Migration:ToLatestProfileVersion(profileVersion)
    if profileVersion < 23 then
        ---@class ECSProfile
        Profile:Reset()
        ECS:Print(i18n("Profile has been reset due to a major update.")) -- because of TBC anniversary
        return
    end

    local defaultProfile = Profile:GetDefaultProfile()

    if profileVersion < 24 then
        ExtendedCharacterStats.profile.defense.resilienceRating = ExtendedCharacterStats.profile.defense.resilience
        ExtendedCharacterStats.profile.defense.resilience = nil
    end
    if profileVersion < 25 then
        ExtendedCharacterStats.profile.defense.resilience = nil
    end
    if profileVersion < 25 then
        ExtendedCharacterStats.profile.defense.resilience = ExtendedCharacterStats.profile.defense.resilience
        ExtendedCharacterStats.profile.defense.resilienceRating = ExtendedCharacterStats.profile.defense.resilienceRating
        ExtendedCharacterStats.profile.spell.miss = defaultProfile.profile.spell.miss
        ExtendedCharacterStats.profile.defense.critReduction = defaultProfile.profile.defense.critReduction
        ExtendedCharacterStats.profile.defense.blockRating = defaultProfile.profile.defense.blockRating
        ExtendedCharacterStats.profile.melee.critRating = defaultProfile.profile.melee.critRating
        ExtendedCharacterStats.profile.melee.penetration = defaultProfile.profile.melee.penetration
        ExtendedCharacterStats.profile.melee.penetrationRating = defaultProfile.profile.melee.penetrationRating
        ExtendedCharacterStats.profile.ranged.critRating = defaultProfile.profile.ranged.critRating
        ExtendedCharacterStats.profile.ranged.penetration = defaultProfile.profile.ranged.penetration
        ExtendedCharacterStats.profile.ranged.penetrationRating = defaultProfile.profile.ranged.penetrationRating
        ExtendedCharacterStats.profile.spell.crit.rating = defaultProfile.profile.spell.crit.rating
        ExtendedCharacterStats.profile.spell.penetration = defaultProfile.profile.spell.penetration
        ExtendedCharacterStats.profile.spell.penetrationRating = defaultProfile.profile.spell.penetrationRating
    end
end
