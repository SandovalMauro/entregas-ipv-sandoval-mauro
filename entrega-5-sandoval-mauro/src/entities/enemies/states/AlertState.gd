extends TurretState


func enter() -> void:
	character.velocity = Vector2.ZERO
	fire()
	
func fire() -> void:
	character._fire()
	character._play_animation(&"attack")

# Limpia el estado. Por ej, reiniciar valores de variables o detener timers
func exit() -> void:
	pass


# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	pass


# Callback derivado de _physics_process
func update(delta: float) -> void:
	character._look_at_target()


# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	if character.target == null:
		finished.emit(&"idle")
	else:
		match anim_name:
			&"attack":
				character._play_animation(&"alert")
			&"alert":
				if character._can_see_target():
					fire()
				else:
					finished.emit(&"idle")


func _handle_body_exited(body: Node) -> void:
	super._handle_body_exited(body)
	if character.target == null:
		if character.get_current_animation() != &"attack":
			finished.emit(&"idle")
