function (e, ...)
    if e ~= "GLOBAL_ELEMENTAL_AURA_INIT" then return end
    if CeldorGlobalElementalAura then
        aura_env.EarthElemental = CeldorGlobalElementalAura:new(198103);
    end
end
