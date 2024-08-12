class_name ComponentGameCardAppearance
extends Node

@onready var game_card: GameCard = $".."

func update_appearance() -> void:
	if not game_card.valid_card_data:
		return printerr("❌{📇} GameCard %s has no valid card data" % game_card.name)
	game_card.card_body.appearance_data = game_card.data
	
	if game_card.comp_flip.face_up:
		game_card.card_body.paint_border_color()

func copy_appearance(other_card :GameCard) -> void:
	if not other_card.valid_card_data:
		return printerr("❌{📇} Other GameCard %s has no valid card data" % game_card.name)
	
	var c_body :CardBody = game_card.card_body
	var c_parts :CardParts = c_body.card_parts
	
	c_body.appearance_data = other_card.data
	c_parts.artwork.texture = other_card.card_body.card_parts.artwork.texture
	c_parts.title.texture = other_card.card_body.card_parts.title.texture
	c_parts.title.flip_h = other_card.card_body.card_parts.title.flip_h
	c_parts.title.flip_v = c_parts.title.flip_h
