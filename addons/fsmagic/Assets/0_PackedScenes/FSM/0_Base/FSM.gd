extends Node
class_name FSM

@export var active: bool = false : set = set_Active
@export var initial_state_node: NodePath

var _Target

var _InitialState: IState
var _ActualState: IState

var previous_state: IState

# BUILT IN
func _ready():
	set_process(false)
	set_process_input(false)
	set_physics_process(false)
	
	if !initial_state_node.is_empty():
		_InitialState = get_node(initial_state_node)
		_ActualState = get_node(initial_state_node)

func _input(event) -> void:
	if !active:
		return
	
	input(event)

func _process(delta):
	if !active:
		return
	
	process(delta)

func _physics_process(delta):
	if !active:
		return
	
	physics_process(delta)

# Initializer
func init(target) -> void:
	if target == null:
		push_error("target can't be null for '%s'" % self)
		return
	
	_Target = target

# MAIN
func change_state_to(state: IState, keep_inactive := false) -> void:
	if _ActualState is IState:
		previous_state = _ActualState
		print("%sFSM: '%s' => '%s'" % [self.name, _ActualState.name, state.name])
		if active:
			set_Active(false)
		_ActualState.exit(_Target)
	_ActualState = state
	_ActualState.enter(_Target)
	if keep_inactive:
		return
#	print("%sFSM: activating" % self)
	set_Active(true)

func actual_is(state_name: String) -> bool:
	return _ActualState.name == state_name

# UTILITIES
func input(event) -> void:
	_ActualState.input(_Target, event)

func process(delta: float) -> void:
	_ActualState.process(_Target, delta)

func physics_process(delta, keep_inactive := false) -> void:
	_handle_transition(keep_inactive)
	_ActualState.physics_process(_Target, delta)

func _handle_transition(keep_inactive: bool):
	var target_state = _ActualState.next_state(_Target)
	if target_state == null:
		return
	
	change_state_to(target_state, keep_inactive)

func set_processes(boolean: bool) -> void:
#	print("'%s' is setting processes to %s" % [self, boolean])
	set_physics_process(boolean)
	if _ActualState.has_behaviours_for("Process"):
		set_process(boolean)
	if _ActualState.has_behaviours_for("Input"):
		set_process_input(boolean)

# SETGET
func set_Active(value: bool) -> void:
	active = value
	set_processes(active)
