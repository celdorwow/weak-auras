function (e, ...)
    if e == "OPTIONS" then
        -- Clear table
        local rares = aura_env.rares
        for guid,r in pairs(rares) do
            if rares[guid].timer then rares[guid].timer:Cancel() end
            rares[guid] = nil
        end

        -- Player to join a custom channel
        local cch = aura_env.custom_channel
        cch.index = false
        JoinChannelByName(cch.name, cch.pass)

        -- Init mapID
        C_Timer.After(0.1, function ()
                WeakAuras.ScanEvents("RARE_MESSAGE_INIT_MAPID")
        end)

        C_Timer.After(1, function()
                WeakAuras.ScanEvents("RARE_MESSAGE_JOIN_CHANNEL")
        end)
    end
end
