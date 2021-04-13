aura_env.subzones = {}
aura_env.mapID = nil
aura_env.currID = 1719

-- Locales
local locale = GetLocale()
-- These locales are equivalent
if (not tIndexOf({"deDE", "enGB", "enUS", "esES", "esMX", "frFR", "itIT", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"}, locale))
or tIndexOf({"enGB", "zhCN", "koKR"}, locale)
then
    locale = "enUS"
end
local tbl_loc = {
    ["enUS"] = { -- English (United States), Primary
        ["Cathedral Square"] = "Cathedral Square",
        ["Dwarven District"] = "Dwarven District",
        ["Old Town"] = "Old Town",
        ["Trade District"] = "Trade District",
        ["Mage Quarter"] = "Mage Quarter",
        ["Valley of Strength"] = "Valley of Strength",
        ["Valley of Spirits"] = "Valley of Spirits",
        ["Valley of Wisdom"] = "Valley of Wisdom",
        ["The Drag"] = "The Drag",
        ["Valley of Honor"] = "Valley of Honor",
        ["Crystals"] = "Crystals",
        ["Crystal"] = "Crystal",
        ["Chests"] = "Chests",
        ["Chest"] = "Chest",
        ["Subzones"] = "Subzones",
        ["You have crystals to turn in"] = "You have crystals to turn in",
    },
    ["deDE"] = { -- German (Germany)
        ["Cathedral Square"] = "Der Kathedralenplatz",
        ["Dwarven District"] = "Der Zwergendistrikt",
        ["Old Town"] = "Die Altstadt",
        ["Trade District"] = "Der Handelsdistrikt",
        ["Mage Quarter"] = "Das Magierviertel",
        ["Valley of Strength"] = "Das Tal der Stärke",
        ["Valley of Spirits"] = "Das Tal der Geister",
        ["Valley of Wisdom"] = "Das Tal der Weisheit",
        ["The Drag"] = "Die Gasse",
        ["Valley of Honor"] = "Das Tal der Ehre",
        ["Crystals"] = "Kristalle",
        ["Crystal"] = "Kristall",
        ["Chests"] = "Schatztruhen",
        ["Chest"] = "Schatztruhe",
        ["You have crystals to turn in"] = "Du musst die Kristalle abgeben",
    },
    ["esES"] = { -- Spanish (Spain)
        ["Cathedral Square"] = "Plaza de la Catedral",
        ["Dwarven District"] = "Distrito de los Enanos",
        ["Old Town"] = "Casco Antiguo",
        ["Trade District"] = "Distrito de Mercaderes",
        ["Mage Quarter"] = "Barrio de los Magos",
        ["Valley of Strength"] = "Valle de la Fuerza",
        ["Valley of Spirits"] = "Valle de los Espíritus",
        ["Valley of Wisdom"] = "Valle de la Sabiduría",
        ["The Drag"] = "Calle Mayor",
        ["Valley of Honor"] = "Valle del Honor",
        ["Crystals"] = "Cristales",
        ["Crystal"] = "Cristal",
        ["Chests"] = "Cofres",
        ["Chest"] = "Cofre",
        ["You have crystals to turn in"] = "Tienes cristales que entregar",
    },
    ["esMX"] = { -- Spanish (Mexico)
        ["Cathedral Square"] = "Plaza de la Catedral",
        ["Dwarven District"] = "Distrito de los Enanos",
        ["Old Town"] = "Casco Antiguo",
        ["Trade District"] = "Distrito de Mercaderes",
        ["Mage Quarter"] = "Barrio de los Magos",
        ["Valley of Strength"] = "Valle de la Fuerza",
        ["Valley of Spirits"] = "Valle de los Espíritus",
        ["Valley of Wisdom"] = "Valle de la Sabiduría",
        ["The Drag"] = "La Calle Mayor",
        ["Valley of Honor"] = "Valle del Honor",
        ["Crystals"] = "Cristales",
        ["Crystal"] = "Cristal",
        ["Chests"] = "Cofres",
        ["Chest"] = "Cofre",
        ["You have crystals to turn in"] = "Tienes cristales que entregar",
    },
    ["frFR"] = { -- French (France)
        ["Cathedral Square"] = "Place de la Cathédrale",
        ["Dwarven District"] = "Quartier des Nains",
        ["Old Town"] = "Vieille ville",
        ["Trade District"] = "Quartier commerçant",
        ["Mage Quarter"] = "Quartier des Mages",
        ["Valley of Strength"] = "Vallée de la Force",
        ["Valley of Spirits"] = "Vallée des Esprits",
        ["Valley of Wisdom"] = "Vallée de la Sagesse",
        ["The Drag"] = "La Herse",
        ["Valley of Honor"] = "Vallée de l'Honneur",
    },
    ["itIT"] = { -- Italian (Italy)
        ["Cathedral Square"] = "Piazza della Cattedrale",
        ["Dwarven District"] = "Distretto dei Nani",
        ["Old Town"] = "Citta Vecchia",
        ["Trade District"] = "Distretto Commerciale",
        ["Mage Quarter"] = "Quartiere dei Maghi",
        ["Valley of Strength"] = "Valle della Forza",
        ["Valley of Spirits"] = "Valle degli Spiriti",
        ["Valley of Wisdom"] = "Valle della Saggezza",
        ["The Drag"] = "Varcolargo",
        ["Valley of Honor"] = "Valle dell 'Onore",
    },
    ["ptBR"] = { -- Portuguese (Brazil)
        ["Cathedral Square"] = "Praça da Catedral",
        ["Dwarven District"] = "Distrito dos Anões",
        ["Old Town"] = "Cidade Velha",
        ["Trade District"] = "Distrito Comercial",
        ["Mage Quarter"] = "Distrito dos Magos",
        ["Valley of Strength"] = "Vale da Força",
        ["Valley of Spirits"] = "Vale dos Espíritos",
        ["Valley of Wisdom"] = "Vale da Sabedoria",
        ["The Drag"] = "O Bazar",
        ["Valley of Honor"] = "Vale da Honra",
    },
    ["ruRU"] = {
        ["Cathedral Square"] = "Соборная площадь",
        ["Dwarven District"] = "Квартал дворфов",
        ["Old Town"] = "Старый город",
        ["Trade District"] = "Торговый квартал",
        ["Mage Quarter"] = "Квартал Магов",
        ["Valley of Strength"] = "Аллея Силы",
        ["Valley of Spirits"] = "Аллея Духов",
        ["Valley of Wisdom"] = "Аллея Мудрости",
        ["The Drag"] = "Волок",
        ["Valley of Honor"] = "Аллея Чести",
    },
    ["zhTW"] = { -- Chinese (Traditional, Taiwan)
        ["Cathedral Square"] = "大教堂廣場",
        ["Dwarven District"] = "矮人區",
        ["Old Town"] = "舊城區",
        ["Trade District"] = "貿易區",
        ["Mage Quarter"] = "法師區",
        ["Valley of Strength"] = "力量谷",
        ["Valley of Spirits"] = "精神谷",
        ["Valley of Wisdom"] = "智慧谷",
        ["The Drag"] = "暗巷區",
        ["Valley of Honor"] = "榮譽谷",
    },
}
if locale ~= "enUS" then
    for name, val in pairs(tbl_loc["enUS"]) do
        if not tbl_loc[locale][name] then
            tbl_loc[locale][name] = val
        end
    end
end
aura_env.L = tbl_loc[locale]
local L = aura_env.L


-- Miscellaneous functions
local function throttle (duration)
    local exptime = 0
    return function ()
        if GetTime() - duration >= exptime then
            exptime = GetTime()
            return true
        end
    end
end
-- warning
function aura_env.warning(w, rw)
    rw = rw or w
    local icon = "|TInterface\\GossipFrame\\AvailableQuestIcon.blp:0|t|r"
    PlaySound(SOUNDKIT.RAID_WARNING, "Dialog")
    UIErrorsFrame:AddMessage(icon.." "..rw.." "..icon, 1.0, 0.5, 0.0, 5)
    ChatFrame1:AddMessage(icon.." |cFFFF0000"..w.."|r "..icon, "party")
end
-- Communication
aura_env.auracomprefix = "celdorauraprefix"
if not C_ChatInfo.RegisterAddonMessagePrefix(aura_env.auracomprefix) then
    -- aura_env.config.announcements = true|false
    ChatFrame1:AddMessage("|cFFFF8000Announcments are disabled|r")
end
-- Announce about crystals and chests
function aura_env.annoucer(item)
    if not aura_env.config.announcements or not item then return end
    local cs = aura_env.current_state
    local auraname = "Crystals and Chests:"
    local x, y = aura_env.getpos()
    local coords = Round(x * 1000) / 10 .. " " .. Round(y * 1000) / 10
    local zone = cs.zonestat and cs.zonestat.subzone or ""
    local tail = item .. " located in " .. zone .. ":   " .. coords
    if aura_env.config.chattype == 1 then
        local msg = "|cFF80FF80" .. auraname .. "|r" .. " " .. tail
        C_ChatInfo.SendAddonMessage(aura_env.auracomprefix, msg, "INSTANCE_CHAT")
    else
        local channel = aura_env.config.chattype == 2 and "PARTY" or "INSTANCE_CHAT"
        local msg = auraname .. " " .. tail
        SendChatMessage(msg, channel)
    end
end
-- Corrupted Mementos
function aura_env.getcurrency ()
    local widgetID = 2002
    if not (C_UIWidgetManager or {}).GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo
    then
        return 0
    end
    local widgetInfo = C_UIWidgetManager.GetScenarioHeaderCurrenciesAndBackgroundWidgetVisualizationInfo(widgetID)
    if not (((widgetInfo or {}).currencies or {})[1] or {}).text then
        return 0
    end
    return widgetInfo.currencies[1].text
end
-- Map position
local GetPlayerMapPosition = C_Map.GetPlayerMapPosition
function aura_env.getpos ()
    local mapID = aura_env.mapID
    local pos = mapID and GetPlayerMapPosition(mapID, "player") or nil
    if not pos then return end
    return pos.x, pos.y
end
-- Return length of a UTF8 encoded string
local function utf8len (str)
    if not str then return 0 end
    local length, pos = 0, 1
    while str:sub(pos) ~= "" do
        local byte = str:byte(pos)
        if byte > 0 and byte < 128 then
            pos = pos + 1
        elseif byte >= 192 and byte < 224 then
            pos = pos + 2
        elseif byte >= 224 and byte < 240 then
            pos = pos + 3
        elseif byte >= 240 and byte < 248 then
            pos = pos + 4
        end
        length = length + 1
    end
    return length
end
-- Shorten long strings
local function ElvUI_ShortenString(str, numChars, dots)
    -- Credits to authors of ElvUI addon
    if numChars >= utf8len(str) then -- Celdor's changes
        return str
    else
        local bytes = #str
        local len, pos = 0, 1
        while pos <= bytes do
            len = len + 1
            local c = str:byte(pos)
            if c > 0 and c <= 127 then
                pos = pos + 1
            elseif c >= 192 and c <= 223 then
                pos = pos + 2
            elseif c >= 224 and c <= 239 then
                pos = pos + 3
            elseif c >= 240 and c <= 247 then
                pos = pos + 4
            end
            if len == numChars then
                break
            end
        end

        if len == numChars and pos <= bytes then
            return str:sub(1, pos - 1)..(dots and '...' or '')
        else
            return str
        end
    end
end
-- point in poly
local function pointinpoly(self, x, y, area)
    if not x or not y then return end
    local inside = false
    local tx, ty = x, y
    area = area or self.area
    local j = #area
    for i = 1, #area do
        local vxi, vyi = unpack(area[i])
        local vxj, vyj = unpack(area[j])
        if (vyi > ty) ~= (vyj > ty)
        and tx < (vxj - vxi) * (ty - vyi) / (vyj - vyi) + vxi
        then
            inside = not inside
        end
        j = i
    end
    return inside
end


-- Clones
local barwidth = aura_env.config.barwidth
local namelen = aura_env.config.namelen
local overlay = {55, barwidth}
-- Substitute long names
local function truncateName(name, length)
    if not length or length == 0 then return name end
    return ElvUI_ShortenString(name, length, true)
end
-- Reset clones
function aura_env.resetclones (allstates)
    for _, st in pairs(allstates) do
        st.show = false
        st.changed = true
    end
end
-- Create bars
function aura_env.createclones (i, zonestat, cz)
    local zn = zonestat.subzone
    return {
        index = i,
        name = zn,
        progressType = "static",
        value = overlay[2],
        total = overlay[2],
        autoHide = true,
        additionalProgress = {
            {
                min = 0,
                max = overlay[2],
            },
            {
                direction = "backward",
                width = overlay[1],
                offset = overlay[1],
            },
            {
                direction = "backward",
                width = overlay[1],
                offset = 0,
            },
        },
        show = true,
        changed = true,
        display = truncateName(zn, namelen),
        current = cz == zn,
        crystals = zonestat.crystals,
        maxcrystals = zonestat.maxcrystals,
        chests = zonestat.chests,
        maxchests = zonestat.maxchests,
    }
end
-- Create test bars
function aura_env.createtestclones(allstates)
    local d = aura_env.disttest
    local i = 10
    local maxstat = false
    aura_env.resetclones(allstates)
    for mapID, _ in pairs(d) do
        for idx, z in ipairs(d[mapID]) do
            z.crystals = maxstat and 2 or 1
            z.chests = maxstat and 1 or 2
            if idx == 1 then z.chests = not maxstat and 4 or 2 end
            local id = "id"..z.subzone:gsub("%s+", "")
            allstates[id] = aura_env.createclones(i, z, d[mapID][1].subzone)
            i = i - 1
            maxstat = not maxstat
        end
    end
end



-- Tables
function aura_env.hasValue (t, val, field)
    for _, v in ipairs(t) do
        if field then
            if v[field] == val then return true end
        end
        if v == val then return true end
    end
end
-- Sort table by subzone name
function aura_env.sort (tbl)
    table.sort(tbl, function(a, b)
        if not a then
        return true
    end
    if not b then
        return false
    end
    a = string.lower(a.subzone)
    b = string.lower(b.subzone)
    return a < b
end)
end


-- Districts
aura_env.ZoneStats = {
check = function (self, subzone)
    return subzone == self.subzone
end,
addcrystal = function (self)
    self.crystals = self.crystals + 1
end,
addchest = function (self)
    self.chests = self.chests + 1
end,
reset = function (self)
    self.crystals = 0
    self.chests = 0
end,
isinarea = pointinpoly,
new = function (self, subzone, maxstats, area)
    local o = {
        subzone = subzone,
        crystals = 0,
        chests = 0,
        maxcrystals = maxstats and maxstats[1] or 2,
        maxchests = maxstats and maxstats[2] or 2,
        area = area,
    }
    setmetatable(o, self)
    return o
end,
}
aura_env.ZoneStats.__index = aura_env.ZoneStats
-- All districts
aura_env.districts = {
[1470] = { -- Stormwind
    aura_env.ZoneStats:new(L["Cathedral Square"], {2, 4}, {
        {0.4467, 0.5475}, {0.5100, 0.6574}, {0.5548, 0.6341}, {0.6093, 0.5674},
        {0.6124, 0.5122}, {0.5835, 0.4578}, {0.5030, 0.4116}, {0.4486, 0.4798},
    }),
    aura_env.ZoneStats:new(L["Dwarven District"], {2, 2}, {
        {0.5910, 0.3837}, {0.6492, 0.4961}, {0.6740, 0.4930}, {0.7140, 0.4475},
        {0.7043, 0.3711}, {0.6782, 0.2594}, {0.6523, 0.2351}, {0.6140, 0.2543},
        {0.5755, 0.3031}
    }),
    aura_env.ZoneStats:new(L["Old Town"], {2, 2}, {
        {0.7249, 0.5033}, {0.6791, 0.5559}, {0.6782, 0.5885}, {0.7334, 0.6904},
        {0.8023, 0.7287}, {0.8458, 0.6314}, {0.7725, 0.5310}
    }),
    aura_env.ZoneStats:new(L["Trade District"], {2, 2}, {
        {0.5682, 0.6747}, {0.6216, 0.6176}, {0.6444, 0.6206}, {0.6982, 0.7082},
        {0.6980, 0.7517}, {0.6472, 0.8134}, {0.5977, 0.7925}, {0.5687, 0.7109}
    }),
    aura_env.ZoneStats:new(L["Mage Quarter"], {2, 2}, {
        {0.5737, 0.8074}, {0.5317, 0.7329}, {0.4710, 0.7106}, {0.4025, 0.7726},
        {0.4057, 0.8615}, {0.4252, 0.9127}, {0.4960, 0.9430}, {0.5595, 0.8795}
    }),
},
[1469] = { -- Ogrimmar
    aura_env.ZoneStats:new(L["Valley of Strength"], {2, 4}, {
        {0.4313, 0.6479}, {0.4304, 0.7079}, {0.4407, 0.8014}, {0.4584, 0.9515},
        {0.5907, 0.9292}, {0.5907, 0.7900}, {0.5630, 0.6754}, {0.5238, 0.6603},
        {0.4979, 0.6150}, {0.4666, 0.6254},
    }),
    aura_env.ZoneStats:new(L["Valley of Spirits"], {2, 2}, {
        {0.4400, 0.6129}, {0.4314, 0.6443}, {0.4306, 0.7078}, {0.4408, 0.8016},
        {0.3833, 0.9007}, {0.3380, 0.8571}, {0.2637, 0.7190}, {0.2710, 0.5953},
        {0.3400, 0.5563},
    }),
    aura_env.ZoneStats:new(L["Valley of Wisdom"], {2, 2}, {
        {0.5303, 0.4975}, {0.5465, 0.4307}, {0.4718, 0.3840}, {0.3890, 0.3795},
        {0.3517, 0.4493}, {0.3946, 0.5786}, {0.4430, 0.6042},
    }),
    aura_env.ZoneStats:new(L["The Drag"], {2, 2}, {
        {0.5236, 0.6603}, {0.4979, 0.6154}, {0.5316, 0.5000}, {0.5547, 0.4027},
        {0.5697, 0.4062}, {0.5960, 0.4616}, {0.5996, 0.4864}, {0.5969, 0.4896},
        {0.6077, 0.5110}, {0.6101, 0.5085}, {0.6177, 0.5164}, {0.6251, 0.5389},
        {0.6116, 0.6395}, {0.5811, 0.6750},
    }),
    aura_env.ZoneStats:new(L["Valley of Honor"], {2, 2}, {
        {0.6683, 0.5743}, {0.7927, 0.4777}, {0.7780, 0.2735}, {0.6790, 0.2091},
        {0.5865, 0.2969}, {0.5855, 0.4382}, {0.5965, 0.4613}, {0.6000, 0.4866},
        {0.5970, 0.4903}, {0.6073, 0.5108}, {0.6105, 0.5076}, {0.6284, 0.5273},
    }),
},
}
aura_env.disttest = {
[1470] = { -- Stormwind
    aura_env.ZoneStats:new(L["Cathedral Square"], {2, 4}),
    aura_env.ZoneStats:new(L["Dwarven District"], {2, 2}),
    aura_env.ZoneStats:new(L["Old Town"], {2, 2}),
    aura_env.ZoneStats:new(L["Trade District"], {2, 2}),
    aura_env.ZoneStats:new(L["Mage Quarter"], {2, 2}),
},
[1469] = { -- Ogrimmar
    aura_env.ZoneStats:new(L["Valley of Strength"], {2, 4}),
    aura_env.ZoneStats:new(L["Valley of Spirits"], {2, 2}),
    aura_env.ZoneStats:new(L["Valley of Wisdom"], {2, 2}),
    aura_env.ZoneStats:new(L["The Drag"], {2, 2}),
    aura_env.ZoneStats:new(L["Valley of Honor"], {2, 2}),
},
}


-- Hand crystals in
aura_env.HandCrystals = {
isinarea = pointinpoly,
visitnpc = function (self)
    -- need to visit NPC if collected crystals were not handed in
    return self.collected and not self.handedin
end,
updatecounter = function (self, val)
    self.counter = self.counter + val
end,
iscounter = function (self)
    if self.counter == 0 then return end
    return true
end,
isvocal = function (self)
    return self.sound
end,
reset = function (self)
    self.collected = false
    self.handedin = false
    self.counter = 16
    self.sound = true
end,
new = function (self, boss, npc)
    local o = {
        collected = false,
        handedin = false,
        counter = 16,
        sound = true,
        boss = boss,
        npc = npc,
    }
    setmetatable(o, self)
    return o
end,
}
aura_env.HandCrystals.__index = aura_env.HandCrystals
aura_env.crystals_reminder = {
[1469] = aura_env.HandCrystals:new({
    {0.4951, 0.7399}, {0.4997, 0.7275}, {0.5018, 0.7191}, {0.4997, 0.7045},
    {0.4946, 0.6951}, {0.4871, 0.6908}, {0.4777, 0.6940}, {0.4703, 0.7034},
    {0.4681, 0.7148}, {0.4703, 0.7275}, {0.4766, 0.7380}, {0.4829, 0.7412},
    {0.4919, 0.7421}, {0.4908, 0.7511}, {0.4960, 0.7553}, {0.5002, 0.7521},
    {0.5012, 0.7437},
    }, {
    {0.5325, 0.7046}, {0.5417, 0.6877}, {0.5515, 0.7087}, {0.5370, 0.7230},
}),
[1470] = aura_env.HandCrystals:new({
    {0.4839, 0.4567}, {0.5058, 0.4990}, {0.5205, 0.5167}, {0.5356, 0.4993},
    {0.5272, 0.4743}, {0.5053, 0.4319},
    }, {
    {0.568, 0.482}, {0.575, 0.474}, {0.579, 0.482}, {0.572, 0.491},
}),
}


-- Player's current state
aura_env.current_state = {
index = 0,
zonestat = false,
corrmems = aura_env.getcurrency(),
chestloot = false,
chesttimer = false,
tick = throttle(0.5),
tick_warn = throttle(1),
}
