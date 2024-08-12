class_name Pile
extends Node2D

@export var touching_force :float = 0.0
@export var face_down :bool = true

@onready var comp_create_card: ComponentPileCreateCard = $CompCreateCard
@onready var comp_register_card: ComponentPileRegisterCard = $CompRegisterCard
@onready var comp_populate: ComponentPilePopulate = $CompPopulate

@onready var cards_container: Node2D = $CardsContainer

func _ready() -> void:
	comp_register_card.card_unregistered.connect(_on_card_unregistered.unbind(1))

func _on_card_unregistered() -> void:
	if comp_register_card.nr_of_cards == 0:
		comp_populate.pile_depleted.emit()
