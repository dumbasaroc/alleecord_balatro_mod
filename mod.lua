-- Get mod path
local mod_path = "" .. SMODS.current_mod.path

-- Set Mod Icon
SMODS.Atlas {
    key = "modicon",
    path = "mod_icon.png",
    px = 64,
    py = 64,
}

-- -- Add Allee Deck Skin
local f, err = SMODS.load_file("DeckSkin.lua")
if err then
    error(err)
end
f()

-- Load misc.lua
local f, err = SMODS.load_file("misc.lua")
if err then
    error(err)
end
f()

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
