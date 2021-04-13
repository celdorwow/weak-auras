-- Reset stored values
for k, v in pairs(aura_env.districts) do
    for _, z in ipairs(v) do z:reset() end
end

-- Reset warning
for _, c in pairs(aura_env.crystals_reminder) do
    c:reset()
end

-- empty table
local sz = aura_env.subzones
for _=1, #sz do tremove(sz, 1) end

-- Reset current state
local cs = aura_env.current_state
cs.index = 0
cs.zonestat = false
cs.corrmems = 0
cs.chestloot = false
