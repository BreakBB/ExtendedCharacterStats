dofile("Modules/ModuleLoader.lua")
dofile("Modules/Utils.lua")

describe("Ranged", function()

    ---@type Data
    local Data
    ---type DataUtils
    local DataUtils

    before_each(function()
        _G.ECS = {IsWotlk = false}
        _G.UnitClass = function()
            return "HUNTER", "HUNTER", 3
        end
        DataUtils = require("Modules.Data.DataUtils")
        Data = require("Modules.Data.Ranged")
    end)

    describe("RangeMissChanceBossLevel", function()
        it("should return 9 % miss chance for 300 weapon skill vs 315 defense value", function()
            _G.UnitRangedAttack = function()
                return 300, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return nil
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("9%", result)
        end)
    end)
end)