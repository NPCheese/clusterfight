class_name ComponentGameCardGlow
extends Node

const GLOW_SPEED: float = 2.34
const FADEIN_SPEED: float = 2.34
const FADEOUT_SPEED: float = 2.34 * 2

var _lerp_factor: float = 0.0
var _alpha_factor: float = 0.0
var _glow_direction: bool = true

var _initial_modulate: Color

var glowing: bool = false: set = _on_set_glowing

var custom_glow: bool = false: set = _on_set_custom_glow
var custom_glow_color: Color = Color.BLACK

@onready var game_card: GameCard = $".."

func _process(delta):
	var card_glow :CardPartGlow = game_card.card_body.card_parts.glow
	
	if glowing:
		_alpha_factor = clamp(_alpha_factor + (delta * FADEIN_SPEED), 0.0, 1.0)
	else:
		_alpha_factor = clamp(_alpha_factor - (delta * FADEOUT_SPEED), 0.0, 1.0)
		card_glow.modulate.a = _alpha_factor
		if _alpha_factor == 0.0:
			return
	
	_lerp_factor += (delta * GLOW_SPEED) * (1 if _glow_direction else -1)
	if _lerp_factor >= 1.0:
		_lerp_factor = 1.0
		_glow_direction = false
	elif _lerp_factor <= 0.0:
		_lerp_factor = 0.0
		_glow_direction = true
	
	card_glow.modulate.r = _initial_modulate.r + _lerp_factor
	card_glow.modulate.g = _initial_modulate.g + _lerp_factor
	card_glow.modulate.b = _initial_modulate.b + _lerp_factor
	card_glow.modulate.a = _alpha_factor
	
func refresh_initial_modulate() -> void:
	if custom_glow:
		_initial_modulate = custom_glow_color
	else:
		_initial_modulate = game_card.card_body.card_parts.glow.glow_color

func _reset_process_vars() -> void:
	_alpha_factor = 0.0
	_lerp_factor = 0.0
	_glow_direction = true
	
func _on_set_glowing(new_val: bool) -> void:
	if new_val == glowing:
		return
	glowing = new_val

	if glowing:
		game_card.card_body.card_parts.glow.visible = true
		refresh_initial_modulate()
	else:
		game_card.card_body.card_parts.glow.modulate = _initial_modulate

func _on_set_custom_glow(new_val: bool) -> void:
	if new_val == custom_glow:
		return
	custom_glow = new_val

	refresh_initial_modulate()
