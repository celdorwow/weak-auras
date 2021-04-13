-- https://gist.github.com/GigsD4X/8513963
aura_env.colour = {}
function aura_env.colour.HSV2RGB( hue, saturation, value )
    -- Returns the RGB equivalent of the given HSV-defined color
    -- (adapted from some code found around the web)

    -- If it's achromatic, just return the value
    if saturation == 0 then
        return value;
    end;

    -- Get the hue sector
    local hue_sector = math.floor( hue / 60 );
    local hue_sector_offset = ( hue / 60 ) - hue_sector;

    local p = value * ( 1 - saturation );
    local q = value * ( 1 - saturation * hue_sector_offset );
    local t = value * ( 1 - saturation * ( 1 - hue_sector_offset ) );

    if hue_sector == 0 then
        return value, t, p;
    elseif hue_sector == 1 then
        return q, value, p;
    elseif hue_sector == 2 then
        return p, value, t;
    elseif hue_sector == 3 then
        return p, q, value;
    elseif hue_sector == 4 then
        return t, p, value;
    elseif hue_sector == 5 then
        return value, p, q;
    end;
end
function aura_env.colour.RGB2HSV( red, green, blue )
    -- Returns the HSV equivalent of the given RGB-defined color
    -- (adapted from some code found around the web)

    local hue, saturation, value;

    local min_value = math.min( red, green, blue );
    local max_value = math.max( red, green, blue );

    value = max_value;

    local value_delta = max_value - min_value;

    -- If the color is not black
    if max_value ~= 0 then
        saturation = value_delta / max_value;

        -- If the color is purely black
    else
        saturation = 0;
        hue = -1;
        return hue, saturation, value;
    end;

    if red == max_value then
        hue = ( green - blue ) / value_delta;
    elseif green == max_value then
        hue = 2 + ( blue - red ) / value_delta;
    else
        hue = 4 + ( red - green ) / value_delta;
    end;

    hue = hue * 60;
    if hue < 0 then
        hue = hue + 360;
    end;

    return hue, saturation, value;
end


function aura_env.createclones(states)
    local cp = UnitPower("player", Enum.PowerType.ComboPoints)
    local max_cp = UnitPowerMax("player", Enum.PowerType.ComboPoints)
    for i=1, max_cp do
        local id = "cp"..i
        states[id] = {
            id = id,
            name = id,
            progressType = "static",
            value = cp >= i and 100 or 0,
            total = 100,
            index = i,
            autoHide = false,
            show = true,
            changed = true,
        }
    end
end
