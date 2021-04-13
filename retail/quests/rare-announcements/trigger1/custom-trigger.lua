function (e, ...)
    if e == "RARE_MESSAGE_INIT_MAPID" then
        aura_env.mapID = C_Map.GetBestMapForUnit("player")
        return
    end


    if e == "RARE_MESSAGE_JOIN_CHANNEL" then
        local c = ... or 1
        local cch = aura_env.custom_channel
        if not cch:getindex() then
            if c <= 10 then
                C_Timer.After(0.5, function()
                        WeakAuras.ScanEvents("RARE_MESSAGE_JOIN_CHANNEL", c + 1)
                end)
            else
                DEFAULT_CHAT_FRAME:AddMessage("|Celdor's Rare Announcer|r: |cFFFF6000Error joining the custom channel!|r")
            end
        else
            if not cch:islast() then
                cch:movetolast()
            end
        end
        return
    end


    if e == "CHANNEL_UI_UPDATE"
    or e == "CHANNEL_COUNT_UPDATE"
    or e == "CHAT_MSG_CHANNEL_JOIN"
    then
        local cch = aura_env.custom_channel
        if not cch:islast() then
            cch:movetolast()
        end
        return
    end


    if e:match("ZONE_CHANGED") then
        -- Init mapID
        C_Timer.After(0.1, function ()
                WeakAuras.ScanEvents("RARE_MESSAGE_INIT_MAPID")
        end)
        return
    end


    if e == "NAME_PLATE_UNIT_ADDED" or e == "UNIT_HEALTH" or e == "PLAYER_TARGET_CHANGED"
    then
        local unit
        --
        if e == "NAME_PLATE_UNIT_ADDED" then
            unit = ...
        else
            unit = "target"
        end
        -- Clear if an invalid unit then leave
        if not UnitExists(unit)
        or UnitIsDead(unit)
        or UnitIsPlayer(unit)
        or not UnitClassification(unit):lower():match("rare")
        then
            aura_env.removeunit(UnitGUID(unit))
            return
        end
        --
        local rare = aura_env.checkbyunit(unit)
        if aura_env.config.getmessage
        and rare and not rare:isoncd()
        then
            rare:announce(unit)
            rare:setcooldown()
        end
        return
    end


    if e == "CHAT_MSG_ADDON" then
        local pre, msg, ch = ...
        if not aura_env.config.getmessage or pre ~= aura_env.warareprefix
        then
            return
        end

        -- parse message
        local senderGUID, senderMapID, rareName, rareGUID, level, health, x, y = aura_env.parse_msg(msg)

        -- Check if players are in the same zone, health is above threshold
        -- a player's already targetting the rare
        if senderMapID ~= aura_env.mapID or UnitGUID("target") == rareGUID or health < aura_env.config.hpthreshold
        then
            return
        end

        -- Tag or check rare
        local rare = aura_env.checkbyguid(rareGUID, rareName, level, 60)
        if rare:isoncd() then
            return
        end

        -- Set cooldown to avoid multiple notifications
        rare:setcooldown()
        -- Collect data
        local senderClass, _, _, _, senderName = select(2, GetPlayerInfoByGUID(senderGUID))
        local senderColour = select(4, GetClassColor(senderClass))
        -- Substitute placeholders
        local msg_display = aura_env.config.message:gsub("%%n", "|c" .. aura_env.colours.rare .. rareName .. "|r"):gsub("%%l", level):gsub("%%h", health):gsub("%%c", ("%.1f %.1f"):format(x*100, y*100))
        -- Display Notification
        DEFAULT_CHAT_FRAME:AddMessage(msg_display)
        if aura_env.config.sound then
            -- TELL_MESSAGE
            PlaySound(SOUNDKIT.RAID_BOSS_EMOTE_WARNING, "Dialog")
        end
        -- TomTom waypoints
        if WeakAuras.myGUID ~= senderGUID
        and aura_env.config.tomtom
        and x and y and TomTom
        then
            local strrare = "|c" .. aura_env.colours.rare .. rareName .. "|r (" .. level .. ")"
            local strsender = "|c" .. senderColour .. senderName .. "|r"
            aura_env.tomtomopts.title = "Rare: " .. strrare .. "\nSender: " .. strsender
            aura_env.tomtomopts.source = senderName
            local wayUID = TomTom:AddWaypoint(aura_env.mapID, x, y, aura_env.tomtomopts)
        end
    end
    return
end
