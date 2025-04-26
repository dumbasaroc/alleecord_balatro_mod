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
        name = "Stone Rank"
    },

    -- I dunno what this maps to, i'll be real
    pos = { x = 0 },

    face = true,
    strength_effect = { ignore = true },

    next = { "Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King" },
    straight_edge = true,

    in_pool = function(self, args)
        if args.initial_deck then
            return false
        end
    end,
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
        if context.cardarea == G.play then
            print("In context!")
            for i, c in ipairs(context.full_hand) do
                print("Card "..tostring(i))
                if SMODS.has_enhancement(c, "m_stone") then
                    assert(SMODS.change_base(c, nil, 'ALLEECORD_Stonewippen_Stone'))
                end
            end
        end
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

local always_scores_ref = SMODS.always_scores
function SMODS.always_scores(card)
    
    for k, _ in pairs(SMODS.get_enhancements(card)) do
        if k == 'm_stone' and not card.vampired and next(SMODS.find_card('j_ALLEECORD_stonewippen', false)) then
            return
        end
    end
    
    local retval = always_scores_ref(card)
    return retval
end
