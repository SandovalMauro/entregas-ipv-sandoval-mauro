@abstract
class_name TurretState extends AbstractState

var character: EnemyTurret


# Callback genérico para eventos manejados como strings.
func handle_event(event: StringName, value = null) -> void:
	pass
	match event:
		&"body_entered":
			_handle_body_entered(value)
		&"body_exited":
			_handle_body_exited(value)
		
func _handle_body_entered(body: Node) -> void:
	if character.target == null && !character.dead:
		character.target = body
		
func _handle_body_exited(body: Node) -> void:
	if body == character.target && !character.dead:
		character.target = null	
