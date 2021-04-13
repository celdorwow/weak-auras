function (s, e, ...)
    if e == "UNIT_AURA" then
        local debuff = {"Scorched Feet", 315385, 313963, 306275, 306255}

        local spellID, dur, exp, icon = aura_env.GetUnitAuras("player", debuff, WA_GetUnitDebuff, "HARMFUL")

        if spellID then
            if not aura_env.aura then
                aura_env.aura = true
                s["sf"] = {
                    icon = 237583,
                    show = true,
                    changed = true,
                    autoHide = true,
                    progressType = "timed",
                    duration = aura_env.jump_delay,
                    expirationTime = aura_env.jump_delay + GetTime(),
                }
                return true
            end
        else
            aura_env.aura = false
            s["sf"] = {
                show = false,
                changed = true
            }
            return true
        end
    end
end
