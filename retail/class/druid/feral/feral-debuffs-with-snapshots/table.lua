{
    ["backdropColor"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 0.5,
    },
    ["controlledChildren"] = {
        [1] = "CeldorAllTheBuffs",
        [2] = "CeldorIncarnationKotJTexture1",
        [3] = "CeldorIncarnationKotJTexture3",
        [4] = "CeldorIncarnationKotJTexture2",
        [5] = "CeldorFeralEnergy",
        [6] = "CeldorFeralMana",
        [7] = "CeldorClearCastingBar",
        [8] = "CeldorShred GCD",
        [9] = "CeldorRake",
        [10] = "CeldorRip",
        [11] = "CeldorThrash",
        [12] = "CeldorFerociousBite",
        [13] = "CeldorTigerFury",
        [14] = "CeldorPredatoryInstinct",
        [15] = "CeldorSkullBash",
        [16] = "CeldorRegrowth",
        [17] = "CeldorBrutalSlash",
        [18] = "Jungle Stalker",
        [19] = "CeldorBloodtalon",
        [20] = "CeldorSavageRoar",
        [21] = "CeldorFeralFrenzy",
        [22] = "CeldorRipandTear",
        [23] = "CeldorIncarnationKotJIcon",
        [24] = "WolfieFeralProwl",
        [25] = "CP1_bg1",
        [26] = "CP1",
        [27] = "CP1_bg2",
        [28] = "CP2",
        [29] = "CP1_bg3",
        [30] = "CP3",
        [31] = "CP1_bg4",
        [32] = "CP4",
        [33] = "CP1_bg5",
        [34] = "CP5",
    },
    ["borderBackdrop"] = "Blizzard Tooltip",
    ["authorOptions"] = {
    },
    ["preferToUpdate"] = false,
    ["border"] = false,
    ["borderEdge"] = "Square Full White",
    ["regionType"] = "group",
    ["borderSize"] = 2,
    ["borderColor"] = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 1,
    },
    ["yOffset"] = -325,
    ["scale"] = 1,
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
                ["type"] = "aura2",
                ["subeventSuffix"] = "_CAST_START",
                ["event"] = "Health",
                ["subeventPrefix"] = "SPELL",
                ["spellIds"] = {
                },
                ["names"] = {
                },
                ["unit"] = "player",
                ["debuffType"] = "HELPFUL",
            },
            ["untrigger"] = {
            },
        },
    },
    ["anchorPoint"] = "CENTER",
    ["borderOffset"] = 4,
    ["uid"] = "YkANzFLZ)aN",
    ["tocversion"] = 80300,
    ["id"] = "CeldorDruidFeral",
    ["xOffset"] = 0,
    ["frameStrata"] = 1,
    ["anchorFrameType"] = "SCREEN",
    ["internalVersion"] = 26,
    ["borderInset"] = 1,
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
    ["subRegions"] = {
    },
    ["selfPoint"] = "BOTTOMLEFT",
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
    ["config"] = {
    },
}
