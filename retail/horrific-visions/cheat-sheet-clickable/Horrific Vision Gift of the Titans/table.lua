{
    ["xOffset"] = 150,
    ["preferToUpdate"] = false,
    ["customText"] = "function()\\n    local str \\n    if aura_env.expirationTime > GetTime() then\\n        str = \\\"in progress\\\"\\n    elseif aura_env.expirationTime + 60 > GetTime() then\\n        str = \\\"on Cooldown\\\"\\n    else\\n        str = \\\"Available\\\"\\n    end\\n    \\n    local str_exptime\\n    if aura_env.state and aura_env.state.expirationTime then\\n        local expTime = aura_env.state.expirationTime or 0\\n        local remTime = expTime - GetTime()\\n        if remTime > 0 then\\n            if remTime >= aura_env.softCD then\\n                remTime = remTime - aura_env.softCD\\n            end\\n            str_exptime = aura_env.format_duration(remTime, 4)\\n        end\\n    end\\n    return str, str_exptime\\nend\\n\\n\\n",
    ["yOffset"] = 44,
    ["anchorPoint"] = "CENTER",
    ["cooldownSwipe"] = true,
    ["customTextUpdate"] = "update",
    ["cooldownEdge"] = false,
    ["actions"] = {
        ["start"] = {
        },
        ["finish"] = {
        },
        ["init"] = {
            ["do_custom"] = true,
            ["custom"] = "local function format_seconcs(t, threshold)\\n    threshold = threshold or 4\\n    local str_frmt\\n    if t > threshold then\\n        str_frmt = string.format(\\\"%.0f\\\", t)\\n    else\\n        str_frmt = string.format(\\\"|cFFFF0000%.1f|r\\\", t)\\n    end\\n    return str_frmt\\nend\\n\\nfunction aura_env.format_duration(t)\\n    local secs, rsecs = t % 60, t - t % 60\\n    local mins, rmins = rsecs/60 % 60, rsecs/60 - rsecs/60 % 60\\n    local hours, rhours = rmins/60 % 60, rmins/60 - rmins/60 % 60\\n    local str_frmt\\n    --\\n    if hours > 0 then\\n        str_frmt = tostring(hours)..\\\"h\\\"\\n    elseif mins > 0 then\\n        str_frmt = tostring(mins)..\\\"m\\\"\\n    elseif secs > 0 then\\n        str_frmt = format_seconcs(secs)\\n    end\\n    return str_frmt\\nend\\n\\naura_env.expirationTime = 0\\naura_env.hardCD = aura_env.config.hardCD or 60\\naura_env.softCD = aura_env.config.softCD or 30\\n\\n\\n",
        },
    },
    ["triggers"] = {
        [1] = {
            ["trigger"] = {
                ["type"] = "custom",
                ["debuffType"] = "HELPFUL",
                ["subeventSuffix"] = "_CAST_START",
                ["unit"] = "player",
                ["duration"] = "1",
                ["event"] = "Chat Message",
                ["subeventPrefix"] = "SPELL",
                ["names"] = {
                },
                ["spellIds"] = {
                },
                ["custom"] = "function(allstates, event, ...)\\n    if event ~= \\\"UNIT_AURA\\\" and event ~= \\\"CELDOR_RESET_GIFT\\\" and event ~= \\\"PLAYER_ENTERING_WORLD\\\" then return end\\n    \\n    -- initialize after player entered scenario\\n    if event == \\\"PLAYER_ENTERING_WORLD\\\" then\\n        allstates[\\\"titans\\\"] = allstates[\\\"titans\\\"] or {\\n            icon = 2000853,\\n            progressType = \\\"timed\\\",\\n            autoHide = false,\\n            show = true,\\n            changed = true,\\n            progressState = 0,\\n        }\\n        return true\\n    end\\n    \\n    local unit = ...\\n    if unit ~= \\\"player\\\" then return end\\n    \\n    -- configure aura\\n    local state = allstates[\\\"titans\\\"]\\n    \\n    -- reset aura\\n    if event == \\\"CELDOR_RESET_GIFT\\\" then\\n        state.progressState = select(2, ...)\\n    end\\n    \\n    -- check aura\\n    local name, icon, _, _, duration, expirationTime = WA_GetUnitBuff(\\\"player\\\",\\\"Gift of the Titans\\\")\\n    \\n    if name then\\n        aura_env.expirationTime = expirationTime\\n        -- state\\n        state.progressState = 1\\n        state.duration = duration\\n        state.expirationTime = expirationTime\\n    elseif state.progressState == 1 then\\n        state.progressState = 2   -- On hard cooldown\\n        state.duration = aura_env.hardCD + aura_env.softCD\\n        state.expirationTime = GetTime() + aura_env.hardCD + aura_env.softCD\\n    end\\n    state.autoHide = false\\n    state.show = true\\n    state.changed = true\\n    return true\\nend",
                ["custom_type"] = "stateupdate",
                ["check"] = "event",
                ["events"] = "PLAYER_ENTERING_WORLD, UNIT_AURA:player, CELDOR_RESET_GIFT",
                ["unevent"] = "timed",
                ["customVariables"] = "{\\n    expirationTime = true,\\n    progressState = {\\n        type = \\\"select\\\",\\n        display = \\\"Progress state\\\",\\n        values = {\\n            [0] = \\\"Ready\\\",\\n            [1] = \\\"In progress\\\",\\n            [2] = \\\"On cooldown\\\",\\n        }\\n    }\\n}",
            },
            ["untrigger"] = {
            },
        },
        [2] = {
            ["trigger"] = {
                ["type"] = "aura2",
                ["auraspellids"] = {
                    [1] = "313698",
                },
                ["event"] = "Health",
                ["unit"] = "player",
                ["subeventPrefix"] = "SPELL",
                ["useExactSpellId"] = true,
                ["subeventSuffix"] = "_CAST_START",
                ["debuffType"] = "HELPFUL",
            },
            ["untrigger"] = {
            },
        },
        ["disjunctive"] = "any",
        ["activeTriggerMode"] = -10,
    },
    ["useTooltip"] = false,
    ["keepAspectRatio"] = false,
    ["selfPoint"] = "CENTER",
    ["desaturate"] = false,
    ["subRegions"] = {
        [1] = {
            ["border_size"] = 1,
            ["border_offset"] = 1,
            ["border_color"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["border_visible"] = true,
            ["border_edge"] = "Square Full White",
            ["type"] = "subborder",
        },
        [2] = {
            ["border_size"] = 3,
            ["border_offset"] = 0,
            ["border_color"] = {
                [1] = 0.1921568627451,
                [2] = 0.1921568627451,
                [3] = 0.1921568627451,
                [4] = 1,
            },
            ["border_visible"] = true,
            ["border_edge"] = "Square Full White",
            ["type"] = "subborder",
        },
        [3] = {
            ["glowFrequency"] = 0.25,
            ["glow"] = false,
            ["useGlowColor"] = false,
            ["text_color"] = {
            },
            ["glowLength"] = 10,
            ["glowYOffset"] = 0,
            ["glowColor"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["glowType"] = "buttonOverlay",
            ["type"] = "subglow",
            ["glowScale"] = 1,
            ["glowThickness"] = 1,
            ["glowXOffset"] = 0,
            ["glowLines"] = 8,
            ["glowBorder"] = false,
        },
        [4] = {
            ["text_shadowXOffset"] = 0,
            ["type"] = "subtext",
            ["text_text"] = "%c2",
            ["text_color"] = {
                [1] = 1,
                [2] = 1,
                [3] = 1,
                [4] = 1,
            },
            ["text_font"] = "Friz Quadrata TT",
            ["text_shadowColor"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["text_shadowYOffset"] = 0,
            ["text_selfPoint"] = "AUTO",
            ["text_visible"] = true,
            ["text_fontType"] = "OUTLINE",
            ["text_anchorPoint"] = "CENTER",
            ["anchorYOffset"] = 0,
            ["text_justify"] = "CENTER",
            ["rotateText"] = "NONE",
            ["anchorXOffset"] = 0,
            ["text_fontSize"] = 16,
        },
    },
    ["height"] = 40,
    ["load"] = {
        ["use_size"] = true,
        ["use_petbattle"] = false,
        ["zoneId"] = "1469, 1470",
        ["use_vehicleUi"] = false,
        ["class"] = {
            ["multi"] = {
            },
        },
        ["spec"] = {
            ["multi"] = {
            },
        },
        ["use_zoneId"] = true,
        ["size"] = {
            ["single"] = "scenario",
            ["multi"] = {
                ["scenario"] = true,
            },
        },
    },
    ["zoom"] = 0,
    ["regionType"] = "icon",
    ["conditions"] = {
        [1] = {
            ["check"] = {
                ["trigger"] = 2,
                ["variable"] = "show",
                ["value"] = 1,
            },
            ["changes"] = {
                [1] = {
                    ["value"] = true,
                    ["property"] = "sub.3.glow",
                },
            },
        },
        [2] = {
            ["check"] = {
                ["trigger"] = 2,
                ["variable"] = "show",
                ["value"] = 0,
            },
            ["changes"] = {
                [1] = {
                    ["value"] = {
                        [1] = 0.38039215686275,
                        [2] = 0.4,
                        [3] = 0.4078431372549,
                        [4] = 1,
                    },
                    ["property"] = "color",
                },
            },
        },
        [3] = {
            ["check"] = {
                ["trigger"] = -2,
                ["variable"] = "AND",
                ["checks"] = {
                    [1] = {
                        ["trigger"] = 1,
                        ["variable"] = "expirationTime",
                        ["value"] = "30",
                        ["op"] = ">=",
                    },
                    [2] = {
                        ["trigger"] = 1,
                        ["variable"] = "progressState",
                        ["value"] = 2,
                        ["op"] = "==",
                    },
                },
            },
            ["changes"] = {
                [1] = {
                    ["value"] = {
                        [1] = 0.82352941176471,
                        [2] = 0.003921568627451,
                        [3] = 0.003921568627451,
                        [4] = 1,
                    },
                    ["property"] = "sub.2.border_color",
                },
            },
        },
        [4] = {
            ["check"] = {
                ["trigger"] = -2,
                ["variable"] = "AND",
                ["checks"] = {
                    [1] = {
                        ["trigger"] = 1,
                        ["variable"] = "expirationTime",
                        ["value"] = "30",
                        ["op"] = "<",
                    },
                    [2] = {
                        ["trigger"] = 1,
                        ["variable"] = "progressState",
                        ["value"] = 2,
                        ["op"] = "==",
                    },
                },
            },
            ["changes"] = {
                [1] = {
                    ["value"] = {
                        [1] = 0.85490196078431,
                        [2] = 0.36862745098039,
                        [3] = 0,
                        [4] = 1,
                    },
                    ["property"] = "sub.2.border_color",
                },
            },
        },
        [5] = {
            ["check"] = {
                ["trigger"] = -2,
                ["variable"] = "AND",
                ["checks"] = {
                    [1] = {
                        ["trigger"] = 1,
                        ["variable"] = "expirationTime",
                        ["value"] = "0",
                        ["op"] = "<=",
                    },
                    [2] = {
                        ["trigger"] = 1,
                        ["op"] = "==",
                        ["variable"] = "progressState",
                        ["value"] = 2,
                    },
                },
            },
            ["changes"] = {
                [1] = {
                    ["value"] = {
                        ["custom"] = "if aura_env.state and aura_env.state.progressState then\\n    WeakAuras.ScanEvents(\\\"CELDOR_RESET_GIFT\\\", \\\"player\\\", 0)\\nend",
                    },
                    ["property"] = "customcode",
                },
            },
        },
    },
    ["parent"] = "Horrific Vision Potion Cheatsheet",
    ["internalVersion"] = 26,
    ["authorOptions"] = {
        [1] = {
            ["type"] = "description",
            ["fontSize"] = "large",
            ["text"] = "Why there are two cooldowns?",
            ["width"] = 2,
        },
        [2] = {
            ["type"] = "space",
            ["variableWidth"] = false,
            ["height"] = 1,
            ["width"] = 2,
            ["useHeight"] = false,
        },
        [3] = {
            ["type"] = "description",
            ["fontSize"] = "medium",
            ["text"] = "I included two cooldowns and called them: |cFFFF0000Hard|r and |cFFff9340Soft|r. Within |cFFFF0000Hard|r CD it is unlikely |cFFffe57cGift|r will occur. |cFFff9340Soft|r CD is duration after |cFFFF0000Hard|r CD when probability that |cFFffe57cGift|r will proc is greatly increased.\\n\\nBoth settings are stored in |cFF0000FFaura_env|r, in case timings are inaccurate and need adjusting. If |cFFff9340Soft|r CD is changed, the thresholds in |cFF00FF00Conditions|r related to each coloured border should also be changed to the same value as the one stored in |cFF0000FFaura_env|r.|cFFff9340softCD|r.",
            ["width"] = 2,
        },
        [4] = {
            ["type"] = "space",
            ["variableWidth"] = false,
            ["height"] = 1,
            ["width"] = 2,
            ["useHeight"] = false,
        },
        [5] = {
            ["useName"] = true,
            ["type"] = "header",
            ["text"] = "Settings",
            ["width"] = 1,
        },
        [6] = {
            ["type"] = "range",
            ["useDesc"] = false,
            ["max"] = 60,
            ["step"] = 1,
            ["width"] = 2,
            ["min"] = 0,
            ["name"] = "|cFFFF0000Hard|r CD",
            ["default"] = 0,
            ["key"] = "hardCD",
        },
        [7] = {
            ["type"] = "range",
            ["useDesc"] = false,
            ["max"] = 30,
            ["step"] = 1,
            ["width"] = 1,
            ["min"] = 0,
            ["name"] = "|cFFff9340Soft|r CD",
            ["default"] = 0,
            ["key"] = "softCD",
        },
    },
    ["icon"] = true,
    ["config"] = {
        ["hardCD"] = 60,
        ["softCD"] = 30,
    },
    ["cooldownTextDisabled"] = false,
    ["auto"] = false,
    ["tocversion"] = 80300,
    ["id"] = "Horrific Vision Gift of the Titans",
    ["width"] = 40,
    ["frameStrata"] = 1,
    ["anchorFrameType"] = "SCREEN",
    ["alpha"] = 1,
    ["uid"] = "4rlPD47XuV9",
    ["inverse"] = false,
    ["animation"] = {
        ["start"] = {
            ["duration_type"] = "seconds",
            ["type"] = "none",
        },
        ["main"] = {
            ["duration_type"] = "seconds",
            ["type"] = "none",
        },
        ["finish"] = {
            ["duration_type"] = "seconds",
            ["type"] = "none",
        },
    },
    ["displayIcon"] = "2000853",
    ["cooldown"] = true,
    ["color"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
    },
}
