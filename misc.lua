-- Custom localization colors
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.snaking_straights = HEX("ab749a")
    return lc(_c, _default)
end