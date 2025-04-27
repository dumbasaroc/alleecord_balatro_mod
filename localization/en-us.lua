return {
    descriptions = {
        Back={},
        Blind={},
        Edition={},
        Enhanced={
            m_ALLEECORD_onetime = {
                name = "One-Time Only Card",
                text = {
                    "At the end of a hand, if this card",
                    "was scored, {C:attention}destroy{} this card."
                }
            },
        },
        Joker={
            j_ALLEECORD_alleesaur = {
                name = "Alleesaur",
                text = {
                    "If played hand has less than {C:attention}5{}",
                    "cards, duplicate one card at random until",
                    "there are 5 cards.",
                    "The created cards will be {C:attention}One-Time Cards{}.",
                }
            },

            j_ALLEECORD_catdark = {
                name = "Catdark",
                text = {
                    "Each instance of this Joker gains",
                    "{X:mult,C:white} X#2# {} Mult each time a new one is obtained.",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
                },
            },

            j_ALLEECORD_chdata = {
                name = "Chdata",
                text = {
                    "{C:attention}Doubles{} the spawn rate of",
                    "{C:attention}Rare{} and {C:attention}Uncommon{} Jokers, and",
                    "allows for {C:attention}Legendary{} Jokers to appear outside",
                    "of the Soul Spectral Card."
                },
            },

            j_ALLEECORD_dumbasaroc = {
                name = "DumbAsARoc",
                text = {
                    ""
                },
            },

            j_ALLEECORD_melonsoldier = {
                name = "Melonsoldier",
                text = {
                    "This joker gains {X:chips,C:white} X#2# {} Chips when",
                    "a {C:attention}Jack{} is scored.",
                    "{C:inactive}(Currently {X:chips,C:white} X#1# {C:inactive} Chips)"
                },
            },

            j_ALLEECORD_pypo = {
                name = "Peripypo",
                text = {
                    "{C:snaking_straights}Snaking Straights{} add an additional {X:mult,C:white} X#2# {}",
                    "Mult to this Joker.",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
                },
            },

            j_ALLEECORD_twiggy = {
                name = "Twigsagi",
                text = {
                    "At the end of each round,",
                    "any {C:attention}Planet Cards{}",
                    "in the consumable area have a",
                    "{C:green}#1# in #2#{} chance to upgrade",
                    "their corresponding hand."
                },
            },
        },
        Other={
            o_snaking_desc = {
                name = "Snaking Straights",
                text = {
                    "{C:snaking_straights}Snaking Straights{} are two",
                    "consecutive {C:attention}Straights{} that",
                    "only have one overlapping {C:attention}rank{}.",
                    "{C:inactive}Ex. 1,2,3,4,5 and 5,6,7,8,9{}"
                }
            }
        },
        Planet={},
        Spectral={},
        Stake={},
        Tag={},
        Tarot={},
        Voucher={},
    },
    misc = {
        achievement_descriptions={},
        achievement_names={},
        blind_states={},
        challenge_names={},
        collabs={},
        dictionary={},
        high_scores={},
        labels={},
        poker_hand_descriptions={},
        poker_hands={},
        quips={},
        ranks={},
        suits_plural={},
        suits_singular={},
        tutorial={},
        v_dictionary={
            a_xchips = { "X#1# Chips" },
            a_add_xchips = { "+X#1# Chips" },
        },
        v_text={},
    },
}