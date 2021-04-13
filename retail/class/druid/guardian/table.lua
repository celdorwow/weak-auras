{
    ["backdropColor"] = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 0.5,
    },
    ["controlledChildren"] = {
        [1] = "CeldorIncarnationKotJTexture4",
        [2] = "CeldorIncarnationKotJTexture6",
        [3] = "CeldorIncarnationKotJTexture5",
        [4] = "CeldorShredGuardian GCD",
        [5] = "CeldorGuardianMangle",
        [6] = "CeldorGuardianThrash",
        [7] = "CeldorGuardianMaul",
        [8] = "CeldorGuardianIronfur",
        [9] = "CeldorIncarnationGoU",
        [10] = "CeldorFrenziedRegeneration",
        [11] = "CeldorGuardianPulverize",
        [12] = "CeldorGuardianEnergy",
        [13] = "CeldorGuardianMana",
        [14] = "CeldorIncapacitatingRoar",
        [15] = "CeldorTigerFury 2",
        [16] = "CeldorGuardianRegrowth",
        [17] = "CeldorGuardianSkullBash",
    },
    ["borderBackdrop"] = "Blizzard Tooltip",
    ["authorOptions"] = {
    },
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
    ["xOffset"] = 0,
    ["internalVersion"] = 26,
    ["borderEdge"] = "Square Full White",
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
    ["id"] = "CeldorDruidGuardian",
    ["borderOffset"] = 4,
    ["frameStrata"] = 1,
    ["anchorFrameType"] = "SCREEN",
    ["borderInset"] = 1,
    ["uid"] = "2mDS2i7epiS",
    ["config"] = {
    },
    ["subRegions"] = {
    },
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
    ["regionType"] = "group",
}
