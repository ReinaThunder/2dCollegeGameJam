extends Node2D

#start button
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_screen.tscn")

#settings
func _on_menu_button_2_pressed() -> void:
	pass # Replace with function body.

#exit
func _on_menu_button_3_pressed() -> void:
	queue_free()
