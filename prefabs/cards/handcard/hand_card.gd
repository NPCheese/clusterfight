extends GameCard
class_name HandCard

@onready var pickup_area: Area2D = $PickupArea

func _ready() -> void:
	super()
	pickup_area.mouse_entered.connect(func():
		print("Hello, 🐭!")
	)
	pickup_area.mouse_exited.connect(func():
		print("bye, 🐭.")
	)
