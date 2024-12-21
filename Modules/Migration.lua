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
    if profileVersion < 17 then
        ExtendedCharacterStats.profile.melee.penetration.text = defaultProfile.profile.melee.penetration.text
        ExtendedCharacterStats.profile.ranged.penetration.text = defaultProfile.profile.ranged.penetration.text
        ExtendedCharacterStats.profile.melee.penetrationRating = defaultProfile.profile.melee.penetrationRating
        ExtendedCharacterStats.profile.ranged.penetrationRating = defaultProfile.profile.ranged.penetrationRating
    end
    if profileVersion < 18 then
        ExtendedCharacterStats.profile.defense.defenseRating.isTbcOnly = true
    end
    if profileVersion < 19 then
        ExtendedCharacterStats.profile.melee.glance = defaultProfile.profile.melee.glance
    end
    if profileVersion < 20 then
        ExtendedCharacterStats.profile.spell.crit = nil
        if (not ECS.IsWotlk) then
            ExtendedCharacterStats.profile.spell.hit.arcaneHitBonus = defaultProfile.profile.spell.hit.arcaneHitBonus
            ExtendedCharacterStats.profile.spell.hit.arcaneMissChance = defaultProfile.profile.spell.hit.arcaneMissChance
            ExtendedCharacterStats.profile.spell.hit.arcaneMissChanceBoss = defaultProfile.profile.spell.hit.arcaneMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.fireHitBonus = defaultProfile.profile.spell.hit.fireHitBonus
            ExtendedCharacterStats.profile.spell.hit.fireMissChance = defaultProfile.profile.spell.hit.fireMissChance
            ExtendedCharacterStats.profile.spell.hit.fireMissChanceBoss = defaultProfile.profile.spell.hit.fireMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.frostHitBonus = defaultProfile.profile.spell.hit.frostHitBonus
            ExtendedCharacterStats.profile.spell.hit.frostMissChance = defaultProfile.profile.spell.hit.frostMissChance
            ExtendedCharacterStats.profile.spell.hit.frostMissChanceBoss = defaultProfile.profile.spell.hit.frostMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.holyHitBonus = defaultProfile.profile.spell.hit.holyHitBonus
            ExtendedCharacterStats.profile.spell.hit.holyMissChance = defaultProfile.profile.spell.hit.holyMissChance
            ExtendedCharacterStats.profile.spell.hit.holyMissChanceBoss = defaultProfile.profile.spell.hit.holyMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.natureHitBonus = defaultProfile.profile.spell.hit.natureHitBonus
            ExtendedCharacterStats.profile.spell.hit.natureMissChance = defaultProfile.profile.spell.hit.natureMissChance
            ExtendedCharacterStats.profile.spell.hit.natureMissChanceBoss = defaultProfile.profile.spell.hit.natureMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.physicalHitBonus = defaultProfile.profile.spell.hit.physicalHitBonus
            ExtendedCharacterStats.profile.spell.hit.physicalMissChance = defaultProfile.profile.spell.hit.physicalMissChance
            ExtendedCharacterStats.profile.spell.hit.physicalMissChanceBoss = defaultProfile.profile.spell.hit.physicalMissChanceBoss

            ExtendedCharacterStats.profile.spell.hit.shadowHitBonus = defaultProfile.profile.spell.hit.shadowHitBonus
            ExtendedCharacterStats.profile.spell.hit.shadowMissChance = defaultProfile.profile.spell.hit.shadowMissChance
            ExtendedCharacterStats.profile.spell.hit.shadowMissChanceBoss = defaultProfile.profile.spell.hit.shadowMissChanceBoss
        end
    end
end
