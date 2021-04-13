function(e, isbuff)
    if e == "CELDOR_BT_AURA" then
        aura_env.bloodtallon.buff = isbuff
    end
    if e == "CELDOR_TF_AURA" then
        aura_env.tigersfury.buff = isbuff
    end
    if e == "CELDOR_IS_IN_PROWL" then
        -- reseting prowl needs to be delayed up to time of spell cast
        local sp = aura_env.stealth
        if (sp.spellcast or {}).getreset and not isbuff then
            return
        end
        aura_env.stealth.buff = isbuff
    end
    if e == "CELDOR_INCARNATION_BUFF" then
        aura_env.incarnation.buff = isbuff
    end
end
