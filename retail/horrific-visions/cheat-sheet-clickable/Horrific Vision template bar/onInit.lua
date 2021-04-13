local function format_seconcs(t, threshold)
    threshold = threshold or 4
    local str_frmt
    if t > threshold then
        str_frmt = string.format("%.0f", t)
    else
        str_frmt = string.format("|cFFFF0000%.1f|r", t)
    end
    return str_frmt
end

-- Clicable buttons
local function createHighlightTexture(self)
    local texture = self:CreateTexture(nil, "OVERLAY")
    self.highlight = texture
    texture:SetTexture([[Interface\QuestFrame\UI-QuestLogTitleHighlight]])
    texture:SetBlendMode("ADD")
    texture:ClearAllPoints(self)
    texture:SetAllPoints(self)
    texture:SetAlpha(.4)
    return texture
end
local function onButtonEnter(self)
    if not self.highlight then
        createHighlightTexture(self)
    end
    self.highlight:Show()
    self:SetBackdropBorderColor(1, 1, 1)
end
local function onButtonLeave(self)
    if self.highlight then
        self.highlight:Hide()
    end
    self:SetBackdropBorderColor(0, 0, 0)
end
function aura_env.ClicableFrame(region, i)
    -- region = WeakAuras.regions[aura_env.id].region
    if not region then return end
    local button = CreateFrame("Button", nil, region)
    button:ClearAllPoints()
    button:SetAllPoints()
    button:RegisterForClicks("LeftButtonDown", "RightButtonUp")
    button:SetScript("OnClick", function()
            WeakAuras.ScanEvents("CELDOR_SELECT_COLOUR", i)
    end)
    button:SetScript("OnEnter", onButtonEnter)
    button:SetScript("OnLeave", onButtonLeave)
    return button
end


local tooltipbuffs = {nil, nil, 315845, 315849, 315817}


function aura_env.format_duration(t)
    local secs, rsecs = t % 60, t - t % 60
    local mins, rmins = rsecs/60 % 60, rsecs/60 - rsecs/60 % 60
    local hours, rhours = rmins/60 % 60, rmins/60 - rmins/60 % 60
    local str_frmt
    --
    if hours > 0 then
        str_frmt = tostring(hours).."h"
    elseif mins > 0 then
        str_frmt = tostring(mins).."m"
    elseif secs > 0 then
        str_frmt = format_seconcs(secs)
    end
    return str_frmt
end

function aura_env.eIndexOf(t, effect)
    for i,v in ipairs(t) do
        if v.effect == effect then return i end
    end
end

aura_env.buffinfo = {
    ["Sluggish Potion"] = {spellid=315845, duration=nil, expiration=nil},
    ["Sickening Potion"] = {spellid=315849, duration=nil, expiration=nil},
    ["Spicy Potion"] = {spellid=315817, duration=nil, expiration=nil},
}

aura_env.dynamicinfo = function(buffs)
    aura_env.resetinfo(buffs)
    local queried = {}
    -- count items in buffinfo
    counter = 0
    for k,_ in pairs(buffs) do counter = counter + 1 end
    for i = 1, 40 do
        local name,_,_,_,duration,expiration,_,_,_,_,spellid = UnitAura("player", i, nil, "helpful")
        if buffs[name] ~= nil then
            table.insert(queried, name)
            buffs[name].duration = duration
            buffs[name].expiration = expiration
        end
        if #queried == counter then break end
    end
end

aura_env.resetinfo = function(buffs)
    for name, _ in pairs(buffs) do
        buffs[name].duration = buffs[name].duration and nil
        buffs[name].expiration = buffs[name].expiration and nil
    end
end

aura_env.cycle = function (t, e)
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

aura_env.makeauras = function(allstates, colours, potions, buffs, isinitstate)
    -- reset states
    for k, _ in pairs(allstates) do
        allstates[k].changed = true
        allstates[k].show = false
    end

    -- do not proceed if it's not visible
    if not aura_env.visible then return end

    local info = aura_env.info
    local initstate = aura_env.config.initstate
    -- create progress bars
    for i, v in ipairs(info) do
        local name = (isinitstate and (i < 3 and "-----" or initstate.value)) or v.display --isinitstate and initstate.value or v.display
        local spellid = 0
        local duration = 0
        local expiration = 0

        -- check for auras
        if buffs then
            if v.effect == "heal" then
                spellid = buffs["Sluggish Potion"].spellid
                duration = buffs["Sluggish Potion"].duration
                expiration = buffs["Sluggish Potion"].expiration
            elseif v.effect == "protect" then
                spellid = buffs["Sickening Potion"].spellid
                duration = buffs["Sickening Potion"].duration
                expiration = buffs["Sickening Potion"].expiration
            elseif v.effect == "aoe" then
                spellid = buffs["Spicy Potion"].spellid
                duration = buffs["Spicy Potion"].duration
                expiration = buffs["Spicy Potion"].expiration
            end
        end

        allstates[v.effect] = {
            effect = v.effect,
            initstate = isinitstate,
            name = name,
            progressType = "timed",
            duration = duration,
            expirationTime = expiration,
            colour = colours[v.position],
            icon = potions[colours[v.position]],
            index = i,
            spellId = tooltipbuffs[i],
            changed = true,
            show = true,
        }
    end
end


aura_env.enteredworld = nil

aura_env.visible = true

aura_env.clickablesCreated = nil

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
