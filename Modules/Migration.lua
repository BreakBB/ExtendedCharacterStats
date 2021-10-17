---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@type Profile
local Profile = ECSLoader:ImportModule("Profile")

---@param profileVersion number
---@param defaultProfile table
function Migration:ToLatestProfileVersion(profileVersion)
    if profileVersion < 11 then
        ---@class ECSProfile
        Profile:Reset()
        return
    end
end
