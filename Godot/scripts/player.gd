extends CharacterBody2D

var speed = 400
var sprint_speed = 700
var jump_power = 1500
var dust_hp = 5

func _ready():
	Globals.player_reference = self

func _physics_process(_delta):
	Globals.target_position = global_position
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * speed 
	if Input.is_action_just_pressed("sprint"):
		speed = sprint_speed
	if Input.is_action_just_released("sprint"):
		speed = 400
	
	if not is_on_floor():
		velocity.y += Globals.GRAVITY 
	if is_on_floor() and Input.is_action_pressed("Jump"):
		velocity.y += -jump_power
		
	move_and_slide()
	
func take_damage(damage_number):
	dust_hp -= damage_number
	print(dust_hp)
	if dust_hp <= 0:
		die()
	
func die():
	print("dead")
	get_tree().change_scene_to_file("res://screens/title_screen.tscn")
