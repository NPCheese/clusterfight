extends Node2D

@onready var game_card: HandCard = $HandCard
@onready var random_card_data: Button = $RandomCardData
@onready var glow_up: Button = $GlowUp
@onready var glow_down: Button = $GlowDown
@onready var flip: Button = $Flip
@onready var scale_up: Button = $ScaleUp
@onready var scale_down: Button = $ScaleDown
@onready var tilt: Button = $Tilt
@onready var move: Button = $Move
@onready var touch: Button = $Touch
@onready var reset_touch: Button = $ResetTouch


func _ready() -> void:
	glow_up.pressed.connect(func():
		game_card.comp_glow.glowing = true
	)
	glow_down.pressed.connect(func():
		game_card.comp_glow.glowing = false
	)
	random_card_data.pressed.connect(func():
		game_card.data = GameCards.get_random_card_data()
	)
	flip.pressed.connect(func():
		game_card.comp_flip.flip()
	)
	scale_up.pressed.connect(func():
		game_card.comp_scale.scale_up()
	)
	scale_down.pressed.connect(func():
		game_card.comp_scale.scale_down()
	)
	tilt.pressed.connect(func():
		game_card.comp_touch.tilt(false, 5.0)
	)
	move.pressed.connect(func():
		game_card.comp_touch.move(false, 10)
	)
	touch.pressed.connect(func():
		game_card.comp_touch.touch()
	)
	reset_touch.pressed.connect(func():
		game_card.comp_touch.reset()
	)
