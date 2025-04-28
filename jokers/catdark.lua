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
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "CatdarkAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            base_xmult = 1,
            additional_bonus = 0.5,
        }
    },

    loc_vars = function(self, info_queue, card)

        if G.GAME.catdarkmult then
            return {
                vars = {
                    card.ability.extra.base_xmult + G.GAME.catdarkmult,
                    card.ability.extra.additional_bonus
                }
            }
        else
            return {
                vars = {
                    card.ability.extra.base_xmult,
                    card.ability.extra.additional_bonus
                }
            }
        end    
        
	end,

    -- Shop Price
    cost = 6,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = true,

    -- in-game calculation
    calculate = function(self, card, context)
        
        if context.joker_main then
            local xmult_curr = G.GAME.catdarkmult + card.ability.extra.base_xmult

            return {
                xmult = xmult_curr
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)

        -- when gained, add 1x mult to global counter iff
        -- not from debuff
        if not(from_debuff) then
            G.GAME.catdarkmult = G.GAME.catdarkmult + card.ability.extra.additional_bonus
        end
    end,
}