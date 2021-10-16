---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@param profileVersion number
---@param defaultProfile table
function Migration:ToLatestProfileVersion(profileVersion, defaultProfile)
    if profileVersion < 11 then
        ---@class ECSProfile
        ExtendedCharacterStats.profile = defaultProfile.profile
        ExtendedCharacterStats.general = defaultProfile.general
        return
    end
end
