function(event, ...)
    return not aura_env.incarnation:check(UnitGUID("target"))
end
