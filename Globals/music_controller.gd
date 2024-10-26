extends Node

func start_music() -> void:
	$MenuSounds.stop()
	$Music.play()
