extends Node

var level : int = 0
var deaths : Array[int] = [0,0]

func get_death_dialog(enemy : CharacterBody2D) -> int:
	if deaths[get_enemy_value(enemy)] > 3:
		return 3
	return deaths[get_enemy_value(enemy)]

func increment_deaths(enemy : CharacterBody2D) -> void:
	deaths[get_enemy_value(enemy)] += 1

func get_enemy_value(enemy : CharacterBody2D) -> int:
	match(enemy.get_meta("enemy_type")):
		"Booker":
			return 0
		"Tomato":
			return 1
	return 0
