extends Area2D

var dragging := false
var drag_offset := Vector2.ZERO


@export var counter_min_boundary := Vector2(1275, 50)
@export var counter_max_boundary := Vector2(1980, 450)

@export var stove_min_boundary := Vector2(1275, 50)
@export var stove_max_boundary := Vector2(1980, 1000)

# original size of object
var original_scale: Vector2

var over_stove := false
var stove_open: bool:
	get:
		var stove_view = get_tree().get_first_node_in_group("stove_view")
		if stove_view:
			return stove_view.visible
		return false


func _ready():
	print("RECIPE SCRIPT IS RUNNING")
	original_scale = $Sprite2D.scale
	
	# area entered
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

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
				var was_dragging = dragging
				dragging = false
				$Sprite2D.scale = original_scale
				
				print("Was dragging: ", was_dragging)
				print("Over stove: ", over_stove)
				print("Is cookable: ", is_in_group("cookable_item"))
				
				if was_dragging and over_stove and is_in_group("cookable_item"):
					get_tree().change_scene_to_file("res://scenes/demo-screen.tscn")


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
			

# dragging items to stove
func _on_area_entered(area: Area2D):
	print("ENTERED AREA: ", area.name)
	print("GROUPS: ", area.get_groups())

	if area.is_in_group("stove_target"):
		over_stove = true
		print("OVER STOVE: TRUE")

func _on_area_exited(area: Area2D):
	print("EXITED AREA: ", area.name)

	if area.is_in_group("stove_target"):
		over_stove = false
		print("OVER STOVE: FALSE")
		
		
		
func is_mouse_over_recipe() -> bool:
	var sprite = $Sprite2D
	var mouse_local = sprite.to_local(get_global_mouse_position())

	return sprite.get_rect().has_point(mouse_local)
