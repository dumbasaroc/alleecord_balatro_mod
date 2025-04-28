local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "RocAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "DumbAsARoc.png"
}

SMODS.Joker {
    -- joker identifier
    key = "dumbasaroc",
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "RocAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            chips_probabilities = {
                {nchips = 1, cutoff = 1/10},
                {nchips = 2, cutoff = 2/10},
                {nchips = 4, cutoff = 4/10},
                {nchips = 8, cutoff = 6/10},
                {nchips = 16, cutoff = 8/10},
                {nchips = 32, cutoff = 9/10},
                {nchips = 64, cutoff = 10/10},
            },
            mult_probabilities = {
                {nmult = 1, cutoff = 1/8},
                {nmult = 2, cutoff = 3/8},
                {nmult = 4, cutoff = 5/8},
                {nmult = 8, cutoff = 7/8},
                {nmult = 16, cutoff = 8/8},
            }
        }
    },

    -- NOTE FOR FUTURE ROC
    -- Chips probabilities are either 1/10 or 2/10, depending
    --   on how close they are to the center value
    -- Mult probabilities are either 1/8 or 2/8 by the same metric
    loc_vars = function(self, info_queue, card)

        local chips_rand = {"1", "2", "4", "4", "8", "8", "16", "16", "32", "64"}
        local mult_rand = {"1", "2", "2", "4", "4", "8", "8", "16"}
        
        return {
            main_start = {
                {n = G.UIT.C, config={align='tm'}, nodes = {
                    {n=G.UIT.R, config={align="cm"}, nodes = {
                        {n = G.UIT.T, config={text = "Each scored ", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                        {n = G.UIT.T, config={text = "2", colour=G.C.IMPORTANT, scale=0.32}},
                        {n = G.UIT.T, config={text = ", ", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                        {n = G.UIT.T, config={text = "4", colour=G.C.IMPORTANT, scale=0.32}},
                        {n = G.UIT.T, config={text = ", and ", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                        {n = G.UIT.T, config={text = "8", colour=G.C.IMPORTANT, scale=0.32}},        
                    }},
                    {n=G.UIT.R, config={align="cm"}, nodes = {
                        {n = G.UIT.T, config={text="gives ", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                        {n = G.UIT.T, config={text="+", colour=G.C.CHIPS, scale=0.32}},
                        {n = G.UIT.O, config={object = DynaText({string = chips_rand, colours = {G.C.CHIPS}, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
                        {n = G.UIT.T, config={text=" chips", colour=G.C.CHIPS, scale=0.32}},
                        {n = G.UIT.T, config={text=" and ", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                        {n = G.UIT.T, config={text="+", colour=G.C.MULT, scale=0.32}},
                        {n = G.UIT.O, config={object = DynaText({string = mult_rand, colours = {G.C.MULT}, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.2011, scale = 0.32, min_cycle_time = 0})}},
                        {n = G.UIT.T, config={text=" Mult", colour=G.C.MULT, scale=0.32}},
                        {n = G.UIT.T, config={text=".", colour=G.C.UI.TEXT_DARK, scale=0.32}},
                    }}
                }}
            }
        }
	end,

    -- Shop Price
    cost = 8,
    rarity = 2,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = true,

    -- in-game calculation
    calculate = function(self, card, context)
        
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if other:get_id() == 2 or other:get_id() == 4 or other:get_id() == 8 then
                local chips_roll = pseudorandom("dumbasaroc")
                local mult_roll = pseudorandom("dumbasaroc")
                local nchips = 1
                local nmult = 1
                
                for _, chips_tbl in ipairs(card.ability.extra.chips_probabilities) do
                    if chips_roll <= chips_tbl.cutoff then
                        nchips = chips_tbl.nchips
                        break
                    end
                end
                for _, mult_tbl in ipairs(card.ability.extra.mult_probabilities) do
                    if mult_roll <= mult_tbl.cutoff then
                        nmult = mult_tbl.nmult
                        break
                    end
                end

                return {
                    chips = nchips,
                    mult = nmult
                }
            end
        end
    end,
}