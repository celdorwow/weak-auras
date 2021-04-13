aura_env.current_state.initialised = false

for guid, _ in pairs(aura_env.nameplates) do
    aura_env.nameplates[guid] = nil
end
