extends IMultiBehaviour
class_name StateTransition

@export var is_and: bool = false
@export var target_state_path: NodePath

var TargetState: IState
var _behaviours_count: int

func _ready():
	if target_state_path.is_empty():
		push_error("'%s' is missing a target_state_path" % self)
		return
	
	TargetState = get_node(target_state_path)
	_behaviours_count = behaviours.size()

func execute(params):
	var valid_count = 0
	for behaviour in behaviours:
		if behaviour.execute(params) != true:
			continue
		
		if !is_and:
			return true
		
		valid_count += 1
	
	if is_and && valid_count == _behaviours_count:
		return true
	
	return false
