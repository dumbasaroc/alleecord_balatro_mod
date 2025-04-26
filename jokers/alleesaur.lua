local alleesaur_atlas = SMODS.Atlas {
    -- image key
    key = "AlleeAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "Alleesaur.png"
}

local onetime_atlas = SMODS.Atlas {
    key = "OneTimeAtlas",

    px = 71,
    py = 95,

    path = "OneTime.png"
}

SMODS.Enhancement {
    key = "onetime",
    loc_txt = {
        name = "One-Time Only Card",
        text = {
            "At the end of a hand, if this card",
            "was scored, {C:attention}destroy{} this card."
        }
    },

    atlas = "OneTimeAtlas",
    pos = { x = 0, y = 0},

    calculate = function(self, card, context)

        if context.main_scoring and context.cardarea == G.play then
            card.config.onetime_has_scored = true
            return {}
        end

        if context.destroy_card and context.destroy_card == card and card.config.onetime_has_scored then
        -- if context.final_scoring_step and context.cardarea == G.play then
            -- print(inspect(context))
            -- print(inspect(context.cardarea))
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.playing_card = (G.playing_card and G.playing_card - 1) or 1
                    card:shatter();
                    
                    return true
                end
            }))
            return { remove = true, }
        end
    end
}

SMODS.Joker {
    -- joker identifier
    key = "alleesaur",

    -- description
    loc_txt = {
        name = "Alleesaur",
        text = {
            "If played hand has less than {C:attention}5{}",
            "cards, duplicate one card at random until",
            "there are 5 cards.",
            "The created cards will be {C:attention}One-Time Cards{}.",
        },
    },
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "AlleeAtlas",
    pos = { x = 0, y = 0 },
    soul_pos = {x = 1, y = 0},

    -- card variables
    config = {
        extra = {
            
        }
    },

    -- loc_vars = function(self, info_queue, card)	
    --     return {}
	-- end,

    -- Shop Price
    cost = 20,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 4,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = false,

    -- in-game calculation
    calculate = function(self, card, context)
        -- This is left empty because the real
        -- scoring loop is in `misc.lua`
        -- due to requiring an override in the
        -- function that identifies hands.
    end,
}
