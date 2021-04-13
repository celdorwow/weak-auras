function(s, e, ...)
    if e == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellID = ...;
        if spellID ~= 198067 or unit ~= "player"
        then
            return;
        end
        
        local name, _, icon = aura_env.FireElement:SpellInfo()
        local dur = aura_env.FireElement:Duration()
        -- set aura
        s[""] = {
            show = true,
            changed = true,
            progressType = "timed",
            duration = dur,
            expirationTime = dur + GetTime(),
            autoHide = true,
            name = name,
            icon = icon,
        };
        -- player has a pet
        local fe = aura_env.FireElement;
        C_Timer.After(0.5, function() fe.pet = true end)
        return true
    end
    
    if e == "UNIT_PET" then
        local unit = ...;
        if unit ~= "player" or not aura_env.FireElement.pet
        then
            return;
        end
        -- hide aura
        s[""] = {
            show = false,
            changed = true,
        };
        aura_env.FireElement.pet = false;
        return true
    end
end

