extends Node2D

#start button
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://screens/main_screen.tscn")

#settings, rn just changes if music is on or off
func _on_menu_button_2_pressed() -> void:
	Globals.music_on = !Globals.music_on
	if Globals.music_on == true:
		%AudioStreamPlayer.playing = true
	else:
		%AudioStreamPlayer.playing = false
		
#exit
func _on_menu_button_3_pressed() -> void:
	get_tree().quit()
