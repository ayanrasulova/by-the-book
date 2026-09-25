class_name Interactable
extends Node2D 

@export var prompt_message: String = "Interact"
@export var stove_view: Control

func interact(object):
	if object.name == "Fridge":
		print("Opened the fridge..")
		
	if object.name == "Soup":
		open_stove()
		print("Making soup..")
		
		
func open_stove():
	print(get_tree().get_nodes_in_group("stove_view"))
	var stove_view = get_tree().get_first_node_in_group("stove_view")
	
	if stove_view == null:
		print("StoveView not found in the active scene tree")
		return
		
	# toggles depending on if on or off
	if stove_view:
		stove_view.visible = not stove_view.visible
	
	 # Set stove_open based on visibility
	var draggable_objects = get_tree().get_nodes_in_group("draggable_object")

	for draggable in draggable_objects:
		draggable.stove_open = stove_view.visible
