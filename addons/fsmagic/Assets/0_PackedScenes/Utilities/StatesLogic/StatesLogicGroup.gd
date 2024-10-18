extends Node
class_name StatesLogicGroup

@export var initial_state_path: NodePath

var InitialState: IState

func _ready():
	if initial_state_path.is_empty():
		push_error("'%s' is missing an initial_state_path" % self)
		return null
	
	InitialState = get_node(initial_state_path)
