--- STEAMODDED HEADER
--- MOD_NAME: Phantom Theif
--- MOD_ID: JOKERP5!
--- MOD_AUTHOR: [GalaCad]
--- MOD_DESCRIPTION: Adds Joker from Persona 5 as a Joker
--- BADGE_COLOUR: #ff0000
--- DISPLAY_NAME: P5 Joker
--- PRIORITY: -100
---MOD CODE---
SMODS.Atlas{
  key = "P5JokerMod",
  path = "P5CARD2.png",
  px = 71,
  py = 95,
}

	SMODS.Joker {
  key = 'P5JokerMod',
  loc_txt = {
  name = 'Phantom Thief',
    text = {"Destroys played {C:hearts}Heart{} cards and adds {X:mult,C:white} X#2# {} Mult {C:inacative}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"}
  },
  config = { extra = { Xmult = 1, Xmult_mod  = 1} },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
  end,
  rarity = 2,
  atlas = 'P5JokerMod',
  pos = { x = 0, y = 0 },
  cost = 5,
  calculate = function(self,card,context)
    ---context.after is after the hand is scored
    ---not context.blueprint means this part cannot be copied by Blueprint, context.destroying_card means it can destroy cards without making ghost cards
    if not context.blueprint and context.destroying_card and context.destroying_card:is_suit('Hearts') then

      card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
      return true
    end
      ---return the xmult if it's above 1, this removes unnecessary animations/calculations if the xmult is 1, because no change would be made anyway
      if context.joker_main and card.ability.extra.Xmult >= 1 then
        return {
        ---text pops up below the joker to show it's giving xmult
        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
        Xmult_mod = card.ability.extra.Xmult,
        colour = G.C.MULT,
        ---card = card tells the game the message refers to this joker
        card = card
        }
      end
    end
}