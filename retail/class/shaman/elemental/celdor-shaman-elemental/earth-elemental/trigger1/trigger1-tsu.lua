function(s, e, ...)
    if not aura_env.EarthElemental then return end
    
    if e == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellID = ...;
        if spellID ~= 198103 or unit ~= "player"
        then
            return;
        end
        
        local name, _, icon = aura_env.EarthElemental:SpellInfo()
        local dur = aura_env.EarthElemental:Duration()
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
        local ee = aura_env.EarthElemental;
        C_Timer.After(0.5, function() ee.pet = true end)
        return true
    end
    
    if e == "UNIT_PET" then
        local unit = ...;
        if unit ~= "player" or not aura_env.EarthElemental.pet
        then
            return;
        end
        -- hide aura
        s[""] = {
            show = false,
            changed = true,
        };
        aura_env.EarthElemental.pet = false;
        return true
    end
end

