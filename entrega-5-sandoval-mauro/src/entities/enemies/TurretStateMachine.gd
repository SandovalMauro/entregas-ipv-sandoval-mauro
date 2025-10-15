extends GenericStateMachine


@export var character: Node


# Asignamos el character a cada PlayerState
func _setup() -> void:
	if character == null:
		printerr("%s: character is not defined!" % name)
	for state: TurretState in states_list:
		state.character = character
