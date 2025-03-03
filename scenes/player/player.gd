extends CharacterBody2D

const SPEED = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")
	
	if direction_x == 0 && direction_y == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
		if direction_x > 0:
			animated_sprite.flip_h = false
		elif direction_x < 0:
			animated_sprite.flip_h = true

	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
