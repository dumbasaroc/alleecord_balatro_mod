-- Custom localization colors
local lc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        lc()
    end
    G.ARGS.LOC_COLOURS.snaking_straights = HEX("ab749a")
    return lc(_c, _default)
end



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

        card_eval_status_text(allee_joker, 'extra', nil, nil, nil, { message = "Friend Group!" })
    end
    
    evaluate_play_ref(e)
end
