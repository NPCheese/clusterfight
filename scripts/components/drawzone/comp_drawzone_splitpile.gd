class_name ComponentDrawZoneSplitPile
extends Node

var is_split: bool: set = _on_set_is_split

@onready var draw_zone: DrawZone = $".."

func _restore_top_half() -> void:
	var first_half_cards: Array[PileCard] = []
	
	for card: PileCard in draw_zone.bottom_pile.cards_container.get_children():
		first_half_cards.append(card)
	first_half_cards.reverse()
	
	for card: PileCard in first_half_cards:
		draw_zone.bottom_pile.comp_register_card.unregister_card(card)
		draw_zone.top_pile.comp_register_card.register_card(card)
		draw_zone.top_pile.cards_container.move_child(card, 0)
	
func _fill_bottom_half() -> void:
	var first_half_cards: Array[PileCard] = []
	
	for i in range(draw_zone.top_pile.comp_register_card.nr_of_cards / 2.0):
		first_half_cards.append(draw_zone.top_pile.cards_container.get_child(i))
	
	for card: PileCard in first_half_cards:
		draw_zone.top_pile.comp_register_card.unregister_card(card)
		draw_zone.bottom_pile.comp_register_card.register_card(card)

func _on_set_is_split(new_val: bool) -> void:
	if new_val == is_split:
		return
	is_split = new_val
	
	if is_split:
		_fill_bottom_half()
	else:
		_restore_top_half()
