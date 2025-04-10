local joker_atlas = SMODS.Atlas {
    -- image key
    key = "RocTestCard",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "test_card.png"
}

SMODS.Joker {
    -- joker identifier
    key = "roc_test_joker",

    -- description
    loc_txt = {
        name = "Test Joker",
        text = {
            "Adds {C:mult}+#2#{} Mult every",
            "time this card is triggered.",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
        },
    },

    -- image parameters
    atlas = "RocTestCard",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            mult = 4,
            additional_mult_when_scored = 2,
        }
    },

    loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.additional_mult_when_scored
            }
        }
	end,

    -- Shop Price
    cost = 1,

    -- in-game calculation
    calculate = function(self, card, context)
        
        -- this joker simply adds +4 mult (like jimmy)
        if context.joker_main then
            local curr_mult = card.ability.extra.mult
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.additional_mult_when_scored

            return {
                mult_mod = curr_mult,

                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = { curr_mult }
                }
            }
        end
    end,
}
