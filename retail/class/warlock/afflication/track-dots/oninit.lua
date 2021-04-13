aura_env.nameplates = {}
aura_env.current_state = {
    initialised = false
}

-- Clones
function aura_env.resetclones(allstates)
    for _, s in pairs(allstates) do
        s.show = false
        s.changed = true
    end
end
function aura_env.createclones(guid, name, current)
    return {
        id = guid,
        progressType = "static",
        value = 100,
        total = 100,
        name = name,
        autoHide = false,
        show = true,
        changed = true,
        currenttarget = current,
    }
end
