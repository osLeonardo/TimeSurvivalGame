extends Area2D

@onready var timer: Timer = $damage_timer

func give_damage() -> void:
	var DAMAGE = String.num(get_parent().get_damage())
	print(DAMAGE + " damage taken")
	timer.start()

func _on_damage_timer_timeout() -> void:
	give_damage()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		give_damage()

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		timer.stop()
