-- Helper functions
ALLEECORD = {}

--- @param arr table<any> The table to search for `obj` in
--- @param obj any The object to find in the table
--- @return integer|nil idx The index of the object if it is
--- found, or nil if the table doesn't contain obj 
ALLEECORD.contains = function(arr, obj)
    for i=1, #arr do
        if arr[i] and arr[i] == obj then
            return i
        end
    end

    return nil
end

-- Custom localization colors
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.snaking_straights = HEX("ab749a")
    return lc(_c, _default)
end

-- Set all ranks to include "ALLEECORD_Stonewippen_Stone"
-- as an "after" rank
for _, r in pairs(SMODS.Ranks) do
    if r.next and not ALLEECORD.contains(r.next, "ALLEECORD_Stonewippen_Stone") then
        table.insert(r.next, "ALLEECORD_Stonewippen_Stone")
    end
end
