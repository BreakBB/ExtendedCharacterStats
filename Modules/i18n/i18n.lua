---@class i18n
local i18n = ECSLoader:CreateModule("i18n")

function i18n:LoadLanguageData()
    i18n:UseEnglish()

    -- TODO
    -- local locale = GetLocale()

    -- if locale == "enUS" or locale == "enGB" then
    --     textTable = i18n:UseEnglish()
    -- else

    -- end
end

---@param key string @The specified key for the target text
---@return string @The formated text
function i18n:translate(key, ...)
    local args = {...}

    for i, v in ipairs(args) do
        args[i] = tostring(v);
    end

    return string.format(i18n.texts[key], unpack(args))
end

setmetatable(i18n, {__call = function(_, ...) return i18n.translate(...) end})
