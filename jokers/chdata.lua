local catdark_atlas = SMODS.Atlas {
    -- image key
    key = "ChDataAtlas",

    -- image dimensions
    px = 71,
    py = 95,

    -- image path
    path = "ChData.png"
}

SMODS.Joker {
    -- joker identifier
    key = "chdata",

    -- description
    loc_txt = {
        name = "Chdata",
        text = {
            "{C:attention}Doubles{} the spawn rate of",
            "{C:attention}Rare{} and {C:attention}Uncommon{} Jokers, and",
            "allows for {C:attention}Legendary{} Jokers to appear outside",
            "of the Soul Spectral Card."
        },
    },
    discovered = true,

    pools = {
        ["Joker"] = true,
        ["Alleecord"] = true,
    },

    -- image parameters
    atlas = "ChDataAtlas",
    pos = { x = 0, y = 0 },

    -- card variables
    config = {
        extra = {
            new_common_mod = 1,
            new_rare_mod = 2,
            new_uncommon_mod = 2,
            new_legendary_mod = 2,

            new_legendary_weight = 0.02,
            default_legendary_weight = 0,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {}
	end,

    -- Rarity (1 = Common to 4 = Legendary)
    rarity = 3,
    -- Shop Price
    cost = 10,

    -- Whether or not this (visually) works with Blueprint or the like
    blueprint_compat = false,

    -- in-game calculation
    calculate = function(self, card, context)
    end,

    -- On obtain
    add_to_deck = function(self, card, from_debuff)

        SMODS.ObjectTypes.Joker.rarities[4].weight = card.ability.extra.new_legendary_weight

        G.GAME.common_mod = card.ability.extra.new_common_mod
        G.GAME.uncommon_mod = card.ability.extra.new_uncommon_mod
        G.GAME.rare_mod = card.ability.extra.new_rare_mod
        G.GAME.legendary_mod = card.ability.extra.new_legendary_mod

    end,

    -- On remove
    remove_from_deck = function(self, card, from_debuff)

        local found_another_dupe = false
        local chdata_jokers = SMODS.find_card("j_ALLEECORD_chdata", false)
        local curr_card = next(chdata_jokers)

        while curr_card do
            if curr_card ~= card then
                found_another_dupe = true
            end
            curr_card = next(chdata_jokers, curr_card)
        end

        if not found_another_dupe then
            G.GAME.common_mod = 1
            G.GAME.uncommon_mod = 1
            G.GAME.rare_mod = 1
            G.GAME.legendary_mod = 1

            SMODS.ObjectTypes.Joker.rarities[4].weight = card.ability.extra.default_legendary_weight
        end

    end,
}
