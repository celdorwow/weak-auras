function(event, ...)
    if not CeldorTriggerOnFunction or not aura_env.tigersfury then return end
    return CeldorTriggerOnFunction(aura_env, aura_env.tigersfury, nil, event, ...)
end
