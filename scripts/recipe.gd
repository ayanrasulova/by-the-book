extends Area2D

var dragging := false
var drag_offset := Vector2.ZERO


# clamp boundaries 
var min_boundary := Vector2(1275, 200)
var max_boundary := Vector2(1980, 600)

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
					$Sprite2D.scale = Vector2(1.1, 1.1)

					get_viewport().set_input_as_handled()

			else:
				dragging = false
				$Sprite2D.scale = Vector2(1.0, 1.0)


	elif event is InputEventMouseMotion:
		if dragging:
			var target_position = get_global_mouse_position() + drag_offset

			# clamp recipe position
			global_position.x = clamp(
				target_position.x,
				min_boundary.x,
				max_boundary.x
			)

			global_position.y = clamp(
				target_position.y,
				min_boundary.y,
				max_boundary.y
			)
			


func is_mouse_over_recipe() -> bool:
	var sprite = $Sprite2D
	var mouse_local = sprite.to_local(get_global_mouse_position())

	return sprite.get_rect().has_point(mouse_local)
