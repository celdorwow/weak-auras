function (s, e, ...)
    -- Open a config set
    if WeakAuras.IsOptionsOpen() then
        if not aura_env.config.optionsdisplay then return end
        aura_env.createtestclones(s)
        -- Test sound
        if aura_env.config.announcementsound then
            if aura_env.config.soundkit
            and aura_env.config.soundkit ~= ""
            then
                PlaySound(SOUNDKIT[aura_env.config.soundkit], "Dialog")
            elseif aura_env.config.path
            and aura_env.config.path ~= ""
            then
                PlaySoundFile(aura_env.config.path)
            end
        end
        return true
    end


    if e == "PLAYER_ENTERING_WORLD" then
        -- Init mapID
        C_Timer.After(0.2, function ()
                WeakAuras.ScanEvents("CELDOR_HV_INIT_AURA")
        end)
    end


    if e == "CELDOR_HV_INIT_AURA" then
        aura_env.mapID = C_Map.GetBestMapForUnit("player")
    end


    if e == "CELDOR_HV_ZONE_CHANGED" then
        local n = ...
        if not n then return end
        --
        local zonestat = nil
        local subzone = nil
        local cs = aura_env.current_state
        local sz = aura_env.subzones
        local d = aura_env.districts
        local mapID = aura_env.mapID
        --
        if n == -1 then n = cs.index end
        --
        if mapID and ((d or {})[mapID] or {})[n] then
            zonestat = aura_env.districts[mapID][n]
            if not aura_env.hasValue(sz, zonestat.subzone, "subzone") then
                tinsert(sz, zonestat)
                if aura_env.config.sort then aura_env.sort(sz) end
            end
            subzone = zonestat.subzone
        end
        if #sz > 0 then
            -- reset clones
            aura_env.resetclones(s)
            for i, z in ipairs(sz) do
                local id = "id"..z.subzone:gsub("%s+", "")
                i = #sz - i + 1
                s[id] = aura_env.createclones(i, z, subzone)
            end
        end
        cs.index = n
        cs.zonestat = zonestat
    end

    return true
end
