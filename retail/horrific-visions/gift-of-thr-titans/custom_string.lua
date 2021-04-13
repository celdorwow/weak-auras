function()
    -- expTime, dur, progress, formatedDuration, name, icon, stacks
    if not (aura_env.state or {}).expirationTime then return end
    local pr = aura_env.state.expirationTime - GetTime()
    return pr > 0 and aura_env.format_duration(pr, 5) or nil
end
