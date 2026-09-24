extends Area2D

var dragging := false
var drag_offset := Vector2.ZERO


func _ready():
	print("RECIPE SCRIPT IS RUNNING")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed:
				if is_mouse_over_recipe():
					print("CLICKED RECIPE")

					dragging = true
					drag_offset = global_position - get_global_mouse_position()

					get_viewport().set_input_as_handled()

			else:
				if dragging:
					print("RELEASED RECIPE")

				dragging = false


	elif event is InputEventMouseMotion:
		if dragging:
			var mouse_position = get_global_mouse_position()

			global_position = mouse_position + drag_offset 


func is_mouse_over_recipe() -> bool:
	var sprite = $Sprite2D

	var mouse_local = sprite.to_local(get_global_mouse_position())

	var sprite_rect = sprite.get_rect()

	return sprite_rect.has_point(mouse_local)
