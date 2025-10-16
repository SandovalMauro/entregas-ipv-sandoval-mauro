extends TurretState


func enter() -> void:
	character._play_animation(&"dead")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
	if character.target != null:
		character._play_animation(&"die_alert")
	else:
		character._play_animation(&"die")

# Limpia el estado. Por ej, reiniciar valores de variables o detener timers
func exit() -> void:
	pass


# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	pass


# Callback derivado de _physics_process
func update(delta: float) -> void:
	pass


# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name in [&"die_alert", &"die"]:
		character._remove()
