class_name Interactable
extends Node2D 

@export var prompt_message: String = "Interact"

func interact(object):
	if object.name == "Fridge":
		print("Opened the fridge..")
	if object.name == "Soup":
		print("Making soup..")
