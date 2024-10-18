extends Node
class_name IState

var _Transitions
var _State

func _ready():
	_Transitions = $Transitions.get_children()
	_State = $State
	if not _State is State:
		push_error("'%s' is missing a state" % self)

func next_state(from):
	for transition in _Transitions:
		if transition.execute({ "from": from }) != true:
			continue
		
		return transition.TargetState
	
	return null

func enter(from) -> void:
	_State.enter(from)

func input(from, event) -> void:
	_State.input(from, event)

func process(from, delta: float) -> void:
	_State.process(from, delta)

func physics_process(from, delta: float) -> void:
	_State.physics_process(from, delta)

func exit(from) -> void:
	_State.exit(from)

func has_behaviours_for(type: String) -> bool:
#	print(_State.get_node("I%s" % type).behaviours)
	return _State.get_node("I%s" % type).behaviours.size() > 0
