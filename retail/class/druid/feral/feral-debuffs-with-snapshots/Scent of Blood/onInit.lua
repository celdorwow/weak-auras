function aura_env.count_targets(range)
    -- count targets
    local n = 0
    for i=1,40 do
        local unit = "nameplate"..i
        if UnitExists(unit) and
        not UnitIsFriend("player", unit)
        and WeakAuras.CheckRange(unit, range, "<=") then
            n = n + 1
        end
    end
    return n
end

aura_env.empty_icon = {
    name = "Scent of Blood",
    icon = 451161,   -- druid's icon looks like Thrash O_o use this one: 461121
    progressType = "timed",
    duration = 0,
    expirationTime = 0,
    autaHide = false,
    show = true,
    changed = true,
    energy_red = 0,
}

aura_env.thSpellId = 106830   -- Thrash
aura_env.sobSpellId = 285646   -- Scent of Blood
aura_env.thrash_range = select(6, GetSpellInfo(aura_env.thSpellId))
