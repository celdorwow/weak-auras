function (s, e, ...)
    local cs = aura_env.current_state
    local ns = aura_env.nameplates

    if not cs.initialised then
        cs.initialised = true
        for i = 1,40 do
            local unit = "nameplate"..i
            if UnitExists(unit) then
                local guid, name = UnitGUID(unit), UnitName(unit)
                ns[guid] = {name = name}
            end
        end
    end

    if e == "PLAYER_TARGET_CHANGED" then
        WeakAuras.ScanEvents("CELDOR_LOCK_AFFLICTION_CREATE_CLONES")
    end

    if e == "NAME_PLATE_UNIT_ADDED" or e == "NAME_PLATE_UNIT_REMOVED" then
        local unit = ...
        if not unit then return end
        local guid, name = UnitGUID(unit), UnitName(unit)
        if e == "NAME_PLATE_UNIT_ADDED" and not ns[guid] then
            ns[guid] = {name = name}
        elseif e == "NAME_PLATE_UNIT_REMOVED" and ns[guid] then
            ns[guid] = nil
        end
        WeakAuras.ScanEvents("CELDOR_LOCK_AFFLICTION_CREATE_CLONES")
    end

    if e == "CELDOR_LOCK_AFFLICTION_CREATE_CLONES" then
        local target = UnitGUID("target")
        aura_env.resetclones(s)
        for guid, n in pairs(ns) do
            s[guid] = aura_env.createclones(guid, n.name, target == guid)
        end

        return true
    end
end
