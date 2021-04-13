function(e, ...)
    if e ~= "UNIT_AURA" then return end

    -- Update buffs
    for _, t in ipairs{aura_env.bt, aura_env.tf, aura_env.st, aura_env.inc} do
        t:set(false)
        for i = 1, 40 do
            local spellID = select(10, UnitAura("player", i, "HELPFUL"))
            if spellID and t:check(spellID) then
                t:set(true)
                break
            end
        end
    end

    -- Send events
    aura_env.bt:send()
    aura_env.tf:send()
    aura_env.st:send()
    aura_env.inc:send()
end
