class_name ComponentPileRegisterCard
extends Node

signal card_registered(pile_card :PileCard)
signal card_unregistered(pile_card :PileCard)
signal card_count_changed(nr_of_cards :int)

@onready var cards_container: Node2D = $"../CardsContainer"

# 🔑CardData -> 📦int
var card_recurrences :Dictionary = {}

var nr_of_cards :int : get = _on_get_nr_of_cards

func _ready() -> void:
	card_registered.connect(_on_card_registered_on_unregistered.unbind(1))
	card_unregistered.connect(_on_card_registered_on_unregistered.unbind(1))

func register_card(pile_card :PileCard) -> void:
	cards_container.add_child(pile_card)
	
	card_recurrences[pile_card.data] = card_recurrences.get(pile_card.data, 0) + 1
	
	card_registered.emit(pile_card)

func unregister_card(pile_card :PileCard) -> void:
	cards_container.remove_child(pile_card)
	
	card_recurrences[pile_card.data] -= 1
	if card_recurrences[pile_card.data] == 0:
		card_recurrences.erase(pile_card.data)
	
	card_unregistered.emit(pile_card)

func _on_card_registered_on_unregistered() -> void:
	card_count_changed.emit(nr_of_cards)

func _on_get_nr_of_cards() -> int:
	return card_recurrences.values().reduce(_sum_up, 0)

func _sum_up(accumulator :int, recurrences :int) -> int:
	return accumulator + recurrences
