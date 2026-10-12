extends CharacterBody2D

var speed = 100
var is_special_hitbox_activated = false
var has_timer_timeouted = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(1)

func _physics_process(delta):
	#simple non path finding solution
	#global_position = global_position.move_toward(Globals.target_position, delta * speed)
	#x value pathfinding
	if $waitattackTimer2.time_left != 0 or $IconVisbilityTimer.time_left != 0:
		return
	elif not is_special_hitbox_activated: 
		global_position.x = move_toward(global_position.x, Globals.target_position.x, delta * speed)
	elif is_special_hitbox_activated and has_timer_timeouted:
		if Globals.target_position.x < global_position.x:
			%HitIconLeft.visible = true
		else:
			%HitIconRight.visible = true
	
		%waitattackTimer2.start(1)

func attempt_damage():
	var on_right = Globals.target_position.x > global_position.x
	var correct_hitbox = (on_right and  $HitIconRight.visible) or (not on_right and $HitIconLeft.visible) 
	if on_right == true:
		%HitIconRight.texture = load("res://art/UI/placeholder_red_attack cone.png")
	else:
		%HitIconLeft.texture = load("res://art/UI/placeholder_red_attack cone.png")
	if is_special_hitbox_activated and correct_hitbox:
		Globals.player_reference.take_damage(1)
	%IconVisbilityTimer.start(1)
	%Attack_timer.start(3)
	has_timer_timeouted = false
	

func _on_special_hitbox_body_entered(body: Node2D) -> void:
	is_special_hitbox_activated = true

func _on_special_hitbox_body_exited(body: Node2D) -> void:
	is_special_hitbox_activated = false

func _on_timer_timeout() -> void:
	has_timer_timeouted = true

func _on_icon_visbility_timer_timeout() -> void:
	%HitIconLeft.visible = false
	%HitIconRight.visible = false
	%HitIconLeft.texture = load("res://art/UI/placeholder_attack cone.png")
	%HitIconRight.texture = load("res://art/UI/placeholder_attack cone.png")
