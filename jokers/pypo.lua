local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "PypoAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Peripypo.png"
}

SMODS.Joker {
    -- joker identifier
    key = "pypo",
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "PypoAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            did_play_straight_last = false,
            last_played_straight = {},
            base_xmult = 1,
            current_bonus = 0,
            additional_bonus = 1,
        }
    },

    loc_vars = function(self, info_queue, card)

        info_queue[#info_queue + 1] = {key = 'o_snaking_desc', set = 'Other'}
		
        return {
            vars = {
                card.ability.extra.base_xmult + card.ability.extra.current_bonus,
                card.ability.extra.additional_bonus
            }
        }
	end,

    -- Shop Price
    cost = 8,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 2,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = true,

    -- in-game calculation
    calculate = function(self, card, context)

        local table_contains = function(tbl, val)
            for _, x in ipairs(tbl) do
                if x == val then return true end
            end
            return false
        end

        local is_hand_snaking = function(prev_hand, this_hand)
            local ctr = 0
            for _, idx in ipairs(prev_hand) do
                if table_contains(this_hand, idx) then ctr = ctr + 1 end
            end

            return ctr == 1
        end

        local conv_hand_to_list_idxs = function(hand)
            local conv = {}

            for _, c in ipairs(hand) do
                local idx = c:get_id()
                if not(table_contains(conv, idx)) then
                    table.insert(conv, idx)
                end
            end

            return conv
        end
        
        -- First, make sure that everything is happening
        -- before scoring happens.
        if context.before and not context.blueprint then

            -- Then, we do different things based on whether
            -- the hand scoring contains a Straight or not
            if next(context.poker_hands['Straight']) then

                -- Now that we know this is a Straight, we can check
                -- if this hand snakes with the last one AND the last
                -- hand was a straight
                local this_hand = conv_hand_to_list_idxs(context.scoring_hand)

                if card.ability.extra.did_play_straight_last and is_hand_snaking(card.ability.extra.last_played_straight, this_hand) then
                    card.ability.extra.current_bonus = card.ability.extra.current_bonus + card.ability.extra.additional_bonus
                    
                    return {
                        message = "Snaked!",
                        colour = G.C.PURPLE
                    }
                end

                card.ability.extra.did_play_straight_last = true
                card.ability.extra.last_played_straight = this_hand

            else
                card.ability.extra.did_play_straight_last = false
                card.ability.last_played_straight = {}
            end
        end

        -- Main Scoring Phase, just apply XMult
        if context.joker_main then
            return {
                xmult = card.ability.extra.base_xmult + card.ability.extra.current_bonus
            }
        end
    end,
}
