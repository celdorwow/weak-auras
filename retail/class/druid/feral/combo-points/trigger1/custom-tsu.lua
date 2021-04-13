function (s, e, ...)
    if e == "STARTUP" then
        aura_env.createclones(s)
        return true
    end

    if e == "UNIT_POWER_UPDATE"
    then
        local unit, powerType = ...
        -- No match
        if unit ~= "player"
        or powerType ~= "COMBO_POINTS"
        then
            return
        end
        -- Combo Points
        aura_env.createclones(s)
        return true
    end
end
