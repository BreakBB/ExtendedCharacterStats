dofile("Modules/ModuleLoader.lua")

describe("GearInfos", function()
    ---@type GearInfos
    local GearInfos

    local mockFrame

    local function createMockFrame(slotId)
        local frame = {}
        frame.qualityTexture = {
            SetVertexColor = spy.new(function() end)
        }
        frame.GetID = function()
            return slotId
        end
        return frame
    end

    before_each(function()
        mockFrame = createMockFrame(1)

        -- Set one slot global so GEAR_SLOT_FRAMES has exactly one entry
        _G.CharacterHeadSlot = mockFrame

        _G.ECSLoader = ECSLoader
        _G.ECS = {}

        _G.ExtendedCharacterStats = {
            general = {
                showQualityColors = true,
                qualityColorsIntensity = 1.0
            }
        }

        _G.C_Timer = {After = spy.new(function() end)}

        _G.C_Item = {
            GetItemInfo = function() return nil, nil end,
            GetItemQualityByID = function() return 4 end,
            GetItemQualityColor = function() return 1, 0.8, 0, 1 end
        }

        _G.GetInventoryItemID = function() return nil end
        _G.GetInventoryItemLink = function() return nil end

        GearInfos = require("Modules.GearInfos")
    end)

    after_each(function()
        package.loaded["Modules.GearInfos"] = nil
        _G.CharacterHeadSlot = nil
    end)

    describe("UpdateGearColorFrames", function()
        it("should not schedule a retry when the slot has no item equipped", function()
            _G.GetInventoryItemID = function() return nil end
            _G.GetInventoryItemLink = spy.new(function() end)

            GearInfos.UpdateGearColorFrames()

            assert.spy(_G.C_Timer.After).was.not_called()
            assert.spy(_G.GetInventoryItemLink).was.not_called()
        end)

        it("should set color to transparent when slot is empty", function()
            _G.GetInventoryItemID = function() return nil end

            GearInfos.UpdateGearColorFrames()

            assert.spy(mockFrame.qualityTexture.SetVertexColor).was.called(1)
            assert.spy(mockFrame.qualityTexture.SetVertexColor).was.called_with(mockFrame.qualityTexture, 0, 0, 0, 0)
        end)

        it("should schedule a retry when item is equipped but link is not yet available", function()
            _G.GetInventoryItemID = function() return 12345 end
            _G.GetInventoryItemLink = spy.new(function() return nil end)

            GearInfos.UpdateGearColorFrames()

            assert.spy(_G.C_Timer.After).was.called()
            assert.spy(_G.GetInventoryItemLink).was.called_with("player", 1)
        end)

        it("should stop retrying after MAX_COLOR_FRAME_RETRIES retries", function()
            _G.C_Timer = {After = spy.new(function(_, callback) callback() end)}
            _G.GetInventoryItemID = function() return 12345 end
            _G.GetInventoryItemLink = function() return nil end

            GearInfos.UpdateGearColorFrames()

            assert.spy(_G.C_Timer.After).was.called(5)
        end)

        it("should apply item quality color when item link and info are available", function()
            _G.GetInventoryItemID = function() return 12345 end
            _G.GetInventoryItemLink = function() return "|cff1eff00|Hitem:12345|h[Sword]|h|r" end
            _G.C_Item.GetItemInfo = function() return nil, 12345 end
            _G.C_Item.GetItemQualityByID = function() return 4 end
            _G.C_Item.GetItemQualityColor = function() return 0, 0.44, 0.87, 1 end

            GearInfos.UpdateGearColorFrames()

            -- First call resets to 0,0,0,0 then sets the actual color
            assert.spy(mockFrame.qualityTexture.SetVertexColor).was.called(2)
            assert.spy(mockFrame.qualityTexture.SetVertexColor).was.called_with(mockFrame.qualityTexture, 0, 0, 0, 0)
            assert.spy(mockFrame.qualityTexture.SetVertexColor).was.called_with(mockFrame.qualityTexture, 0, 0.44, 0.87, 1)
        end)

        it("should not schedule a retry when item link is available but item info is not yet cached", function()
            _G.GetInventoryItemID = function() return 12345 end
            _G.GetInventoryItemLink = function() return "|cff1eff00|Hitem:12345|h[Sword]|h|r" end
            _G.C_Item.GetItemInfo = function() return nil, nil end

            GearInfos.UpdateGearColorFrames()

            assert.spy(_G.C_Timer.After).was.not_called()
        end)
    end)
end)
