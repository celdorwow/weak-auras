function(event, ...)
    if not CeldorTriggerOnFunction or not aura_env.bloodtallon then return end
    return CeldorTriggerOnFunction(aura_env, aura_env.bloodtallon, nil, event, ...)
end
