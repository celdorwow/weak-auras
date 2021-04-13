function (e, ...)
    if e == "COMBAT_LOG_EVENT_UNFILTERED" then
        local se, _, sGUID, sName = select(2, ...)
        local dGUID, dName = select(8, ...)
        local playerGUID = WeakAuras.myGUID

        if se:match("SPELL") then
            local spellId = select(12, ...)

            -- WImp summoned
            if se == "SPELL_SUMMON" and spellId == 104317 then
                aura_env.impnumber = aura_env.impnumber + 1
                local t_subimp = C_Timer.NewTimer(17, function ()
                        WeakAuras.ScanEvents("DEMOLOCK_WIMP_CHANGE", -1)
                end)
                tinsert(aura_env.timers, t_subimp)
            end

            -- Implosion cast
            if se == "SPELL_CAST_SUCCESS" then
                if spellId == 196277 and sGUID == playerGUID then
                    aura_env.impnumber = 0
                    aura_env.canceltimers(aura_env.timers)
                elseif spellId == 264130  and sGUID == playerGUID then
                    -- Power Siphon cast
                    aura_env.impnumber = aura_env.impnumber - 2
                    if aura_env.impnumber < 0 then aura_env.impnumber = 0 end
                end
            end
        end
    end

    if e == "DEMOLOCK_WIMP_CHANGE" then
        local n = ...
        aura_env.impnumber = aura_env.impnumber + n
    end

    if aura_env.impnumber == 0 then return end
    return true
end
