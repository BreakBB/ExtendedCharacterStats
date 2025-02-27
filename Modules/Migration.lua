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
end
