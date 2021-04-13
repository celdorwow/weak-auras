local tinsert = tinsert
local UnitAura = UnitAura


local function format_seconds(t, threshold)
    threshold = threshold or 5
    local str_frmt
    if t > threshold then
        str_frmt = string.format("%.0f", t)
    else
        str_frmt = string.format("|cFFFF0000%.1f|r", t)
    end
    return str_frmt
end

function aura_env.format_duration(t, threshold)
    if not t or t == 0 then return end
    return t > 3600 and ceil(t/3600).."h"
    or t > 60 and ceil(t/60).."m"
    or format_seconds(t, threshold)
end

aura_env.buffinfo = {
    ["Sluggish Potion"] = {},
    ["Sickening Potion"] = {},
    ["Spicy Potion"] = {},
}

function aura_env.dynamicinfo (buffs)
    aura_env.resetinfo(buffs)
    local queried = {}
    -- count items in buffinfo
    local counter = 0
    for k,_ in pairs(buffs) do counter = counter + 1 end
    for i = 1, 40 do
        local name,_,_,_,duration,expiration,_,_,_,_,spellid = UnitAura("player", i, nil, "helpful")
        if buffs[name] ~= nil then
            tinsert(queried, name)
            buffs[name].spellid = spellid
            buffs[name].duration = duration
            buffs[name].expiration = expiration
        end
        if #queried == counter then break end
    end
end

function aura_env.resetinfo (buffs)
    for name, _ in pairs(buffs) do
        buffs[name].duration = buffs[name].duration and nil
        buffs[name].expiration = buffs[name].expiration and nil
    end
end

function aura_env.cycle (t, e)
    -- check if needs cycle
    if t[1] == e then
        return t
    end

    -- Find element
    local index = 1
    while(index <= #t and t[index] ~= e) do
        index = index + 1
    end

    if index > #t then
        return t
    end

    -- Shift
    local x = {}
    for i = index,#t,1 do
        table.insert(x, t[i])
    end
    for i = 1,index-1,1 do
        table.insert(x, t[i])
    end
    return x
end

function aura_env.refreshclones (allstates, colours, potions, buffs)
    -- do not proceed if it's not visible
    if not aura_env.visible then return end

    local info = aura_env.info
    local initstate = aura_env.config.initstate
    -- create progress bars
    for i, v in ipairs(info) do
        local duration = 0
        local expiration = 0

        -- check for auras
        if buffs then
            if v.effect == "heal" then
                duration = buffs["Sluggish Potion"].duration
                expiration = buffs["Sluggish Potion"].expiration
            elseif v.effect == "protect" then
                duration = buffs["Sickening Potion"].duration
                expiration = buffs["Sickening Potion"].expiration
            elseif v.effect == "aoe" then
                duration = buffs["Spicy Potion"].duration
                expiration = buffs["Spicy Potion"].expiration
            end
        end

        allstates[i].effect = v.effect
        allstates[i].initstate = false
        allstates[i].name = v.display
        allstates[i].duration = duration
        allstates[i].expirationTime = expiration
        allstates[i].icon = potions[colours[v.position]]
        allstates[i].index = i
        allstates[i].changed = true
        allstates[i].show = true
    end
end
function aura_env.startclones (allstates, colours, potions)
    -- do not proceed if it's not visible
    if not aura_env.visible then return end

    local info = aura_env.info
    local initstate = aura_env.config.initstate
    -- create progress bars
    for i, v in ipairs(info) do
        local name = i < 3 and "-----" or initstate.value

        allstates[i] = {
            effect = v.effect,
            initstate = true,
            name = name,
            progressType = "timed",
            duration = 0,
            expirationTime = 0,
            icon = potions[colours[v.position]],
            index = i,
            changed = true,
            show = true,
        }
    end
end

aura_env.enteredworld = nil

aura_env.visible = true

aura_env.colours = {
    "black",
    "blue",
    "green",
    "purple",
    "red",
}

aura_env.potions = {
    black=134757,
    blue=2057564,
    green=2057565,
    purple=2057567,
    red=1385333,
}

local cconfig = aura_env.config.colours
local econfig = aura_env.config.effects
aura_env.info = {
    {effect="bad", position=1, colour=cconfig.bad, display=econfig.bad},
    {effect="good", position=3, colour=cconfig.good, display=econfig.good},
    {effect="heal", position=2, colour=cconfig.heal, display=econfig.heal},
    {effect="protect", position=5, colour=cconfig.protect, display=econfig.protect},
    {effect="aoe", position=4, colour=cconfig.aoe, display=econfig.aoe},
}
