-- Locales
local locale = GetLocale()
-- These locales are equivalent
if (not tIndexOf({"deDE", "enGB", "enUS", "esES", "esMX", "frFR", "itIT", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"}, locale))
or tIndexOf({"enGB", "zhTW", "zhCN", "koKR"}, locale)
then
    locale = "enUS"
end
local tbl_loc = {
    ["enUS"] = {   -- English (United States), Primary
        ["Crystals"] = "Crystals",
        ["Crystal"] = "Crystal",
        ["Chests"] = "Chests",
        ["Chest"] = "Chest",
        ["Subzones"] = "Subzones",
    },
    ["deDE"] = {
        ["Crystals"] = "Kristalle",
        ["Crystal"] = "Kristall",
        ["Chests"] = "Schatztruhen",
        ["Chest"] = "Schatztruhe",
    },   -- German (Germany)
    ["esES"] = {
        ["Crystals"] = "Cristales",
        ["Crystal"] = "Cristal",
        ["Chests"] = "Cofres",
        ["Chest"] = "Cofre",
    },   -- Spanish (Spain)
    ["esMX"] = {
        ["Crystals"] = "Cristales",
        ["Crystal"] = "Cristal",
        ["Chests"] = "Cofres",
        ["Chest"] = "Cofre",
    },   -- Spanish (Mexico)
    ["frFR"] = {},   -- French (France)
    ["itIT"] = {},   -- Italian (Italy)
    ["ptBR"] = {},   -- Portuguese (Brazil)
    ["ruRU"] = {},   -- Russian (Russia)
}
if locale ~= "enUS" then
    for name, val in pairs(tbl_loc["enUS"]) do
        if not tbl_loc[locale][name] then
            tbl_loc[locale][name] = val
        end
    end
end
aura_env.L = tbl_loc[locale]
