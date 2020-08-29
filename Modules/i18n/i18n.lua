---@class i18n
local i18n = ECSLoader:CreateModule("i18n")

local _UseLanguage

function i18n:LoadLanguageData()
    local locale = ExtendedCharacterStats.general.langugage
    if (not locale) or (locale == "auto") then
        locale = GetLocale()
    end
    _UseLanguage(locale)
end

---@param lang string
_UseLanguage = function(lang)
    if lang == "deDE" then
        i18n:UseGerman()
    elseif lang == "frFR" then
        i18n:UseFrench()
    else
        i18n:UseEnglish()
    end
end

---@param lang string
function i18n:SetLanguage(lang)
    _UseLanguage(lang)
end

---@param key string @The specified key for the target text
---@return string @The formated text
function i18n:translate(key, ...)
    local args = {...}

    for i, v in ipairs(args) do
        args[i] = tostring(v);
    end

    if (not i18n.texts[key]) then
        print("|cffff0000[ERROR]|r Missing translation for <" .. key .. "> key")
        return ""
    end

    return string.format(i18n.texts[key], unpack(args))
end

setmetatable(i18n, {__call = function(_, ...) return i18n:translate(...) end})
