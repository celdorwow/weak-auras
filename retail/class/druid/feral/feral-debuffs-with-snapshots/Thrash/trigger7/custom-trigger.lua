function(e, ...)
    if e ~= "CELDOR_FERAL_ACTIVATE" then return end
    aura_env.bloodtallon = CeldorBuffTracker:new()
    aura_env.tigersfury = CeldorBuffTracker:new()
end
