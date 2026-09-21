extends CharacterBody2D

@export var speed = 200 # speed of player
var screen_size

var can_interact = "true"
var current_obj: Area2D = null
@onready var player_area: Area2D = $Area2D # add area 2d to player


func is_interactable_check():
	player_area.area_entered.connect(enter_area)
	player_area.area_exited.connect(leave_area)
	
func enter_area(area):
	var obj = area.get_parent() # objects node is what is set as interactable
	
	if obj is Interactable: # if member of interactable class (obj)
		current_obj = area
		print("Interact with ", current_obj.name, " by pressing E")
		
func leave_area(area):
	if area == current_obj:
		current_obj = null

func _input(event):
	if current_obj and event.is_action_pressed("interact"):
		current_obj.get_parent().interact(current_obj) # called on parent object w/ script.. all interactions handled there
	

func movement(delta):
	velocity = Vector2.ZERO # movement vector by default zero
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	# clamp prevents from leaving screen
	
func animation(delta):
	if velocity.x !=0:
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_threeforthback"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y > 0:	
			$AnimatedSprite2D.animation = "walk_threeforth"
		else:
			$AnimatedSprite2D.animation = "walk_side"
			$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y < 0: 
		$AnimatedSprite2D.animation = "walk_backward"
	elif velocity.y > 0:	
		$AnimatedSprite2D.animation = "walk_forward"

func _ready():
	screen_size = get_viewport_rect().size
	is_interactable_check()
	
func _process(delta):
	movement(delta)
	animation(delta)
	move_and_slide()
	
