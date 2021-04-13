function (e, ...)
    local cs = aura_env.current_state
    local crem = (aura_env.crystals_reminder or {})[aura_env.mapID]
    local L = aura_env.L

    if e == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, _, spellID = ...   -- unit, castGUID, spellID
        if spellID == 143394
        and (unit == "player" or string.match(unit, "party%d"))
        then
            -- Crystal
            if cs.zonestat then
                cs.zonestat:addcrystal()
                -- announcement
                if unit == "player" then
                    local msg = "|cFFFFFF00"..L["Crystal"].."|r"
                    aura_env.annoucer(msg)
                end
                -- Update clones
                WeakAuras.ScanEvents("CELDOR_HV_ZONE_CHANGED", -1)
            end
            if crem then crem.collected = true end
        elseif spellID == 306608 and unit == "player" then
            -- Chest
            cs.chestloot = true
            if cs.chesttimer then cs.chesttimer:Cancel() end
            cs.chesttimer = C_Timer.NewTimer(8, function()
                    cs.chestloot = false
            end)
            -- Announcement
            local msg = "|cFFd483ff" .. L["Chest"] .. "|r"
            aura_env.annoucer(msg)
        elseif spellID == 303967 and unit == "player" then
            -- Teleport
            crem.sound = false
            C_Timer.After(10, function() crem.sound = true end)
        end
    end

    if e == "CELDOR_HV_CORRMEMS_CHANGED" then
        cs.corrmems = aura_env.getcurrency()
        if cs.chestloot then
            cs.chestloot = false
            -- Mementos collected from a chest
            if cs.zonestat then
                cs.zonestat:addchest()
                -- Update clones
                WeakAuras.ScanEvents("CELDOR_HV_ZONE_CHANGED", -1)
            end
            -- Reward collected from the last chest
            local x, y = aura_env.getpos()
            if crem and crem:isinarea(x, y, crem.npc) then
                crem.handedin = true
            end
        end
    end

    -- Send announcement to a chat window
    if e == "CHAT_MSG_ADDON" then
        local prefix, msg = ...
        if prefix == aura_env.auracomprefix
        and aura_env.config.announcements
        then
            ChatFrame1:AddMessage(msg)
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
        end
    end

    -- Force to stop / restart warnings when in comnbat
    -- boss encounter cancel warnings, completely
    if e == "PLAYER_REGEN_DISABLED" then
        crem.sound = false
    elseif e == "PLAYER_REGEN_ENABLED" then
        crem.sound = true
    end
    if e == "ENCOUNTER_START" then
        local encID = ...
        -- 2332 for Thrall the Corrupted, 2338 for Alleria Windrunner
        if encID == 2332 or encID == 2338 then
            crem.counter = 0
        end
    end
end
