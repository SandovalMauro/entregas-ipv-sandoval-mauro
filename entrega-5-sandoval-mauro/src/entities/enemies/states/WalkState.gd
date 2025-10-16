extends TurretState

@export var speed: float #= 10.0
@export var max_speed: float #= 100.0
@export var wander_radius: Vector2 #= Vector2(10.0, 10.0)
@export var pathfinding_step_threshold: float = 5.0

var path: Array = []

func enter() -> void:
	if character.pathfinding != null:
		var random_point: Vector2 = character.global_position + Vector2(
			randf_range(wander_radius.x, wander_radius.x),
			randf_range(wander_radius.y, wander_radius.y)
		)
		path = character.pathfinding.get_simple_path(character.global_position, random_point)
		
		if path.is_empty() || path.size() == 1:
			finished.emit(&"idle")
		else:
			if character.target != null:
				character._play_animation(&"walk_alert")
			else:
				character._play_animation(&"walk")
	else:
		finished.emit(&"idle")
	

# Limpia el estado. Por ej, reiniciar valores de variables o detener timers
func exit() -> void:
	path = []


# Callback derivado de _input
func handle_input(event: InputEvent) -> void:
	pass


# Callback derivado de _physics_process
func update(delta: float) -> void:
	if character._can_see_target():
		finished.emit(&"alert")
		return
	
	if path.is_empty():
		finished.emit(&"idle")
		return
		
	var next_point: Vector2 = path.front()
	
	while character.global_position.distance_to(next_point) < pathfinding_step_threshold:
		path.pop_front()
		
		if path.is_empty():
			finished.emit(&"idle")
			return
		
		next_point = path.front()
	
	character.velocity = (
		character.velocity +
		character.global_position.direction_to(next_point) * speed
	).limit_length(max_speed)
	character._apply_movement()
	character.body_anim.flip_h = character.velocity.x < 0
	

# Callback cuando finaliza una animación en tiempo del estado actual
func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		&"alert":
			character._play_animation(&"walk_alert")
		&"go_normal":
			character._play_animation(&"walk")


func _handle_body_entered(body: Node) -> void:
	super._handle_body_entered(body)
	character._play_animation(&"alert")
		
func _handle_body_exited(body: Node) -> void:
	super._handle_body_exited(body)
	character._play_animation(&"go_normal")
