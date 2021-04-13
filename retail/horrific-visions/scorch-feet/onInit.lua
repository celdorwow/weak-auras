function aura_env.GetUnitAuras(unit, spells, f, filter)
    if not f then f = WA_GetUnitBuff end
    if not filter then filter = "HELPFUL" end
    for _, aura in ipairs(spells) do
        local name, icon, count, _, dur, exp, _, _, _, spellID = f(unit, aura, filter)
        if spellID then
            return spellID, dur, exp, icon, count
        end
    end
end

aura_env.aura = false
aura_env.jump_delay = 2
