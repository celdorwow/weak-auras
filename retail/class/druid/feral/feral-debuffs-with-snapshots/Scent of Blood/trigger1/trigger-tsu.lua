function (s, ev, ...)
    if ev == "PLAYER_ENTERING_WORLD" or ev == "PLAYER_TALENT_UPDATE" then
        if not select(4,  GetTalentInfo(6, 1, 1)) then return end
        s["sob"] = aura_env.empty_icon
        return true
    end

    --
    local sev, _, sourceGUID = select(2, ...)
    local spellID = select(12, ...)
    local sobSpellId = aura_env.sobSpellId

    --
    if sourceGUID ~= WeakAuras.myGUID then return end
    if spellID ~= sobSpellId then return end

    if sev == "SPELL_AURA_REMOVED" then
        s["sob"] = aura_env.empty_icon
        return true
    end

    if sev == "SPELL_AURA_APPLIED" or sev == "SPELL_AURA_REFRESH" then
        local no_targets = aura_env.count_targets(aura_env.thrash_range)

        s["sob"] = {
            name = "Scent of Blood",
            icon = 451161,
            progressType = "timed",
            duration = 6,
            expirationTime = 6 + GetTime(),
            autaHide = false,
            show = true,
            changed = true,
            targets = no_targets,
            energyred = no_targets*3,
        }
        return true
    end
end
