class_name EnemyCommon

extends CharacterBody2D

@export var SPEED: int = 0
@export var HEALTH: int = 0
@export var DAMAGE: int = 0

@onready var player: CharacterBody2D = $"../player"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
		
		velocity = direction * SPEED
		move_and_slide()

func get_speed() -> int:
	return SPEED
	
func get_health() -> int:
	return HEALTH
	
func get_damage() -> int:
	return DAMAGE
