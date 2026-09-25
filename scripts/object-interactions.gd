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
	var stove_view = get_tree().get_first_node_in_group("stove_view")
	stove_view.visible = true
