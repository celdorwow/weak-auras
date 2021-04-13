function(s, ev, ...)
    local refreshclones = aura_env.refreshclones
    local cycle = aura_env.cycle
    local dynamicinfo = aura_env.dynamicinfo
    local buffinfo = nil


    if ev == "STARTUP" then
        if not aura_env.config.initstate.show then return end
        aura_env.enteredworld = true
        aura_env.colours = cycle(aura_env.colours, "black")
        aura_env.resetinfo(aura_env.buffinfo)
        aura_env.startclones(s, aura_env.colours, aura_env.potions)
        return true
    end


    if ev == "UNIT_AURA" then
        local unitTarget = ...
        if unitTarget ~= "player" or aura_env.enteredworld then return end
        local playerbuffs = false
        buffinfo = aura_env.buffinfo
        dynamicinfo(buffinfo)
        for _, v in pairs(buffinfo) do
            playerbuffs = playerbuffs or v.duration ~= nil
        end
        if not playerbuffs then buffinfo = nil end
        refreshclones(s, aura_env.colours, aura_env.potions, buffinfo)
        return true
    end


    if string.match(ev, "CHAT_MSG_") then
        local msg = ...
        if not tIndexOf({"black", "blue", "green", "purple", "red", "show", "init", "start", "none", "stop", "remove"}, msg) then return end
        aura_env.enteredworld = false
        if tIndexOf({"black", "blue", "green", "purple", "red"}, msg) then
            aura_env.visible = true
            aura_env.colours = cycle(aura_env.colours, msg)
            refreshclones(s, aura_env.colours, aura_env.potions, buffinfo)
            return true
        elseif tIndexOf({"show", "init", "start"}, msg) then
            aura_env.visible = true
            aura_env.enteredworld = true
            aura_env.colours = cycle(aura_env.colours, "black")
            aura_env.resetinfo(aura_env.buffinfo)
            aura_env.startclones(s, aura_env.colours, aura_env.potions)
            return true
        else -- msg is "none", "stop", or "remove"
            aura_env.visible = false
            -- reset states
            for k, _ in pairs(s) do
                s[k].changed = true
                s[k].show = false
            end
            return true
        end
    end
end
