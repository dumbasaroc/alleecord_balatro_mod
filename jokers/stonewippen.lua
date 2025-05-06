local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "StonewippenAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Stonewippen.png"
}

local stone_rank = SMODS.Rank {

    key = 'Stonewippen_Stone',
    card_key = 'ST',

    nominal = 0,
    loc_txt = {
        name = "Stone"
    },

    -- I dunno what this maps to, i'll be real
    pos = { x = 0 },

    face = true,
    strength_effect = { ignore = true },

    next = { "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "ALLEECORD_Stonewippen_Stone" },
    straight_edge = true,

    in_pool = function(self, args)
        return false
    end,
}

SMODS.Joker {
    -- joker identifier
    key = "stonewippen",
    discovered = true,

    pools = {
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
    rarity = 3,
    -- Shop Price
    cost = 12,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = false,


    -- TODO Note that this does not affect cards changed
    -- via the Tower *after* the stonewippen joker
    -- is obtained. Fix that pls

    -- TODO bug: If you make a stone card stone again, it will
    -- overwrite the "stonewippen_original_rank" field and when
    -- removing the enhancement, it will make the rank stay weird

    add_to_deck = function (self, card, from_debuff)
        if G.deck then
            for _, c in ipairs(G.deck.cards) do
                if SMODS.has_enhancement(c, "m_stone") and not c.stonewippen_original_rank then
                    c.stonewippen_original_rank = c:get_original_rank()
                    assert(SMODS.change_base(c, nil, 'ALLEECORD_Stonewippen_Stone'))
                end
            end
        end

        if G.hand then
            for _, c in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(c, "m_stone") and not c.stonewippen_original_rank then
                    c.stonewippen_original_rank = c:get_original_rank()
                    assert(SMODS.change_base(c, nil, 'ALLEECORD_Stonewippen_Stone'))
                end
            end
        end
    end,

    remove_from_deck = function (self, card, from_debuff)
        if G.deck then
            for _, c in ipairs(G.deck.cards) do
                if SMODS.has_enhancement(c, "m_stone") and c.stonewippen_original_rank then
                    assert(SMODS.change_base(c, nil, c.stonewippen_original_rank))
                    c.stonewippen_original_rank = nil
                elseif c.stonewippen_original_rank then
                    c.stonewippen_original_rank = nil
                end
            end
        end

        if G.hand then
            for _, c in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(c, "m_stone") and c.stonewippen_original_rank then
                    assert(SMODS.change_base(c, nil, c.stonewippen_original_rank))
                    c.stonewippen_original_rank = nil
                elseif c.stonewippen_original_rank then
                    c.stonewippen_original_rank = nil
                end
            end
        end
    end,

    -- in-game calculation
    calculate = function(self, card, context)
    end,
}

local has_no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    for k, _ in pairs(SMODS.get_enhancements(card)) do
        if k == 'm_stone' and not card.vampired and next(SMODS.find_card('j_ALLEECORD_stonewippen', false)) then
            return
        end
    end
    local retval = has_no_rank_ref(card)
    return retval
end

local set_ability_ref = Card.set_ability;
function Card:set_ability(center, initial, delay_sprites)
    local retval = set_ability_ref(self, center, initial, delay_sprites)
    if SMODS.has_enhancement(self, "m_stone") and next(SMODS.find_card("j_ALLEECORD_stonewippen", false)) and not self.stonewippen_original_rank then
        self.stonewippen_original_rank = self:get_original_rank()
        assert(SMODS.change_base(self, nil, 'ALLEECORD_Stonewippen_Stone'))
    elseif not SMODS.has_enhancement(self, "m_stone") and self.stonewippen_original_rank then
        assert(SMODS.change_base(self, nil, self.stonewippen_original_rank))
        self.stonewippen_original_rank = nil
    end

    return retval
end
