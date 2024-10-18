@tool

extends Node
class_name StatesLogic

@export var initial_state_path: NodePath

var _Logic: Accessor

func _ready():
	_Logic = $Logic

func _proces():
	if !Engine.is_editor_hint():
		return

	

func get_initial_of(group_name: String) -> Node:
	return _Logic.access(group_name).InitialState

func get_state(group_name: String, state_name: String) -> Node:
	var target_path = "%s/%s" % [group_name, state_name]
	return _Logic.access(target_path)
