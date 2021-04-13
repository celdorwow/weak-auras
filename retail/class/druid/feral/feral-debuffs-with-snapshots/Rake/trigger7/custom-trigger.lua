function(event, ...)
    if not CeldorTriggerOnFunction or not aura_env.incarnation then return end
    return CeldorTriggerOnFunction(aura_env, aura_env.incarnation, aura_env.stealth, event, ...)
end
