-- Get mod path
local mod_path = "" .. SMODS.current_mod.path

-- Load all Jokers
local files = NFS.getDirectoryItems(mod_path .. "jokers")
for _, file in ipairs(files) do
    print("[ALLEECORD] Loading Joker description " .. file)
    local f, err = SMODS.load_file("jokers/" .. file)
    if err then
        error(err)
    end
    f()
end

-- Set up per-run stuff
SMODS.current_mod.reset_game_globals = function(run_start)
    if run_start then
        -- Initialize Catdark's initial xmult bonus
        G.GAME.catdarkmult = 0
    end
end
