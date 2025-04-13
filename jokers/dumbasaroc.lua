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
            "Each played {C:attention}2{}, {C:attention}4{}, and {C:attention}8{} gives",
            "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult when scored."
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
		
        return {
            vars = {
                card.ability.extra.chips_per,
                card.ability.extra.mult_per,
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