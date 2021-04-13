function(s, e, ...)
    -- Open a config set
    if WeakAuras.IsOptionsOpen() or ((aura_env or {}).config or {}).titlebar then
        s["titlebar"] = {
            progressType = "static",
            value = 0,
            total = 200,
            show = true,
            changed = true,
            subzones = aura_env.L["Subzones"],
            chests = aura_env.L["Chests"],
            crystals = aura_env.L["Crystals"],
        }
        return true
    else
        s["titlebar"] = {
            show = false,
            changed = true,
        }
        return true
    end
end
