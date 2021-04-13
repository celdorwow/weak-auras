local function format_seconcs(t, threshold)
    threshold = threshold or 4
    local str_frmt
    if t > threshold then
        str_frmt = string.format("%.0f", t)
    else
        str_frmt = string.format("|cFFFF0000%.1f|r", t)
    end
    return str_frmt
end

local function throttle (duration)
    local exptime = 0
    return function ()
        if GetTime() - duration >= exptime then
            exptime = GetTime()
            return true
        end
    end
end

function aura_env.format_duration(t)
    local secs, rsecs = t % 60, t - t % 60
    local mins, rmins = rsecs/60 % 60, rsecs/60 - rsecs/60 % 60
    local hours = rmins/60 % 60
    local str_frmt
    --
    if hours > 0 then
        str_frmt = tostring(hours).."h"
    elseif mins > 0 then
        str_frmt = tostring(mins).."m"
    elseif secs > 0 then
        str_frmt = format_seconcs(secs)
    end
    return str_frmt
end

aura_env.hardCD = aura_env.config.hardCD or 60
aura_env.softCD = aura_env.config.softCD or 30
aura_env.th = throttle(0.25)
