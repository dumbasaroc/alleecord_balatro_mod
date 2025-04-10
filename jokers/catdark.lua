local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "CatdarkAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Catdark.png"
}

SMODS.Joker {
    -- joker identifier
    key = "catdark",

    -- description
    loc_txt = {
        name = "Catdark",
        text = {
            "Each instance of this Joker gains",
            "{X:mult,C:white} X#2# {} Mult each time a new one is obtained.",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        },
    },
    discovered = true,

    -- image parameters
    atlas = "CatdarkAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            base_xmult = 1,
            additional_bonus = 1,
        }
    },

    loc_vars = function(self, info_queue, card)
		
        if G.GAME.catdarkmult == nil then
            return {
                vars = {
                    card.ability.extra.base_xmult,
                    card.ability.extra.additional_bonus
                }
            }   
        else
            return {
                vars = {
                    G.GAME.catdarkmult + card.ability.extra.base_xmult,
                    card.ability.extra.additional_bonus
                }
            }
        end
	end,

    -- Shop Price
    cost = 5,

    -- in-game calculation
    calculate = function(self, card, context)
        
        if context.joker_main then
            xmult_curr = G.GAME.catdarkmult + card.ability.extra.base_xmult

            return {
                xmult = xmult_curr
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)

        -- when gained, add 1x mult to global counter iff
        -- not from debuff
        if not(from_debuff) then
            G.GAME.catdarkmult = G.GAME.catdarkmult + 1
        end
    end,
}