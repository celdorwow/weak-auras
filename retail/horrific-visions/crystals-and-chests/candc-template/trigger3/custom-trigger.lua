function ()
    local cs = aura_env.current_state

    -- Throttle
    if not cs.tick() then return end

    -- Currupted Memntos update
    if aura_env.getcurrency() ~= cs.corrmems then
        WeakAuras.ScanEvents("CELDOR_HV_CORRMEMS_CHANGED")
    end

    -- Get current subzone
    local dist = aura_env.districts
    local x, y = aura_env.getpos()
    local mapID = aura_env.mapID
    local crem = (aura_env.crystals_reminder or {})[mapID]
    local L = aura_env.L

    -- Check boss area
    if aura_env.config.crystalsalarm
    and cs.tick_warn() and crem
    and crem:isinarea(x, y, crem.boss)
    and crem:visitnpc()
    and crem:iscounter()
    and crem.isvocal()
    then
        crem:updatecounter(-1)
        aura_env.warning(L["You have crystals to turn in"], L["Crystals"]:upper())
    end

    -- Check subzone
    if (dist or {})[mapID] then
        for i, z in ipairs(dist[mapID]) do
            if z:isinarea(x, y) then
                if i == cs.index then return end
                WeakAuras.ScanEvents("CELDOR_HV_ZONE_CHANGED", i)
                return true
            end
        end

        if cs.index == 0 then return end
        WeakAuras.ScanEvents("CELDOR_HV_ZONE_CHANGED", 0)
    end
end
