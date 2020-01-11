------------------------------------------------------------------
-- Namespaces
------------------------------------------------------------------

local _, core = ...
core.ECSData = { }

local ECSData = core.ECSData

------------------------------------------------------------------
-- Data functions
------------------------------------------------------------------

-- Rounds every number down to 2 decimal places
function ECSData:Round(num)
    if not num then
        return 0
    end
    local mult = 10^(2)
    return math.floor(num * mult + 0.5) / mult
end

-- Gets the current bonus hit chance
function ECSData:HitModifier()
    return ECSData:Round(GetHitModifier()) .. "%"
end

function ECSData:SpellHitModifier()
    return ECSData:Round(GetSpellHitModifier()) .. "%"
end

-- Get current mana regen
function ECSData:ManaRegenCurrent()
    return ECSData:Round(GetPowerRegen()) * 5
end

-- Get manaregen while not casting
function ECSData:ManaRegenNotCasting()
    local base, casting = GetManaRegen() -- Returns mana reg per 1 second
    return ECSData:Round(base) * 5
end

-- Get manaregen while casting
function ECSData:ManaRegenCasting()
    local base, casting = GetManaRegen() -- Returns mana reg per 1 second
    return ECSData:Round(casting) * 5
end

-- Get melee crit chance
function ECSData:MeleeCrit()
    return ECSData:Round(GetCritChance()) .. "%"
end

-- Get spell crit chance
function ECSData:SpellCrit()
    return ECSData:Round(GetSpellCritChance()) .. "%"
end

-- Get ranged crit chance
function ECSData:RangedCrit()
    return ECSData:Round(GetRangedCritChance()) .. "%"
end

-- Get spell penetration %
function ECSData:SpellPenetration()
    return ECSData:Round(GetSpellPenetration()) .. "%"
end

-- Get dodge chacne
function ECSData:Dodge()
    return ECSData:Round(GetDodgeChance()) .. "%"
end

-- Get parry chance
function ECSData:Parry()
    return ECSData:Round(GetParryChance()) .. "%"
end

-- Get block chance
function ECSData:Block()
    return ECSData:Round(GetBlockChance()) .. "%"
end

-- Get phys dmg bonus
function ECSData:PhysicalDmg()
    return ECSData:Round(GetSpellBonusDamage(1))
end

-- Get phys crit chance
function ECSData:PhysicalCrit()
    return ECSData:Round(GetSpellCritChance(1)) .. "%"
end

-- Get holy bonus dmg
function ECSData:HolyDmg()
    return ECSData:Round(GetSpellBonusDamage(2))
end

-- Get holy crit chance
function ECSData:HolyCrit()
    return ECSData:Round(GetSpellCritChance(2)) .. "%"
end

-- Get fire bonus dmg
function ECSData:FireDmg()
    return ECSData:Round(GetSpellBonusDamage(3))
end

-- Get fire crit chance
function ECSData:FireCrit()
    return ECSData:Round(GetSpellCritChance(3)) .. "%"
end

-- Get nature bonus dmg
function ECSData:NatureDmg()
    return ECSData:Round(GetSpellBonusDamage(4))
end

-- Get nature crit chance
function ECSData:NatureCrit()
    return ECSData:Round(GetSpellCritChance(4)) .. "%"
end

-- Get frost bonus dmg
function ECSData:FrostDmg()
    return ECSData:Round(GetSpellBonusDamage(5))
end

-- Get frost crit chance
function ECSData:FrostCrit()
    return ECSData:Round(GetSpellCritChance(5)) .. "%"
end

-- Get shadow bonus dmg
function ECSData:ShadowDmg()
    return ECSData:Round(GetSpellBonusDamage(6))
end

-- Get shadow crit chance
function ECSData:ShadowCrit()
    return ECSData:Round(GetSpellCritChance(6)) .. "%"
end

-- Get arcane bonus dmg
function ECSData:ArcaneDmg()
    return ECSData:Round(GetSpellBonusDamage(7))
end

-- Get arcane crit chance
function ECSData:ArcaneCrit()
    return ECSData:Round(GetSpellCritChance(7)) .. "%"
end

-- Get bonus healing power
function ECSData:HealingBonus()
    return ECSData:Round(GetSpellBonusHealing())
end

function ECSData:GetStatInfo(refName)

    if refName == "RangedHit" then
       return ECSData:HitModifier()
    end
    if refName == "RangedCritChance" then
        return ECSData:RangedCrit()
    end

    if refName == "MeleeHit" then
       return ECSData:HitModifier()
    end
    if refName == "MeleeCritChance" then
        return ECSData:MeleeCrit()
    end

    if refName == "DodgeChance" then
        return ECSData:Dodge()
    end
    if refName == "ParryChance" then
        return ECSData:Parry()
    end
    if refName == "BlockChance" then
        return ECSData:Block()
    end

    if refName == "SpellHit" then
       return ECSData:SpellHitModifier()
    end
    if refName == "SpellCritChance" then
        return ECSData:SpellCrit()
    end

    -- if refName == "MP5Current" then
    --     return ECSData:ManaRegenCurrent()
    -- end
    -- if refName == "MP5Casting" then
    --     return ECSData:ManaRegenCasting()
    -- end
    if refName == "MP5NotCasting" then
        return ECSData:ManaRegenNotCasting()
    end

    if refName == "PhysicalCritChance" then
        return ECSData:PhysicalCrit()
    end
    if refName == "ArcaneCritChance" then
        return ECSData:ArcaneCrit()
    end
    if refName == "NatureDmg" then
        return ECSData:NatureDmg()
    end
    if refName == "HolyDmg" then
        return ECSData:HolyDmg()
    end
    if refName == "FrostCritChance" then
        return ECSData:FrostCrit()
    end
    if refName == "FireDmg" then
        return ECSData:FireDmg()
    end
    if refName == "BonusHealing" then
        return ECSData:HealingBonus()
    end
    if refName == "FireCritChance" then
        return ECSData:FireCrit()
    end
    if refName == "ShadowDmg" then
        return ECSData:ShadowDmg()
    end
    if refName == "FrostDmg" then
        return ECSData:FrostDmg()
    end
    if refName == "HolyCritChance" then
        return ECSData:HolyCrit()
    end
    if refName == "PhysicalDmg" then
        return ECSData:PhysicalDmg()
    end
    if refName == "ShadowCritChance" then
        return ECSData:ShadowCrit()
    end
    if refName == "ArcaneDmg" then
        return ECSData:ArcaneDmg()
    end
    if refName == "NatureCritChance" then
        return ECSData:NatureCrit()
    end
end
