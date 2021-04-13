local UnitGUID = UnitGUID
local UnitExists = UnitExists
local tinsert = tinsert
local tContains = tContains
local tIndexOf = tIndexOf
local tDeleteItem = tDeleteItem

local function process_auras(sp, st, unit, se)
    if tIndexOf({"SPELL_AURA_APPLIED", "SPELL_AURA_REFRESH"}, se) then
        if (st or {}).buff or (sp or {}).buff then
            sp:add(unit)
        else
            sp:remove(unit)
        end
    else
        -- set everything to state before cast
        local scast = sp.spellcast
        scast.success = false
        sp:remove(unit)
    end
end


local function check_debuff(unit, ...)
    local has_debuff = false
    for i, debuff in ipairs({...}) do
        local _, _, _, _, dur, exp, _, _, _, spellid = WA_GetUnitDebuff(unit, debuff)
        has_debuff = has_debuff or (spellid and GetTime() < exp)
    end
    return has_debuff
end


function CeldorTriggerOnFunction(auratable, sp, st, event, ...)
    -- st -- additional spell for the same buff
    if not sp then return end

    local targetGUID = UnitGUID("target")
    local iscast = sp.iscast   --auratable.debuff_info.iscast
    local single = auratable.debuff_info.single
    local aoe = auratable.debuff_info.aoe
    local myGUID = WeakAuras.myGUID
    local scast = sp.spellcast
    local se = auratable.debuff_info.subevents

    -- check spell if still on the current target
    if event == "PLAYER_TARGET_CHANGED" then
        if not targetGUID then return end
        sp:check_all(single and single.bleedid or 0, aoe and aoe.bleedid or 0)
        return sp:check(targetGUID)
    end

    -- collect cleu
    local _, subevent, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID = ...

    -- check if a player
    if sourceGUID ~= myGUID then return end

    -- check if spellID is of the spell
    if (single and tIndexOf({single.spellid, single.bleedid}, spellID))
    or (aoe and tIndexOf({aoe.spellid, aoe.bleedid}, spellID)) then
        if tIndexOf({"SPELL_AURA_APPLIED", "SPELL_AURA_REMOVED", "SPELL_AURA_REFRESH"}, subevent) then
            -- single or multutarget
            if single and targetGUID == destGUID then
                process_auras(sp, st, targetGUID, subevent)
            elseif aoe and destGUID then
                process_auras(sp, st, destGUID, subevent)
            end
            if (sp.spellcast or {}).getreset then
                sp.buff = false
            end
        end
    end

    return sp:check(targetGUID)
end

CeldorBuffTracker = {
    add = function (self, destGUID)
        if not destGUID then return end
        if not self:check(destGUID) then
            tinsert(self.targets, destGUID)
        end
    end,
    remove = function (self, destGUID, debuff)
        if not destGUID then return end
        if debuff and check_debuff("target", debuff) then return end
        tDeleteItem(self.targets, destGUID)
    end,
    check = function (self, destGUID)
        if not destGUID then return end
        return tContains(self.targets, destGUID)
    end,
    check_all = function (self, ...)
        if #self.targets == 0 then return end
        for i = 1, 40 do
            local unit = "nameplate"..i
            if not UnitExists(unit) or not check_debuff(unit, ...) then
                tDeleteItem(self.targets, UnitGUID(unit))
            end
            if #self.targets == 0 then break end
        end
    end,
    new = function (self, gr)
        local o = {
            buff = false,
            iscast = false,
            targets = {},
            spellcast = {
                spellid = 0,
                success = false,
                getreset = gr and true or nil,
            },
        }
        setmetatable(o, self)
        return o
    end,
}
CeldorBuffTracker.__index = CeldorBuffTracker


aura_env.cbuff = {
    check = function(self, spellID)
        return self[spellID]
    end,
    set = function (self, val)
        self.ison = val
    end,
    send = function (self)
        if (self.ison and not self.sent) or (not self.ison and self.sent) then
            self.sent = not self.sent
            WeakAuras.ScanEvents(self.event, self.sent)
        end
    end,
    new = function (self, spellID, event)
        local o = {
            [spellID] = true,
            event = event,
            ison = false,
            sent = false
        }
        self.__index = self
        setmetatable(o, self)
        return o
    end,
}

local buff = aura_env.cbuff
aura_env.bt = buff:new(145152, "CELDOR_BT_AURA")
aura_env.tf = buff:new(5217, "CELDOR_TF_AURA")
aura_env.st = buff:new(5215, "CELDOR_IS_IN_PROWL")
aura_env.inc = buff:new(102543, "CELDOR_INCARNATION_BUFF")

WeakAuras.ScanEvents("CELDOR_FERAL_ACTIVATE")
