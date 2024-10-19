extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")


func _on_audio_volume_slider_value_changed(value: float) -> void:
	Options.set_audio_volume(value)
