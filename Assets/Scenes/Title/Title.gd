extends Node

func _process(_delta):
	if Input.is_action_pressed("ui_accept"):

		#$AudioStreamPlayer.play()

		if get_tree().change_scene("res://Assets/Scenes/Game/Game.tscn") != OK:
			get_tree().quit(-1) # Couldn't load the scene.
