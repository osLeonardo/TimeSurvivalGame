extends Node2D

var rng = RandomNumberGenerator.new()
var enemy_spawner : Node
var enemy_level = 0

func _ready() -> void:
	randomize()
	enemy_spawner = preload("res://scenes/enemies/enemy_spawner.gd").new()
	add_child(enemy_spawner)

func _on_enemy_level_up_timeout() -> void:
	if enemy_level < 2:
		enemy_level += 1
		print("level up")

func _on_spawn_timer_timeout() -> void:
	enemy_spawner._spawn_enemy(enemy_level, self)
