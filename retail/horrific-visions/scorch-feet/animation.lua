function(progress, start, delta)
    local c = WeakAuras.GetActiveConditions(aura_env.id,aura_env.cloneId)
    if c[2] then
        local angle = (progress * 2 * math.pi) - (math.pi / 2)
        return start + (((math.sin(angle) + 1)/2) * delta)
    end
end
