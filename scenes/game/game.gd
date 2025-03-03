extends Node2D

var rng = RandomNumberGenerator.new()

var route = "res://scenes/enemies/"
var ENEMY = load(route + "green_slime/green_slime.tscn")

func _ready() -> void:
	randomize()

func _on_spawn_timer_timeout() -> void:
	rng.randomize()
	
	$player/camera/Path2D/PathFollow2D.progress = rng.randi_range(0, 2112)
	var instance = ENEMY.instantiate()
	
	instance.global_position = $player/camera/Path2D/PathFollow2D/Marker2D.global_position
	add_child(instance)

func _on_enemy_level_up_timeout() -> void:
	ENEMY = load(route + "purple_slime/purple_slime.tscn")
