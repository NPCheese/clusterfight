class_name ComponentGameCardTouch
extends Node

const TILT_SPEED :float = 0.25
const MOVE_SPEED :float = 0.25

@onready var game_card: GameCard = $".."

var _tilt_tween :Tween
var _move_tween :Tween

func tilt(to_origin :bool = false, extra_tilt_force :float = 0.0) -> void:
	_revert_tilt_tween()
	
	var tilt_force :float
	
	if to_origin:
		tilt_force = 0.0
	else:
		tilt_force = randf_range(2.0, 8.0 + extra_tilt_force) * [-1, 1].pick_random()
	
	_tilt_tween.tween_property(game_card.touch_helper,
		"rotation_degrees", tilt_force, TILT_SPEED
	)
	
func move(to_origin :bool = false, extra_move_force :float = 0.0) -> void:
	_revert_move_tween()
	
	var move_by :Vector2
	
	if to_origin:
		move_by = Vector2.ZERO
	else:
		move_by.x = randf_range(3.0, 9.0 + extra_move_force) * [-1, 1].pick_random()
		move_by.y = randf_range(3.0, 9.0 + extra_move_force) * [-1, 1].pick_random()
	
	_move_tween.tween_property(game_card.touch_helper,
		"position", move_by, MOVE_SPEED
	)
	
func touch(extra_force :float = 0.0) -> void:
	tilt(false, extra_force)
	move(false, extra_force)
	pass

func reset() -> void:
	tilt(true)
	move(true)

func _revert_tilt_tween() -> void:
	if _tilt_tween:
		_tilt_tween.kill()
	_tilt_tween = create_tween().bind_node(game_card.scale_helper).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)

func _revert_move_tween() -> void:
	if _move_tween:
		_move_tween.kill()
	_move_tween = create_tween().bind_node(game_card.scale_helper).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
