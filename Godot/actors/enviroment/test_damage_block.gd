extends CharacterBody2D

var speed = 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(1)

func _physics_process(delta):
	#simple non path finding solution
	#global_position = global_position.move_toward(Globals.target_position, delta * speed)
	#x value pathfinding
	global_position.x = move_toward(global_position.x, Globals.target_position.x, delta * speed)
	
