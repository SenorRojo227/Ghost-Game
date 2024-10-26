extends Node

func _ready():
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level1.tscn")
	MusicController.start_music()

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Options.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Credits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
