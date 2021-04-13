function(s, event, ...)
    if event ~= "UNIT_AURA" and event ~= "CELDOR_RESET_GIFT" and event ~= "PLAYER_ENTERING_WORLD" then return end

    -- initialize after player entered scenario
    if event == "PLAYER_ENTERING_WORLD" then
        s["titans"] = s["titans"] or {
            icon = 2000853,
            progressType = "timed",
            autoHide = false,
            show = true,
            changed = true,
            progressState = 0,
        }
        return true
    end

    local unit = ...
    if unit ~= "player" then return end

    -- configure aura
    local s = s["titans"]

    -- reset aura
    if event == "CELDOR_RESET_GIFT" then
        s.progressState = select(2, ...)
        s.duration = 0
        s.expirationTime = 0
        return true
    end

    -- check aura
    local name, _, _, _, dur, exp = WA_GetUnitBuff("player","Gift of the Titans")

    if name then
        s.progressState = 1
        s.duration = dur
        s.expirationTime = exp
        return true
    elseif s.progressState == 1 then
        s.progressState = 2   -- On hard cooldown
        s.duration = aura_env.hardCD + aura_env.softCD
        s.expirationTime = GetTime() + aura_env.hardCD + aura_env.softCD
        return true
    end
end
