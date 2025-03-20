extends Node

var rng = RandomNumberGenerator.new()
var route = "res://scenes/enemies/"

enum EnemyType {
	GREEN_SLIME,
	PURPLE_SLIME
}

var spawn_rules = {
	0: [
		{ "enemy": EnemyType.GREEN_SLIME, "count": 1, "pattern": "single" }
	],
	1: [
		{ "enemy": EnemyType.GREEN_SLIME, "count": 2, "pattern": "line" },
		{ "enemy": EnemyType.PURPLE_SLIME, "count": 1, "pattern": "single" }
	],
	2: [
		{ "enemy": EnemyType.GREEN_SLIME, "count": 9, "pattern": "square" },
		{ "enemy": EnemyType.PURPLE_SLIME, "count": 3, "pattern": "line" }
	]
}

func _spawn_enemy(enemy_level: int, player: Node) -> void:
	rng.randomize()
	
	player.get_node("player/camera/Path2D/PathFollow2D").progress = rng.randi_range(0, 2112)
	var spawn_position = player.get_node("player/camera/Path2D/PathFollow2D/Marker2D").global_position
	var available_spawns = spawn_rules[enemy_level]
	var spawn_choice = available_spawns[randi() % available_spawns.size()]
	var enemy_type = spawn_choice["enemy"]
	var count = spawn_choice["count"]
	var pattern = spawn_choice["pattern"]

	match pattern:
		"single":
			spawn_single_enemy(spawn_position, enemy_type, player)
		"line":
			spawn_line_of_enemies(spawn_position, enemy_type, count, player)
		"square":
			spawn_square_of_enemies(spawn_position, enemy_type, count, player)
		"arrow":
			spawn_arrow_of_enemies(spawn_position, enemy_type, count, player)

func spawn_single_enemy(spawn_position: Vector2, enemy_type: int, player: Node) -> void:
	var enemy_instance = create_enemy_instance(enemy_type)
	if enemy_instance:
		enemy_instance.global_position = spawn_position
		player.add_child(enemy_instance)

func spawn_line_of_enemies(spawn_position: Vector2, enemy_type: int, count: int, player: Node) -> void:
	var spacing = 30
	for i in range(count):
		var enemy_instance = create_enemy_instance(enemy_type)
		if enemy_instance:
			enemy_instance.global_position = spawn_position + Vector2(i * spacing, 0)
			player.add_child(enemy_instance)

func spawn_square_of_enemies(spawn_position: Vector2, enemy_type: int, count: int, player: Node) -> void:
	var grid_size = int(sqrt(count))
	var spacing = 30
	var offset = Vector2(-spacing * (grid_size / 2), -spacing * (grid_size / 2))

	for i in range(count):
		var row = i / grid_size
		var col = i % grid_size
		var enemy_instance = create_enemy_instance(enemy_type)
		if enemy_instance:
			enemy_instance.global_position = spawn_position + offset + Vector2(col * spacing, row * spacing)
			player.add_child(enemy_instance)

func spawn_arrow_of_enemies(spawn_position: Vector2, enemy_type: int, count: int, player: Node) -> void:
	var spacing = 30
	var direction = Vector2(1, 0)
	var angle_variation = 15

	for i in range(count):
		var enemy_instance = create_enemy_instance(enemy_type)
		if enemy_instance:
			var offset = Vector2(i * spacing, (sin(i * 0.5) * angle_variation))
			enemy_instance.global_position = spawn_position + offset
			player.add_child(enemy_instance)

func create_enemy_instance(enemy_type: int) -> Node2D:
	match enemy_type:
		EnemyType.GREEN_SLIME:
			return load(route + "green_slime/green_slime.tscn").instantiate()
		EnemyType.PURPLE_SLIME:
			return load(route + "purple_slime/purple_slime.tscn").instantiate()
		_:
			return null
