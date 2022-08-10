---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@type Profile
local Profile = ECSLoader:ImportModule("Profile")

---@param profileVersion number
function Migration:ToLatestProfileVersion(profileVersion)
    if profileVersion < 11 then
        ---@class ECSProfile
        Profile:Reset()
        return
    end

    local defaultProfile = Profile:GetDefaultProfile()
    if profileVersion < 12 then
        ExtendedCharacterStats.profile.melee.expertiseRating = defaultProfile.profile.melee.expertiseRating
    end
    if profileVersion < 13 then
        ExtendedCharacterStats.profile.melee.hasteRating = defaultProfile.profile.melee.hasteRating
        ExtendedCharacterStats.profile.ranged.hasteRating = defaultProfile.profile.ranged.hasteRating
        ExtendedCharacterStats.profile.spell.hasteRating = defaultProfile.profile.spell.hasteRating
        ExtendedCharacterStats.profile.spell.hasteBonus = defaultProfile.profile.spell.hasteBonus
    end
    if profileVersion < 14 then
        ExtendedCharacterStats.profile.defense.avoidance = defaultProfile.profile.defense.avoidance
        ExtendedCharacterStats.profile.melee.hasteBonus = defaultProfile.profile.melee.hasteBonus
        ExtendedCharacterStats.profile.ranged.hasteBonus = defaultProfile.profile.ranged.hasteBonus
    end
    if profileVersion < 15 then
        ExtendedCharacterStats.profile.regen.mp5NotCasting = defaultProfile.profile.regen.mp5NotCasting
        ExtendedCharacterStats.profile.melee.penetration = defaultProfile.profile.melee.penetration
        ExtendedCharacterStats.profile.ranged.penetration = defaultProfile.profile.ranged.penetration
    end
    if profileVersion < 16 then
        ExtendedCharacterStats.profile.melee.penetration = defaultProfile.profile.melee.penetration
        ExtendedCharacterStats.profile.ranged.penetration = defaultProfile.profile.ranged.penetration
    end
end
