local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "MelonsoldierAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Melonsoldier.png"
}

SMODS.Joker {
    -- joker identifier
    key = "melonsoldier",
    discovered = true,

    pools = {
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "MelonsoldierAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            current_xchips = 1,
            additional_xchips = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.current_xchips,
                card.ability.extra.additional_xchips
            }
        }    
	end,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 2,
    -- Shop Price
    cost = 8,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = true,

    -- in-game calculation
    calculate = function(self, card, context)
        
        if context.individual and context.cardarea == G.play and not context.blueprint then
            local c = context.other_card
            
            -- Only trigger on Jacks
            if c:get_id() == 11 then
                card.ability.extra.current_xchips = card.ability.extra.current_xchips + card.ability.extra.additional_xchips
                return {
                    message = localize({ type = "variable", key = "a_add_xchips", vars = { card.ability.extra.additional_xchips } }),
                    message_card = card,
                    colour = G.C.CHIPS,
                }
            end
        end

        -- The part where the actual score happens
        if context.joker_main then
            return {
                xchips = card.ability.extra.current_xchips
            }
        end
    end,
}