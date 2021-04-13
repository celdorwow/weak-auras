function(allstates, event, ...)
    if not tIndexOf({"PLAYER_ENTERING_WORLD", "COMBAT_LOG_EVENT_UNFILTERED"}, event) then return end

    -- Init
    if event == "PLAYER_ENTERING_WORLD" then
        allstates.cheatdeath = allstates.cheatdeath or {
            icon = 236225,
            autoHide = false,
            progressType = "static",
            value = 0,
            total = 0,
            changed = true,
            show = true,
            triggered = false,
        }
        return true
    end

    -- check cleu
    local player = WeakAuras.myGUID
    local subevent, _, sourceGUID, _, _, _, destGUID = select(2, ...)
    local spellId, spellName = select(12, ...)
    if sourceGUID == player and destGUID == player then
        if subevent == "SPELL_AURA_APPLIED" then
            if (spellName == "Emergency Cranial Defibrillation"
                or tIndexOf({"304815", "304816", "317864", "317865"}, spellId)) then
                allstates.cheatdeath.triggered = true
            end
        end
    end

    return true
end
