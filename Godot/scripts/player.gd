extends CharacterBody2D

var speed = 500
var sprint_speed = 800
var jump_power = 2250
var dust_hp = 5
var damage = 1
var is_attacking = false
var enemy_attacked 

func _ready():
	Globals.player_reference = self
	%AnimatedSprite2D.play()

func _physics_process(_delta):
	#movement
	Globals.target_position = global_position
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * speed 
	if Input.is_action_just_pressed("sprint"):
		speed = sprint_speed
	if Input.is_action_just_released("sprint"):
		speed = 500
	if Input.is_action_pressed("Right"):
		%AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("Left"):
		%AnimatedSprite2D.flip_h = true
	
	#attack
	# 2. PLayer does attack and picks a area2d based on direction
	# 3. put sprite to visible
	if Input.is_action_pressed("Attack") and %Attack_Cooldown.time_left == 0:
		print("just attacked")
		%Attack_Cooldown.start(0.4)
		if direction > 0:
			%RightSprite.visible = true
			if enemy_attacked:
				enemy_attacked.take_damage(damage)
		else:
			%LeftSprite.visible = true
			if enemy_attacked:
				enemy_attacked.take_damage(damage)
		%IconVisibilityTimer.start(0.20)
		
		
	#gravity
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
	

func _on_icon_visibility_timer_timeout() -> void:
	%RightSprite.visible = false
	%LeftSprite.visible = false


func _on_right_simple_attack_body_entered(body: Node2D) -> void:
	print("entered")
	if body.is_in_group("Enemy"):
		enemy_attacked = body
		print(enemy_attacked)


func _on_right_simple_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_attacked = false
		print(enemy_attacked)


func _on_left_simple_attack_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_attacked = body
		print(enemy_attacked)


func _on_left_simple_attack_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		enemy_attacked = false
		print(enemy_attacked)
