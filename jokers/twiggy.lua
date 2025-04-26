local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "TwiggyAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Twiggy.png"
}

SMODS.Joker {
    -- joker identifier
    key = "twiggy",

    -- description
    loc_txt = {
        name = "Twigsagi",
        text = {
            "At the end of each round,",
            "any {C:attention}Planet Cards{}",
            "in the consumable area have a",
            "{C:green}#1# in #2#{} chance to upgrade",
            "their corresponding hand."
        },
    },
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "TwiggyAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            out_of = 4
        }
    },

    loc_vars = function(self, info_queue, card)
		
        return {
            vars = {
                G.GAME and G.GAME.probabilities.normal or 1,
                card.ability.extra.out_of
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
        
        if context.end_of_round and context.cardarea == G.jokers then
            for i, c in ipairs(G.consumeables.cards) do
                if c.config.center.set == "Planet" and pseudorandom("twiggy") < G.GAME.probabilities.normal/card.ability.extra.out_of then
                    card_eval_status_text(c, 'extra', nil, nil, nil, { message = localize("k_level_up_ex") })
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=c.config.center.config.hand_type,chips = G.GAME.hands[c.config.center.config.hand_type].chips, mult = G.GAME.hands[c.config.center.config.hand_type].mult, level=G.GAME.hands[c.config.center.config.hand_type].level})
                    level_up_hand(c, c.config.center.config.hand_type)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                end
            end
        end
    end,
}