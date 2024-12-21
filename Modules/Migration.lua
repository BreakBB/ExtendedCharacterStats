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
            ExtendedCharacterStats.profile.spellBonus.arcaneHitBonus = defaultProfile.profile.spellBonus.arcaneHitBonus
            ExtendedCharacterStats.profile.spellBonus.arcaneMissChance = defaultProfile.profile.spellBonus.arcaneMissChance
            ExtendedCharacterStats.profile.spellBonus.arcaneMissChanceBoss = defaultProfile.profile.spellBonus.arcaneMissChanceBoss

            ExtendedCharacterStats.profile.spellBonus.fireHitBonus = defaultProfile.profile.spellBonus.fireHitBonus
            ExtendedCharacterStats.profile.spellBonus.fireMissChance = defaultProfile.profile.spellBonus.fireMissChance
            ExtendedCharacterStats.profile.spellBonus.fireMissChanceBoss = defaultProfile.profile.spellBonus.fireMissChanceBoss

            ExtendedCharacterStats.profile.spellBonus.frostHitBonus = defaultProfile.profile.spellBonus.frostHitBonus
            ExtendedCharacterStats.profile.spellBonus.frostMissChance = defaultProfile.profile.spellBonus.frostMissChance
            ExtendedCharacterStats.profile.spellBonus.frostMissChanceBoss = defaultProfile.profile.spellBonus.frostMissChanceBoss
        end
    end
end
