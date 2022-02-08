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
end
