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
    if profileVersion < 26 then
        ExtendedCharacterStats.profile.general.healthRegeneration = defaultProfile.profile.general.healthRegeneration
        ExtendedCharacterStats.profile.general.healthRegenerationCombat = defaultProfile.profile.general.healthRegenerationCombat
    end
end
