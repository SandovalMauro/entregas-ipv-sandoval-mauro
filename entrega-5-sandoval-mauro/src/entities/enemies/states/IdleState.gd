extends TurretState

@onready var idle_timer: Timer = $IdleTimer

func enter() -> void:
	character.velocity = Vector2.ZERO
	
	if character.target != null:
		character._play_animation(&"idle_alert")
	else:
		character._play_animation(&"idle")
		
	idle_timer.start()

# Limpia el estado. Por ej, reiniciar valores de variables o detener timers
func exit() -> void:
	pass

# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	pass

# Callback derivado de _physics_process
func update(delta: float) -> void:
	character._apply_movement()
	
	

# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	pass


# Callback genérico para eventos manejados como strings.
func handle_event(event: StringName, value = null) -> void:
	pass


func _on_idle_timer_timeout() -> void:
	pass # Replace with function body.
