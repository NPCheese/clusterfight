class_name ComponentGameCardFlip
extends Node

signal flipped

const FLIP_SPEED :float = 0.16

@onready var game_card: GameCard = $".."

var face_up :bool : get = _on_get_face_up, set = _on_set_face_up

var _flip_tween :Tween

func flip() -> void:
	_revert_tween()
	
	_flip_tween.tween_property(game_card.flip_helper,
		"scale:x", 0.0, FLIP_SPEED*0.5
	)
	_flip_tween.tween_callback(func():
		face_up = not face_up
	)
	_flip_tween.tween_property(game_card.flip_helper,
		"scale:x", game_card.flip_helper.scale.x, FLIP_SPEED*0.5
	)
	
func _on_get_face_up() -> bool:
	return not game_card.card_body.card_parts.card_back.visible
	
func _on_set_face_up(new_val :bool) -> void:
	if new_val == face_up:
		return
	
	game_card.card_body.card_parts.card_back.visible = not new_val
	flipped.emit()
	

func _revert_tween() -> void:
	if _flip_tween:
		_flip_tween.kill()
	_flip_tween = create_tween().bind_node(game_card.flip_helper)
