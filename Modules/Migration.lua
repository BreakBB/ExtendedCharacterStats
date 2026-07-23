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
    if profileVersion < 100 then
        ExtendedCharacterStats.profile.defense.stunReduction = defaultProfile.profile.defense.stunReduction
        ExtendedCharacterStats.profile.defense.snareReduction = defaultProfile.profile.defense.snareReduction
        ExtendedCharacterStats.profile.defense.rootReduction = defaultProfile.profile.defense.rootReduction
        ExtendedCharacterStats.profile.defense.disorientReduction = defaultProfile.profile.defense.disorientReduction
        ExtendedCharacterStats.profile.defense.charmReduction = defaultProfile.profile.defense.charmReduction
        ExtendedCharacterStats.profile.defense.horrorReduction = defaultProfile.profile.defense.horrorReduction
        ExtendedCharacterStats.profile.defense.fleeingReduction = defaultProfile.profile.defense.fleeingReduction
        ExtendedCharacterStats.profile.defense.interruptReduction = defaultProfile.profile.defense.interruptReduction
        ExtendedCharacterStats.profile.defense.silenceReduction = defaultProfile.profile.defense.silenceReduction
        ExtendedCharacterStats.profile.defense.poisonReduction = defaultProfile.profile.defense.poisonReduction
        ExtendedCharacterStats.profile.defense.curseReduction = defaultProfile.profile.defense.curseReduction
        ExtendedCharacterStats.profile.defense.diseaseReduction = defaultProfile.profile.defense.diseaseReduction
    end
end
