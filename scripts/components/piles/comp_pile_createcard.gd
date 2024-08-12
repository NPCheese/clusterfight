class_name ComponentPileCreateCard
extends Node

@onready var pile: Pile = $".."
@onready var cards_container: Node2D = $"../CardsContainer"

func create_card_from_data(c_data :CardData) -> PileCard:
	var new_pile_card = GameCards.PileCardScene.instantiate()
	new_pile_card.data = c_data
	_add_card_to_pile(new_pile_card)
	return new_pile_card

func create_card_from_gamecard(card :GameCard) -> PileCard:
	var new_pile_card = GameCards.PileCardScene.instantiate()
	new_pile_card.data = card.data
	_add_card_to_pile(new_pile_card)
	new_pile_card.comp_appearance.copy_appearance(card)

	for meta_data :String in card.get_meta_list():
		new_pile_card.set_meta(meta_data, card.get_meta(meta_data))
		
	return new_pile_card

## This won't erase the card from the game's memory btw
## Do so manually, depending on your needs
func delete_card(at_index :int = -1) -> void:
	var selected_pile_card = cards_container.get_child(at_index) as PileCard
	_remove_card_from_pile(selected_pile_card)

func _add_card_to_pile(pile_card :PileCard) -> void:
	pile.comp_register_card.register_card(pile_card)
	
	if pile.face_down:
		pile_card.comp_flip.face_up = false
	
	pile_card.comp_touch.touch(pile.touching_force)

func _remove_card_from_pile(pile_card :PileCard) -> void:
	pile.comp_register_card.unregister_card(pile_card)
