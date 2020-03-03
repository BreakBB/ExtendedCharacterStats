
---@class GearInfos
local GearInfos = ECSLoader:CreateModule("GearInfos")

-- Forward declaration
local _CreateGearColorFrames

local GEAR_SLOT_FRAMES = {
    CharacterHeadSlot,
    CharacterNeckSlot,
    CharacterShoulderSlot,
    CharacterBackSlot,
    CharacterChestSlot,
    CharacterWristSlot,
    CharacterHandsSlot,
    CharacterWaistSlot,
    CharacterLegsSlot,
    CharacterFeetSlot,
    CharacterFinger0Slot,
    CharacterFinger1Slot,
    CharacterTrinket0Slot,
    CharacterTrinket1Slot,
    CharacterMainHandSlot,
    CharacterSecondaryHandSlot,
    CharacterRangedSlot,
}

function GearInfos:Init()
    _CreateGearColorFrames()
end

---Creates the colored frames around each gear slot indicating the item quality
_CreateGearColorFrames = function()
    for _, gearFrame in ipairs(GEAR_SLOT_FRAMES) do
        gearFrame.qualityTexture = gearFrame:CreateTexture(nil,"OVERLAY",nil)
        gearFrame.qualityTexture:SetPoint("TOPLEFT", gearFrame, "TOPLEFT", -2, 2)
        gearFrame.qualityTexture:SetPoint("BOTTOMRIGHT", gearFrame, "BOTTOMRIGHT", 2, -2)
        gearFrame.qualityTexture:SetTexture("Interface\\Addons\\ExtendedCharacterStats\\Icons\\WhiteIconFrame.blp")

    end
    GearInfos:UpdateGearColorFrames()
    GearInfos:ToggleColorFrames(ExtendedCharacterStats.general.showQualityColors)
end

---Updates the colored frames around each gear slot
function GearInfos:UpdateGearColorFrames()
    for _, gearFrame in ipairs(GEAR_SLOT_FRAMES) do
        gearFrame.qualityTexture:SetVertexColor(0, 0, 0, 0)

        local itemLink = GetInventoryItemLink("player", gearFrame:GetID())
        -- print(itemLink)
        if itemLink ~= nil then
            local _, itemInfo = GetItemInfo(itemLink)
            if itemInfo ~= nil then
                local itemQuality = C_Item.GetItemQualityByID(itemInfo)
                local r, g, b, _ = GetItemQualityColor(itemQuality)
                gearFrame.qualityTexture:SetVertexColor(r, g, b, 0.75)
            end
        end
    end
end

---Toggles the colored frames around each gear slot
---@param value boolean @True if the frames should be shown, false otherwise
function GearInfos:ToggleColorFrames(value)
    for _, gearFrame in ipairs(GEAR_SLOT_FRAMES) do
        if value then
            gearFrame.qualityTexture:Show()
            else
            gearFrame.qualityTexture:Hide()
        end
    end
end
