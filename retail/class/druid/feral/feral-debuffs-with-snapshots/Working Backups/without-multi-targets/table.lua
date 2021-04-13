{
    ["backdropColor"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 0.5,
    },
    ["controlledChildren"] = {
        [1] = "CeldorBTBuff",
        [2] = "CeldorTFBuff",
        [3] = "CeldorStealthandIncBuff",
        [4] = "CeldorIncarnationKotJTexture1",
        [5] = "CeldorIncarnationKotJTexture3",
        [6] = "CeldorIncarnationKotJTexture2",
        [7] = "CeldorFeralEnergy",
        [8] = "CeldorFeralMana",
        [9] = "CeldorShred GCD",
        [10] = "CeldorRake",
        [11] = "CeldorRip",
        [12] = "CeldorThrash",
        [13] = "CeldorFerociousBite",
        [14] = "CeldorTigerFury",
        [15] = "CeldorPredatoryInstinct",
        [16] = "CeldorSkullBash",
        [17] = "CeldorRegrowth",
        [18] = "CeldorClearCastingBar",
        [19] = "CeldorFeralFrenzy",
        [20] = "CeldorRipandTear",
        [21] = "CeldorBrutalSlash",
        [22] = "Jungle Stalker",
        [23] = "CeldorBloodtalon",
        [24] = "CeldorSavageRoar",
        [25] = "CeldorIncarnationKotJIcon",
        [26] = "WolfieFeralProwl",
    },
    ["borderBackdrop"] = "Blizzard Tooltip",
    ["authorOptions"] = {
    },
    ["preferToUpdate"] = false,
    ["border"] = false,
    ["yOffset"] = -325,
    ["anchorPoint"] = "CENTER",
    ["borderSize"] = 2,
    ["scale"] = 1,
    ["borderColor"] = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 1,
    },
    ["selfPoint"] = "BOTTOMLEFT",
    ["actions"] = {
        ["start"] = {
        },
        ["finish"] = {
        },
        ["init"] = {
        },
    },
    ["triggers"] = {
        [1] = {
            ["trigger"] = {
                ["type"] = "aura2",
                ["subeventSuffix"] = "_CAST_START",
                ["event"] = "Health",
                ["names"] = {
                },
                ["spellIds"] = {
                },
                ["subeventPrefix"] = "SPELL",
                ["unit"] = "player",
                ["debuffType"] = "HELPFUL",
            },
            ["untrigger"] = {
            },
        },
    },
    ["borderEdge"] = "Square Full White",
    ["internalVersion"] = 26,
    ["regionType"] = "group",
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
    ["id"] = "CeldorDruidFeral",
    ["xOffset"] = 0,
    ["frameStrata"] = 1,
    ["anchorFrameType"] = "SCREEN",
    ["borderOffset"] = 4,
    ["borderInset"] = 1,
    ["config"] = {
    },
    ["subRegions"] = {
    },
    ["tocversion"] = 80300,
    ["conditions"] = {
    },
    ["load"] = {
        ["use_class"] = "true",
        ["spec"] = {
            ["multi"] = {
            },
        },
        ["class"] = {
            ["single"] = "DRUID",
            ["multi"] = {
            },
        },
        ["size"] = {
            ["multi"] = {
            },
        },
    },
    ["uid"] = "YkANzFLZ)aN",
}
