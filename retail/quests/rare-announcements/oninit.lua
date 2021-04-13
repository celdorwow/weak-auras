-- map ID
aura_env.mapID = false
aura_env.timer = false
aura_env.colours = {rare="FFFF6060", addon="FF00FF00"}

-- Announcements
aura_env.warareprefix = "warareprefix"
if not C_ChatInfo.RegisterAddonMessagePrefix(aura_env.warareprefix) then
    -- aura_env.config.announcements = true|false
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF8000Announcmements are unavailable via wa!|r")
end

-- Process messages
local function form_msg(sep, ...)
    local str = ""
    for _, e in ipairs{...} do
        str = str .. e .. sep
    end
    return str:sub(1, -2)
end
function aura_env.parse_msg(msg)
    local t = {}
    for token in msg:gmatch("[^:]+") do
        if tonumber(token) then token = tonumber(token) end
        tinsert(t, token)
    end
    return unpack(t)
end

-- TomTom
aura_env.tomtomopts = {
    title = "",       -- desc
    source = "",      -- sender info
    persistent = nil, -- don't save this waypoint
    minimap = true,   -- show on minimap
    world = nil,      -- do not show on world map
    crazy = true,     -- control to show an arrow
    silent = nil,     -- TomTom's sound notifications
}

-- Rares
aura_env.rares = {}
local rares = aura_env.rares
local function unitcheck(guid, name, level, delay)
    -- Unit exists and it's a rare
    if rares[guid] then return rares[guid] end

    -- This is a new unit
    rares[guid] = aura_env.RareNPC:new(guid, name, level, delay)
    rares[guid].timer = C_Timer.NewTimer(delay, function() rares[guid] = nil end)
    return rares[guid]
end
function aura_env.checkbyunit(unit)
    local guid = UnitGUID(unit)
    local name = UnitName(unit)
    local level = aura_env.unitlevel(unit)
    local delay = 60
    return unitcheck(guid, name, level, delay)
end
function aura_env.checkbyguid(guid, name, level, delay)
    --local name = select(6, GetPlayerInfoByGUID(guid))
    return unitcheck(guid, name, level, delay)
end
function aura_env.removeunit(guid)
    if rares[guid] then
        if rares[guid].timer then rares[guid].timer:Cancel() end
        rares[guid] = nil
    end
end
function aura_env.unitlevel(unit)
    local level = UnitLevel(unit) == -1 and "??" or UnitLevel(unit)
    local unitclass = UnitClassification(unit)
    if unitclass:match("rare") then level = level .. "R" end
    if unitclass:match("elite") then level = level .. "+" end
    return level
end

-- Rares
aura_env.RareNPC = {
    isoncd = function (self)
        return GetTime() < self.exptime
    end,
    setcooldown = function (self)
        self.exptime = GetTime() + self.delay
    end,
    announce = function (self, unit)
        -- Init variables
        local mapID = aura_env.mapID
        local x, y = C_Map.GetPlayerMapPosition(mapID, "player"):GetXY()
        local health = Round(UnitHealth(unit)/UnitHealthMax(unit)*100)

        -- Set a message
        local msg = form_msg(":", WeakAuras.myGUID, mapID, self.name, self.guid, self.level, health, ("%.5f"):format(x), ("%.5f"):format(y))
        if aura_env.custom_channel.index then
            C_ChatInfo.SendAddonMessage(aura_env.warareprefix, msg, "CHANNEL", aura_env.custom_channel.index)
            local ra = "|c" .. aura_env.colours.addon .. "Rare Announcer|r"
            local strrare = "|c" .. aura_env.colours.rare .. self.name .. "|r (" .. self.level .. ")"
            local coords = ("%.1f"):format(x*100) .. " " .. ("%.1f"):format(y*100)
            DEFAULT_CHAT_FRAME:AddMessage(ra .. ": " .. strrare .. ",  coords:  " .. coords)
            PlaySound(SOUNDKIT.TELL_MESSAGE)
        end
    end,
    new = function (self, guid, name, level, delay)
        local o = {
            exptime = 0,
            delay = delay or 60,
            timer = false,
            name = name,
            level = level,
            guid = guid,
        }
        setmetatable(o, self)
        return o
    end,
}
aura_env.RareNPC.__index = aura_env.RareNPC

-- Channels
aura_env.custom_channel = {
    name = "CeldorsRareAnnouncer",
    pass = "d775d56fda36fbc259815c2376dab6cb5bde19cf",
    index = false,
    getchannels = function ()
        local channels = {GetChannelList()}
        local nochannels = Round(#channels/3)
        local t = {}
        for i = 0, nochannels-1 do
            table.insert(t, {
                id=channels[i*3 + 1],
                name=channels[i*3 + 2],
                disabled=channels[i*3 + 3],
            })
        end
        return t, nochannels
    end,
    getindex = function (self)
        local channels, nochannels = self.getchannels()
        for _, e in ipairs(channels) do
            if e.name == self.name and not e.disabled then
                self.index = e.id
                return self.index
            end
        end
    end,
    islast = function (self)
        return self.index == select(2, self.getchannels())
    end,
    movetolast = function (self)
        local nochannels = select(2, self.getchannels())
        for i = 1, nochannels-1 do
            if select(2, GetChannelName(i)) == self.name then
                C_ChatInfo.SwapChatChannelsByChannelIndex(i, i + 1)
            end
        end
        self.index = self:getindex()
        return self.index
    end,
}
