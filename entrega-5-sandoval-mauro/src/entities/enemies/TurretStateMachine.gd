extends GenericStateMachine


@export var character: Node


# Asignamos el character a cada PlayerState
func _setup() -> void:
	if character == null:
		printerr("%s: character is not defined!" % name)
	for state: TurretState in states_list:
		state.character = character


func _on_detection_area_body_entered(body: Node2D) -> void:
	current_state.handle_event(&"body_entered", body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	current_state.handle_event(&"body_exited", body)


func _on_body_animation_finished() -> void:
	_on_animation_finished(character.get_current_animation())



func notify_hit(amount: Variant) -> void:
	if current_state != $Die:
		_change_state(&"dead")
