function (progress, start, delta)
    if not aura_env.enteredworld then
        return
    end
    local angle = (progress * 2 * math.pi) - (math.pi / 2)
    return start + (((math.sin(angle) + 1)/2) * delta)
end
