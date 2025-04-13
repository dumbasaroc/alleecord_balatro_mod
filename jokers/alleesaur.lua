local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "AlleeAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Alleesaur.png"
}

SMODS.Joker {
    -- joker identifier
    key = "alleesaur",

    -- description
    loc_txt = {
        name = "Alleesaur",
        text = {
            "TBD",
        },
    },
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "AlleeAtlas",
    pos = { x = 0, y = 0 },
    soul_pos = {x = 1, y = 0},

    -- card variables
    config = {
        extra = {
            
        }
    },

    -- loc_vars = function(self, info_queue, card)	
    --     return {}
	-- end,

    -- Shop Price
    cost = 20,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 4,

    -- in-game calculation
    calculate = function(self, card, context)

        
    end,
}
