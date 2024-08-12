class_name ComponentPilePopulate
extends Node

signal pile_populated(nr :int, time_elapsed :float)
signal pile_depleted

@onready var comp_create_card: ComponentPileCreateCard = $"../CompCreateCard"
@onready var comp_register_card: ComponentPileRegisterCard = $"../CompRegisterCard"

var _process_delay :float
var _process_bulk_add :float
var _process_elapsed :float = 0.0
var _process_deck_cards :Array[CardData] : set = _on_set_process_deck_cards

var _time_elapsed :float = 0.0

func _process(delta: float) -> void:
	if _process_deck_cards.is_empty():
		return
	_process_elapsed += delta
	_time_elapsed += delta
	if _process_elapsed >= _process_delay:
		_process_elapsed = 0.0
		_process_bulk_add = min(_process_bulk_add, _process_deck_cards.size())
		for i in range(_process_bulk_add):
			comp_create_card.create_card_from_data(
				_process_deck_cards.pop_back()
			)
			if _process_deck_cards.is_empty():
				pile_populated.emit(comp_register_card.nr_of_cards, _time_elapsed)
				_time_elapsed = 0.0

func populate_from_datas(card_data_arr :Array[CardData]) -> void:
	_calculate_process_delay(card_data_arr.size())
	_calculate_process_bulk_add(card_data_arr.size())
	_process_deck_cards = card_data_arr

func _on_set_process_deck_cards(new_val :Array[CardData]) -> void:
	if new_val == _process_deck_cards: return
	_process_deck_cards = new_val
	set_process(_process_deck_cards.size() > 0)

func _calculate_process_delay(input: int) -> void:
	input = max(50, input)
	var m :float = 0.007
	var y :float = -m * (input-50) + 0.03
	y = max(0.03, y)
	_process_delay = y

func _calculate_process_bulk_add(input: int) -> void:
	var y :int = 1
	
	var thresholds :Array[int] = [
		100, 160, 205
	]
	
	for th in thresholds:
		if input >= th:
			y += 1
	
	_process_bulk_add = y
