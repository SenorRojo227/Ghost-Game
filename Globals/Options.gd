extends Node

enum ScreenSize {FULLSCREEN, WINDOWED, WINDOWED_FULLSCREEN}

var audio_level: float = 50
var display_mode: ScreenSize = ScreenSize.WINDOWED

func set_audio_volume(value: float):
	audio_level = value

func set_display_mode(value: ScreenSize):
	display_mode = value
	
func get_audio_volume():
	return audio_level

func get_display_mode():
	return display_mode
	
func _init() -> void:
	pass
