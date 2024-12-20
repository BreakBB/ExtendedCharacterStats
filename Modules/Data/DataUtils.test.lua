dofile("Modules/ModuleLoader.lua")

describe("DataUtils", function()

    ---@type DataUtils
    local DataUtils

    before_each(function()
        _G.ECS = {IsWotlk = false}
        DataUtils = require("Modules.Data.DataUtils")
    end)

    describe("GetMissChanceByDifference", function()
        it("should return 5 % miss chance for 300 weapon skill vs 300 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(300, 300)

            assert.are_equal(5, result)
        end)

        it("should return 9 % miss chance for 300 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(300, 315)

            assert.are_equal(9, result)
        end)

        it("should return 8 % miss chance for WotLK and 300 weapon skill vs 315 defense value", function()
            _G.ECS = {IsWotlk = true}
            DataUtils = require("Modules.Data.DataUtils")

            local result = DataUtils.GetMissChanceByDifference(300, 315)

            assert.are_equal(8, result)
        end)
    end)
end)