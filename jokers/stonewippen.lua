local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "StonewippenAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Stonewippen.png"
}

SMODS.Joker {
    -- joker identifier
    key = "stonewippen",

    -- description
    loc_txt = {
        name = "Stonewippen",
        text = {
            "TBD"
        },
    },
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "StonewippenAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {}
    },

    loc_vars = function(self, info_queue, card)
        return {}    
	end,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 1,
    -- Shop Price
    cost = 6,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = true,

    -- in-game calculation
    calculate = function(self, card, context)
    end,
}
