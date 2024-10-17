class_name CardBody
extends Node2D

var appearance_data: CardData: set = _on_set_appearance_data

@onready var card_parts: CardParts = $CardParts

func reset_border_color() -> void:
	card_parts.border.modulate = Color.WHITE

func paint_border_color() -> void:
	reset_border_color()
	
	if appearance_data == GameCards.CARDS["NUKE"]:
		card_parts.border.modulate = Color.RED
		return
	
	if appearance_data == GameCards.CARDS["DEFUSE"]:
		card_parts.border.modulate = Color(0.42, 1.0, 0.42)
		return
	
func _on_set_appearance_data(new_val: CardData) -> void:
	appearance_data = new_val
	
	card_parts.title.texture = appearance_data.titleLogo
	card_parts.artwork.texture = appearance_data.artworkVariants.pick_random()
	card_parts.glow.glow_color = GameCards.CardColors[appearance_data.highlightColor]
	
	# Pre-special cases
	card_parts.title.flip_h = false
	card_parts.title.flip_v = false
	
	# Neco-Arc special case
	if appearance_data == GameCards.CARDS["NECOARC"]:
		var flip_title: bool = randf() > 0.5
		card_parts.title.flip_h = flip_title
		card_parts.title.flip_v = flip_title
		return
	
	# Copy Paste special case
	if appearance_data == GameCards.CARDS["COPYPASTE"]:
		if card_parts.artwork.texture.resource_path.ends_with("2.png"):
			card_parts.title.texture = preload("res://gfx/cards/title/copypasta.png") as Texture2D
		return
