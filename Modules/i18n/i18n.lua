local ECS = ECS
local ECSLoader = ECSLoader
local format = string.format
local GetLocale = GetLocale
local ipairs = ipairs
local setmetatable = setmetatable
local tostring = tostring
local unpack = unpack

---@class i18n
local i18n = ECSLoader:CreateModule("i18n")
i18n.translations = {}
local selectedLocale


---@param lang string
function i18n:SetLanguage(lang)
    if (not lang) or (lang == "auto") then
        selectedLocale = GetLocale()
    else
        selectedLocale = lang
    end

    ExtendedCharacterStats.general.language = lang
end

---@param key string @The specified key for the target text
---@return string @The formatted text
local function translate(key, ...)
    local args = {...}

    for i, v in ipairs(args) do
        args[i] = tostring(v);
    end

    local translationEntry = i18n.translations[key]
    if translationEntry == nil then
        -- Translation for the key is missing completely
        ECS:Error("The translation for <".. tostring(key) .. "> is missing completely. Please report this!")
        return format(key, unpack(args))
    end

    local translationValue = translationEntry[selectedLocale]
    if (not translationValue) then
        -- The translation for the selected locale is missing
        return format(key, unpack(args))
    end

    if translationValue == true then
        -- Fallback to enUS which is the key
        return format(key, unpack(args))
    end

    return format(translationValue, unpack(args))
end

setmetatable(i18n, {__call = function(_, ...) return translate(...) end})
