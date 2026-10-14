extends Node2D

func _ready():
	if Globals.music_on:
		%"Background Audio".playing = true
	else:
		%"Background Audio".playing = false 
