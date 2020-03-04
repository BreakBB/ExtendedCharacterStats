---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")

function _Config:LoadDefenseSection()
    return {
        type = "group",
        order = 4,
        inline = false,
        name = function() return "Defense" end,
        args = {
            showDefenseStats = {
                type = "toggle",
                order = 0,
                name = function() return "Show Defense Stats" end,
                desc = function() return "Shows/Hides all defense stats." end,
                width = 1,
                get = function () return ExtendedCharacterStats.profile.defense.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            armor = {
                type = "toggle",
                order = 1,
                name = function() return "Armor" end,
                desc = function() return "Shows/Hides the armor value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.armor.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.armor.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            defense = {
                type = "toggle",
                order = 2,
                name = function() return "Defense" end,
                desc = function() return "Shows/Hides the defense value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.defense.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.defense.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            block = {
                type = "toggle",
                order = 3,
                name = function() return "Block" end,
                desc = function() return "Shows/Hides the block value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.block.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.block.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            parry = {
                type = "toggle",
                order = 4,
                name = function() return "Parry" end,
                desc = function() return "Shows/Hides the parry value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.parry.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.parry.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            dodge = {
                type = "toggle",
                order = 5,
                name = function() return "Dodge" end,
                desc = function() return "Shows/Hides the dodge value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.defense.display); end,
                get = function () return ExtendedCharacterStats.profile.defense.dodge.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.defense.dodge.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
