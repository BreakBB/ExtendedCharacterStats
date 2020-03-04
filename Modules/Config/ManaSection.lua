---@type Config
local Config = ECSLoader:ImportModule("Config")
local _Config = Config.private

---@type Stats
local Stats = ECSLoader:ImportModule("Stats")

function _Config:LoadManaSection()
    return {
        type = "group",
        order = 5,
        inline = false,
        name = function() return "Mana" end,
        args = {
            showManaStats = {
                type = "toggle",
                order = 0,
                name = function() return "Show Mana Stats" end,
                desc = function() return "Shows/Hides all mana stats." end,
                width = 1,
                get = function () return ExtendedCharacterStats.profile.regen.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Items = {
                type = "toggle",
                order = 1,
                name = function() return "MP5 Items" end,
                desc = function() return "Shows/Hides the MP5 from items value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Items.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Items.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Spirit = {
                type = "toggle",
                order = 2,
                name = function() return "MP5 Spirit" end,
                desc = function() return "Shows/Hides the MP5 from spirit value." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Spirit.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Spirit.display = value
                    Stats:RebuildStatInfos()
                end,
            },
            mp5Casting = {
                type = "toggle",
                order = 3,
                name = function() return "MP5 Casting" end,
                desc = function() return "Shows/Hides the MP5 value while casting." end,
                width = 1.5,
                disabled = function() return (not ExtendedCharacterStats.profile.regen.display); end,
                get = function () return ExtendedCharacterStats.profile.regen.mp5Casting.display; end,
                set = function (info, value)
                    ExtendedCharacterStats.profile.regen.mp5Casting.display = value
                    Stats:RebuildStatInfos()
                end,
            },
        },
    }
end
