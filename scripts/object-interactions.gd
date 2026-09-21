class_name Interactable
extends Node2D 

@export var prompt_message: String = "Interact"

func interact(player):
	if $Area2D.name == "Fridge":
		print("opened the fridge..")
	if $Area2D.name == "Soup":
		print("making soup..")
