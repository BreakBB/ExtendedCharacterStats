------------------------------------------------------------------
-- Modules
------------------------------------------------------------------

---@class Locale
local Locale = ECSLoader:CreateModule("Locale")

---@type LocaleEN
local LocaleEN = ECSLoader:ImportModule("LocaleEN")

local textTable = {}

function Locale:Init()
    textTable = LocaleEN:GetStrings()

    -- TODO
    -- local locale = GetLocale()

    -- if locale == "enUS" or locale == "enGB" then
    --     textTable = LocaleEN:GetStrings()
    -- else

    -- end
end

---@param stringKey string @The specified key for the target text
---@return string @The formated text
function Locale:GetString(stringKey, ...)
    local args = {...}
    -- Convert all args to string
    for i, v in ipairs(args) do
        args[i] = tostring(v);
    end

    return string.format(textTable[stringKey], unpack(args))
end
