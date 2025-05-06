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

    atlas = "OneTimeAtlas",
    pos = { x = 0, y = 0},

    in_pool = function (self, args)
        return false
    end,

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
    discovered = true,

    pools = {
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "AlleeAtlas",
    pos = { x = 0, y = 0 },
    soul_pos = {x = 1, y = 0},

    -- card variables
    config = {
        extra = {}
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


-- Allee custom scoring loop
local evaluate_play_ref = G.FUNCS.evaluate_play
G.FUNCS.evaluate_play = function(e)
    
    local has_allee_joker = SMODS.find_card("j_ALLEECORD_alleesaur", false)
    local is_allee_active = false
    local allee_joker = nil
    if has_allee_joker[1] then
        allee_joker = has_allee_joker[1]
        is_allee_active = true
    end

    if is_allee_active then

        assert(allee_joker, "Could not find Allee Joker while assuming it exists.")

        local cards = G.play.cards
        if #cards < 5 then
            local selected_card = cards[pseudorandom("alleesaur", 1, #cards)]

            while #G.play.cards < 5 do
                local c = copy_card(selected_card, nil, nil, G.playing_card)
                c:set_ability(G.P_CENTERS.m_ALLEECORD_onetime, nil, true)
                c:add_to_deck()
                G.play:emplace(c)
                table.insert(G.playing_cards, c)
            end
        end

        card_eval_status_text(allee_joker, 'extra', nil, nil, nil, { message = localize{ type = "variable", key = "a_allee_collab" } })
    end

    evaluate_play_ref(e)
end
