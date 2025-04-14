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

    -- description
    loc_txt = {
        name = "DumbAsARoc",
        text = {
            ""
        },
    },
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
            chips_per = 64,
            mult_per = 16,
        }
    },

    loc_vars = function(self, info_queue, card)

        chips_rand = {"1", "2", "4", "8", "16", "32", "64"}
        mult_rand = {"1", "2", "4", "8", "16"}
        
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
    cost = 7,
    rarity = 2,

    -- in-game calculation
    calculate = function(self, card, context)
        
        if context.individual and context.cardarea == G.play then
            local other = context.other_card
            if other:get_id() == 2 or other:get_id() == 4 or other:get_id() == 8 then
                return {
                    chips = card.ability.extra.chips_per,
                    mult = card.ability.extra.mult_per
                }
            end
        end
    end,
}