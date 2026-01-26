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

        _G.C_UnitAuras = {
            GetPlayerAuraBySpellID = function() return nil end
        }
        _G.C_SpellBook = {
            IsSpellKnown = function() return false end
        }
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

        it("should return 8 % miss chance for 300 weapon skill vs 315 defense value and with 1% hit equipped", function()
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
                return 1
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("8%", result)
        end)

        it("should return 6 % miss chance for 305 weapon skill vs 315 defense value", function()
            _G.UnitRangedAttack = function()
                return 305, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 0
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("6%", result)
        end)

        it("should return 5 % miss chance for 305 weapon skill vs 315 defense value and with 1% hit equipped", function()
            _G.UnitRangedAttack = function()
                return 305, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 1
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("5%", result)
        end)

        it("should return 0 % miss chance for 300 weapon skill vs 315 defense value and with 9% hit equipped", function()
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
                return 9
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("0%", result)
        end)

        it("should return 0 % miss chance for 305 weapon skill vs 315 defense value and with 6% hit equipped", function()
            _G.UnitRangedAttack = function()
                return 305, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 6
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("0%", result)
        end)

        it("should return 6.4 % miss chance for 304 weapon skill vs 315 defense value and with 1% hit equipped", function()
            _G.UnitRangedAttack = function()
                return 304, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 1
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("6.4%", result)
        end)

        it("should return 4.6 % miss chance for 309 weapon skill vs 315 defense value and with 1% hit equipped", function()
            _G.UnitRangedAttack = function()
                return 309, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 1
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("4.6%", result)
        end)

        it("should return 5.6 % miss chance for 309 weapon skill vs 315 defense value", function()
            _G.UnitRangedAttack = function()
                return 309, 0
            end
            _G.UnitLevel = function()
                return 60
            end
            DataUtils.GetEnchantForEquipSlot = function()
                return nil
            end
            _G.GetHitModifier = function()
                return 0
            end

            local result = Data.RangeMissChanceBossLevel()

            assert.are_equal("5.6%", result)
        end)
    end)
end)