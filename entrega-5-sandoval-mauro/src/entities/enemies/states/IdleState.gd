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
	idle_timer.stop()
	
# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	pass

# Callback derivado de _physics_process
func update(delta: float) -> void:
	character._apply_movement()
	
	if character._can_see_target():
		finished.emit(&"alert")

# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	pass
	match anim_name:
		&"alert":
			character._play_animation(&"idle_alert")
		&"go_normal":
			character._play_animation(&"idle")


func _handle_body_entered(body: Node) -> void:
	super._handle_body_entered(body)
	character._play_animation(&"alert")
		
func _handle_body_exited(body: Node) -> void:
	super._handle_body_exited(body)
	character._play_animation(&"go_normal")
	

func _on_idle_timer_timeout() -> void:
	finished.emit(&"walk")
