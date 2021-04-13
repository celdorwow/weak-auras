function (e, ...)
    if e ~= "GLOBAL_ELEMENTAL_AURA_INIT" then return end
    if CeldorGlobalElementalAura then
        aura_env.FireElemental = CeldorGlobalElementalAura:new(198067);
    end
end