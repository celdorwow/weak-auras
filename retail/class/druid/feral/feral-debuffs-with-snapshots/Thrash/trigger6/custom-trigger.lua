function(e, isbuff)
    if e == "CELDOR_BT_AURA" then
        aura_env.bloodtallon.buff = isbuff
    end
    if e == "CELDOR_TF_AURA" then
        aura_env.tigersfury.buff = isbuff
    end
end
