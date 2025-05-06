local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "FairyuAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Fairyu.png"
}

SMODS.Joker {
    -- joker identifier
    key = "fairyu",
    discovered = true,

    pools = {
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "FairyuAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            additional_xchips = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)

        local clubs_count = 0
            if G.hand then
                for _, c in ipairs(G.hand.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.discard then
                for _, c in ipairs(G.discard.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.play then
                for _, c in ipairs(G.play.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.deck then
                for _, c in ipairs(G.deck.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

        return {
            vars = {
                card.ability.extra.additional_xchips,
                1 + clubs_count * card.ability.extra.additional_xchips
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

        -- The part where the actual score happens
        if context.joker_main then
            local clubs_count = 0
            if G.hand then
                for _, c in ipairs(G.hand.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.discard then
                for _, c in ipairs(G.discard.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.play then
                for _, c in ipairs(G.play.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            if G.deck then
                for _, c in ipairs(G.deck.cards) do
                    if not SMODS.has_no_suit(c) and c:is_suit("Clubs") then
                        clubs_count = clubs_count + 1
                    end
                end
            end

            return {
                xchips = 1 + clubs_count * card.ability.extra.additional_xchips
            }
        end
    end,
}
