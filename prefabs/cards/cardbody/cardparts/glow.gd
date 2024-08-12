class_name CardPartGlow
extends Sprite2D

signal glow_color_changed(old :Color, new :Color)

var glow_color :Color : set = _on_set_glow_color

func _on_set_glow_color(new_val :Color) -> void:
	if new_val == glow_color:
		return
	var old_val :Color = glow_color
	glow_color = new_val
	glow_color_changed.emit(old_val, new_val)
	modulate = glow_color
	
