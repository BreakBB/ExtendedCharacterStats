---@type Data
local Data = ECSLoader:ImportModule("Data")
---@type DataUtils
local DataUtils = ECSLoader:ImportModule("DataUtils")


---@return string
function Data:GetMovementSpeed()
    local _, runSpeed, _, _ = GetUnitSpeed("player")
    runSpeed = runSpeed / 7 * 100
    return DataUtils:Round(runSpeed, 0) .. "%"
end