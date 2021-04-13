CeldorGlobalElementalAura = {
    SpellDuration = function (self)
        -- Get number
        local d = 0;
        local s = self.SpellDescription(self.id);
        local mf = s:match("for %d+\.%d+ sec") or s:match("for %d+\.%d+ min") or nil;
        local mw = s:match("for %d+ sec") or s:match("for %d+ min") or nil;
        if mf then
            d = mf:match("%d+\.%d+");
        elseif mw then
            d = mw:match("%d+");
        end
        -- Get multiplier
        if (mf and mf:match("min")) or (mw and mw:match("min")) then
            d = d*60;
        end
        return tonumber(d);
    end,
    Duration = function (self)
        local d = self:SpellDuration() or 0;
        return d;
    end,
    SpellInfo = function (self)
        return self.name, self.id, self.icon, self.pet;
    end,
    SpellDescription = GetSpellDescription,
    new = function (self, spell)
        if not spell then return end
        local name, _, icon, _, _, _, spellID = GetSpellInfo(spell);
        local o = {
            id = spellID,
            name = name,
            icon =  icon,   -- icon,
            pet = false,
        }
        setmetatable(o, self);
        return o;
    end,
}
CeldorGlobalElementalAura.__index = CeldorGlobalElementalAura;

WeakAuras.ScanEvents("GLOBAL_ELEMENTAL_AURA_INIT")
