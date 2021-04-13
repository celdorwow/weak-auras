{
    ["parent"] = "Horrific Vision Potion Cheatsheet",
    ["yOffset"] = 0,
    ["anchorPoint"] = "CENTER",
    ["cooldownSwipe"] = true,
    ["cooldownEdge"] = false,
    ["actions"] = {
        ["start"] = {
        },
        ["init"] = {
        },
        ["finish"] = {
        },
    },
    ["triggers"] = {
        [1] = {
            ["trigger"] = {
                ["type"] = "custom",
                ["custom_type"] = "stateupdate",
                ["customVariables"] = "{\\n    triggered = \\\"bool\\\",\\n}",
                ["subeventSuffix"] = "_CAST_START",
                ["event"] = "Health",
                ["unit"] = "player",
                ["events"] = "PLAYER_ENTERING_WORLD, CLEU:SPELL_AURA_APPLIED",
                ["custom"] = "function(allstates, event, ...)\\n    local hasvalue = aura_env.hasvalue\\n    \\n    if not tIndexOf({\\\"PLAYER_ENTERING_WORLD\\\", \\\"COMBAT_LOG_EVENT_UNFILTERED\\\"}, event) then return end\\n    \\n    -- Init\\n    if event == \\\"PLAYER_ENTERING_WORLD\\\" then\\n        allstates.cheatdeath = allstates.cheatdeath or {\\n            icon = 236225,\\n            autoHide = false,\\n            progressType = \\\"static\\\",\\n            value = 0,\\n            total = 0,\\n            changed = true,\\n            show = true,\\n            triggered = false,\\n        }\\n        return true\\n    end\\n    \\n    -- check cleu\\n    local player = WeakAuras.myGUID\\n    local subevent, _, sourceGUID, sourceName, _, _, destGUID, destName = select(2, ...)\\n    local spellId, spellName = select(12, ...)\\n    if sourceGUID == player and destGUID == player then\\n        if subevent == \\\"SPELL_AURA_APPLIED\\\" then\\n            if (spellName == \\\"Emergency Cranial Defibrillation\\\"\\n                or tIndexOf({\\\"304815\\\", \\\"304816\\\", \\\"317864\\\", \\\"317865\\\"}, spellId)) then\\n                allstates.cheatdeath.triggered = true\\n            end\\n        end\\n    end\\n    \\n    return true\\nend",
                ["spellIds"] = {
                },
                ["custom_hide"] = "custom",
                ["check"] = "event",
                ["names"] = {
                },
                ["subeventPrefix"] = "SPELL",
                ["debuffType"] = "HELPFUL",
            },
            ["untrigger"] = {
            },
        },
        ["activeTriggerMode"] = -10,
    },
    ["internalVersion"] = 26,
    ["keepAspectRatio"] = false,
    ["animation"] = {
        ["start"] = {
            ["type"] = "none",
            ["duration_type"] = "seconds",
        },
        ["main"] = {
            ["type"] = "none",
            ["duration_type"] = "seconds",
        },
        ["finish"] = {
            ["type"] = "none",
            ["duration_type"] = "seconds",
        },
    },
    ["desaturate"] = false,
    ["subRegions"] = {
        [1] = {
            ["type"] = "subborder",
            ["border_offset"] = 1,
            ["border_color"] = {
                [1] = 0,
                [2] = 0,
                [3] = 0,
                [4] = 1,
            },
            ["border_visible"] = true,
            ["border_edge"] = "Square Full White",
            ["border_size"] = 1,
        },
        [2] = {
            ["type"] = "subborder",
            ["border_offset"] = 0,
            ["border_color"] = {
                [1] = 0.19607843137255,
                [2] = 0.19607843137255,
                [3] = 0.19607843137255,
                [4] = 0.70000001788139,
            },
            ["border_visible"] = true,
            ["border_edge"] = "Square Full White",
            ["border_size"] = 3,
        },
    },
    ["height"] = 40,
    ["load"] = {
        ["use_petbattle"] = false,
        ["zoneId"] = "1469, 1470",
        ["spec"] = {
            ["multi"] = {
            },
        },
        ["use_encounterid"] = false,
        ["use_zoneId"] = true,
        ["use_vehicleUi"] = false,
        ["use_size"] = true,
        ["class"] = {
            ["multi"] = {
            },
        },
        ["size"] = {
            ["single"] = "scenario",
            ["multi"] = {
                ["scenario"] = true,
            },
        },
    },
    ["regionType"] = "icon",
    ["selfPoint"] = "CENTER",
    ["xOffset"] = 102,
    ["icon"] = true,
    ["displayIcon"] = "236225",
    ["zoom"] = 0.28,
    ["cooldownTextDisabled"] = false,
    ["auto"] = false,
    ["width"] = 40,
    ["id"] = "HV Emergency Cranial Defibrillation",
    ["uid"] = "tfV6s33)aLQ",
    ["alpha"] = 1,
    ["anchorFrameType"] = "SCREEN",
    ["authorOptions"] = {
        [1] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option1",
            ["default"] = false,
            ["name"] = "Option 1",
            ["width"] = 1,
        },
        [2] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option2",
            ["default"] = false,
            ["name"] = "Option 2",
            ["width"] = 1,
        },
        [3] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option3",
            ["default"] = false,
            ["name"] = "Option 3",
            ["width"] = 1,
        },
        [4] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option4",
            ["default"] = false,
            ["name"] = "Option 4",
            ["width"] = 1,
        },
        [5] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option5",
            ["default"] = false,
            ["name"] = "Option 5",
            ["width"] = 1,
        },
        [6] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option6",
            ["default"] = false,
            ["name"] = "Option 6",
            ["width"] = 1,
        },
        [7] = {
            ["type"] = "toggle",
            ["useDesc"] = false,
            ["key"] = "option7",
            ["default"] = false,
            ["name"] = "Option 7",
            ["width"] = 1,
        },
    },
    ["config"] = {
        ["option7"] = false,
        ["option4"] = false,
        ["option1"] = false,
        ["option5"] = false,
        ["option6"] = false,
        ["option2"] = false,
        ["option3"] = false,
    },
    ["inverse"] = false,
    ["frameStrata"] = 1,
    ["conditions"] = {
        [1] = {
            ["check"] = {
                ["trigger"] = 1,
                ["variable"] = "triggered",
                ["value"] = 1,
            },
            ["changes"] = {
                [1] = {
                    ["value"] = {
                        [1] = 0.50980392156863,
                        [2] = 0.2078431372549,
                        [3] = 0.2078431372549,
                        [4] = 1,
                    },
                    ["property"] = "color",
                },
                [2] = {
                    ["value"] = {
                        [1] = 0.29411764705882,
                        [2] = 0.13333333333333,
                        [3] = 0.13333333333333,
                        [4] = 0.6700000166893,
                    },
                    ["property"] = "sub.2.border_color",
                },
            },
        },
    },
    ["cooldown"] = false,
    ["color"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 1,
    },
}
