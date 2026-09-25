extends Area2D

var dragging := false
var drag_offset := Vector2.ZERO


@export var counter_min_boundary := Vector2(1275, 50)
@export var counter_max_boundary := Vector2(1980, 400)

@export var stove_min_boundary := Vector2(1275, 200)
@export var stove_max_boundary := Vector2(1980, 900)

# original size of object
var original_scale: Vector2

var stove_open = false




func _ready():
	print("RECIPE SCRIPT IS RUNNING")
	original_scale = $Sprite2D.scale


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:

			if event.pressed:
				if is_mouse_over_recipe():
					print("CLICKED RECIPE")

					dragging = true
					drag_offset = global_position - get_global_mouse_position()
					$Sprite2D.scale = original_scale * 1.1

					get_viewport().set_input_as_handled()

			else:
				dragging = false
				$Sprite2D.scale = original_scale


	elif event is InputEventMouseMotion:
		if dragging:
			var target_position = get_global_mouse_position() + drag_offset

			var min_boundary
			var max_boundary
			
			# clamp depends if stove open
			if stove_open:
				min_boundary = stove_min_boundary
				max_boundary = stove_max_boundary
			else:
				min_boundary = counter_min_boundary
				max_boundary = counter_max_boundary


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
