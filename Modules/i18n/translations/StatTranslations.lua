---@type i18n
local i18n = ECSLoader:ImportModule("i18n")

local statTranslations = {

}

for k, v in pairs(statTranslations) do
    i18n.translations[k] = v
end
