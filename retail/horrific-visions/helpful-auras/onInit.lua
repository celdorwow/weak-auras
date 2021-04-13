function aura_env.getzonename()
    local mapID = C_Map.GetBestMapForUnit("player")
    local mapInfo = mapID and C_Map.GetMapInfo(mapID) or nil
    local zone = mapInfo and mapInfo.name or ""
    --local sb = GetSubZoneText()
    local smz = GetMinimapZoneText()
    if not zone or zone == "" then return smz end
    return zone
end
