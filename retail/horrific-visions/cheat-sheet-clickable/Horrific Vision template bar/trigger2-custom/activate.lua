function(event, colours)
    if event ~= "CELDOR_SET_CLICKABLE_FRAMES" then return end
    local clickable = aura_env.ClicableFrame
    for i, v in ipairs(aura_env.info) do
        local region = WeakAuras.GetRegion(aura_env.id, v.effect)
        local button = clickable(region, v.effect)
    end
end
