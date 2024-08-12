class_name ComponentGameCardScale
extends Node

const SCALE_SPEED :float = 0.1
const SCALE_SIZE :float = 1.27 # absolute

@onready var game_card: GameCard = $".."

var _scale_tween :Tween

func scale_up() -> void:
	_revert_tween()
	_scale_tween.tween_property(game_card.scale_helper,
		"scale", Vector2(SCALE_SIZE, SCALE_SIZE), SCALE_SPEED
	)
	
func scale_down() -> void:
	_revert_tween()
	_scale_tween.tween_property(game_card.scale_helper,
		"scale", Vector2.ONE, SCALE_SPEED
	)

func _revert_tween() -> void:
	if _scale_tween:
		_scale_tween.kill()
	_scale_tween = create_tween().bind_node(game_card.scale_helper).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
