
---@class GearInfos
local GearInfos = ECSLoader:CreateModule("GearInfos")

-- Forward declaration
local _CreateGearColorFrames, _UpdateColorFrame, _GetInspectGearSlots

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
        _UpdateColorFrame(gearFrame, "player")
    end
end

_UpdateColorFrame = function (gearFrame, unit)
    gearFrame.qualityTexture:SetVertexColor(0, 0, 0, 0)

    local itemLink = GetInventoryItemLink(unit, gearFrame:GetID())
    if itemLink ~= nil then
        local _, itemInfo = GetItemInfo(itemLink)
        if itemInfo ~= nil then
            local itemQuality = C_Item.GetItemQualityByID(itemInfo)
            local r, g, b, _ = GetItemQualityColor(itemQuality)
            gearFrame.qualityTexture:SetVertexColor(r, g, b, 0.75)
        end
    else
        C_Timer.After(0.2, function ()
            _UpdateColorFrame(gearFrame, unit)
        end)
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
    for _, gearFrame in ipairs(_GetInspectGearSlots()) do
        if value then
            gearFrame.qualityTexture:Show()
        else
            gearFrame.qualityTexture:Hide()
        end
    end
end

_GetInspectGearSlots = function()
    return {
        InspectHeadSlot,
        InspectNeckSlot,
        InspectShoulderSlot,
        InspectBackSlot,
        InspectChestSlot,
        InspectWristSlot,
        InspectHandsSlot,
        InspectWaistSlot,
        InspectLegsSlot,
        InspectFeetSlot,
        InspectFinger0Slot,
        InspectFinger1Slot,
        InspectTrinket0Slot,
        InspectTrinket1Slot,
        InspectMainHandSlot,
        InspectSecondaryHandSlot,
        InspectRangedSlot,
    }
end

function GearInfos:UpdateInspectGearColorFrames()
    for _, gearFrame in ipairs(_GetInspectGearSlots()) do
        if gearFrame.qualityTexture == nil then
            gearFrame.qualityTexture = gearFrame:CreateTexture(nil,"OVERLAY",nil)
            gearFrame.qualityTexture:SetPoint("TOPLEFT", gearFrame, "TOPLEFT", -2, 2)
            gearFrame.qualityTexture:SetPoint("BOTTOMRIGHT", gearFrame, "BOTTOMRIGHT", 2, -2)
            gearFrame.qualityTexture:SetTexture("Interface\\Addons\\ExtendedCharacterStats\\Icons\\WhiteIconFrame.blp")
            gearFrame.qualityTexture:SetVertexColor(0, 0, 0, 0)
        end
        if ExtendedCharacterStats.general.showQualityColors then
            _UpdateColorFrame(gearFrame, "target")
        end
    end
end
