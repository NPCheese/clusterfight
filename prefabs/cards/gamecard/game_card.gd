extends Node2D
class_name GameCard

@export var data: CardData = null: set = _on_set_data

@onready var comp_appearance: ComponentGameCardAppearance = $CompAppearance
@onready var comp_glow: ComponentGameCardGlow = $CompGlow
@onready var comp_flip: ComponentGameCardFlip = $CompFlip
@onready var comp_scale: ComponentGameCardScale = $CompScale
@onready var comp_touch: ComponentGameCardTouch = $CompTouch

@onready var touch_helper: Marker2D = %TouchHelper
@onready var scale_helper: Marker2D = %ScaleHelper
@onready var flip_helper: Marker2D = %FlipHelper
@onready var card_body: CardBody = %CardBody

var valid_card_data: bool: get = _on_get_valid_card_data

func _ready() -> void:
	_validate_card_data()
	comp_appearance.update_appearance()
	
	card_body.card_parts.glow.glow_color_changed.connect(_on_glow_color_changed.unbind(2))
	comp_flip.flipped.connect(_on_flipped)

func _on_flipped() -> void:
	if comp_flip.face_up:
		card_body.paint_border_color()
	else:
		card_body.reset_border_color()

func _on_glow_color_changed() -> void:
	comp_glow.refresh_initial_modulate()

func _on_set_data(new_val: CardData) -> void:
	# Ignore data assignment until node is ready
	if not is_node_ready():
		return

	if new_val == data:
		print_debug("[%s] new card data (%s) is identical to current card data (%s)" % [
			name,
			"null" if not new_val else new_val.cardName,
			"null" if not data else data.cardName
		])
		return
	data = new_val
	
	comp_appearance.update_appearance()

func _on_get_valid_card_data() -> bool:
	return data != null

func _validate_card_data() -> void:
	if valid_card_data:
		return

	var random_data: CardData = GameCards.get_random_card_data()
	data = random_data
	print_debug("GameCard %s had no card data, assiged random data: %s" % [name, random_data.cardName])
