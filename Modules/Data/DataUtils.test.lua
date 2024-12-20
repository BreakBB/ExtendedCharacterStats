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

        it("should return 9.2 % miss chance for 299 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(299, 315)

            assert.are_equal(9.2, result)
        end)

        it("should return 9 % miss chance for 300 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(300, 315)

            assert.are_equal(9, result)
        end)

        it("should return 8.6 % miss chance for 301 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(301, 315)

            assert.are_equal(8.6, result)
        end)

        it("should return 8.2 % miss chance for 302 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(302, 315)

            assert.are_equal(8.2, result)
        end)

        it("should return 7.8 % miss chance for 303 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(303, 315)

            assert.are_equal(7.8, result)
        end)

        it("should return 7.4 % miss chance for 304 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(304, 315)

            assert.are_equal(7.4, result)
        end)

        it("should return 6 % miss chance for 305 weapon skill vs 315 defense value", function()
            local result = DataUtils.GetMissChanceByDifference(305, 315)

            assert.are_equal(6, result)
        end)

        it("should return 8 % miss chance for WotLK and 300 weapon skill vs 315 defense value", function()
            _G.ECS = {IsWotlk = true}
            DataUtils = require("Modules.Data.DataUtils")

            local result = DataUtils.GetMissChanceByDifference(300, 315)

            assert.are_equal(8, result)
        end)
    end)
end)