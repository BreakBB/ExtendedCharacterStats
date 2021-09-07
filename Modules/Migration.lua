---@class Migration
local Migration = ECSLoader:CreateModule("Migration")

---@param profileVersion number
---@param defaultProfile table
function Migration:ToLatestProfileVersion(profileVersion, defaultProfile)
    --- Before correct migration
    if profileVersion < 6 then
        ---@class ECSProfile
        ExtendedCharacterStats.profile = defaultProfile.profile
        ExtendedCharacterStats.general = defaultProfile.general
        return
    end

    if profileVersion < 7 then
        ExtendedCharacterStats.profile.melee.attackPower.refName = "MeleeAttackPower"
        ExtendedCharacterStats.profile.melee.attackSpeed = defaultProfile.profile.melee.attackSpeed
    end

    if profileVersion < 8 then
        ExtendedCharacterStats.profile.ranged.attackSpeed = defaultProfile.profile.ranged.attackSpeed
        ExtendedCharacterStats.profile.spell.penetration = defaultProfile.profile.spell.penetration
        if ECS.IsTBC then
            ExtendedCharacterStats.profile.melee.expertise = defaultProfile.profile.melee.expertise
        end
    end

    if profileVersion < 9 then
        if ECS.IsTBC then
            ExtendedCharacterStats.profile.defense.resilience = defaultProfile.profile.defense.resilience
        end
    end

    if profileVersion < 10 then
        if ECS.IsTBC then
            ExtendedCharacterStats.profile.melee.hit.rating = defaultProfile.profile.melee.hit.rating
            ExtendedCharacterStats.profile.ranged.hit.rating = defaultProfile.profile.ranged.hit.rating
            ExtendedCharacterStats.profile.spell.hit.rating = defaultProfile.profile.spell.hit.rating
        end
    end
end
