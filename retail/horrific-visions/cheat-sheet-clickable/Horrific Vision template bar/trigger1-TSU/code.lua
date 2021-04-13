function(allstates, ev, ...)
    local makeauras = aura_env.makeauras
    local cycle = aura_env.cycle
    local dynamicinfo = aura_env.dynamicinfo
    local buffinfo = nil

    -- On loading the aura
    if ev == "PLAYER_ENTERING_WORLD" then
        if not aura_env.config.initstate.show then return end
        aura_env.enteredworld = true
        aura_env.resetinfo(aura_env.buffinfo)
        buffinfo = nil
    end

    -- handle auras
    if ev == "UNIT_AURA" then
        if aura_env.enteredworld then return end
        local playerbuffs = false
        buffinfo = aura_env.buffinfo
        dynamicinfo(buffinfo)
        for _, v in pairs(buffinfo) do
            playerbuffs = playerbuffs or v.duration ~= nil
        end
        if not playerbuffs then buffinfo = nil end
    end

    if ev == "CELDOR_SELECT_COLOUR" then
        local effect = ...
        local index = aura_env.eIndexOf(aura_env.info, effect)
        local colour = aura_env.colours[index]
        aura_env.colours = cycle(aura_env.colours, colour)
    end

    -- Handle commands in chat
    if string.match(ev, "CHAT_MSG_") then
        local msg, author = ...
        if not tIndexOf({"black", "blue", "green", "purple", "red", "none", "init"}, msg) then return end
        aura_env.enteredworld = false

        if tIndexOf({"black", "blue", "green", "purple", "red"}, msg) then
            aura_env.visible = true
            aura_env.colours = cycle(aura_env.colours, msg)

        elseif msg == "init" then
            aura_env.visible = true
            aura_env.enteredworld = true
            aura_env.colours = cycle(aura_env.colours, "black")
            aura_env.resetinfo(aura_env.buffinfo)
            buffinfo = nil

        else -- msg is "none"
            aura_env.visible = false
            -- reset states
            for k, _ in pairs(allstates) do
                allstates[k].changed = true
                allstates[k].show = false
            end
            return true
        end
    end

    -- Create progress bars
    makeauras(allstates, aura_env.colours, aura_env.potions, buffinfo, aura_env.enteredworld)

    -- Due to how Wow UI works create clickables only ones per UI load
    if not aura_env.clickablesCreated then
        WeakAuras.ScanEvents("CELDOR_SET_CLICKABLE_FRAMES", aura_env.colours)
    end

    return true
end
