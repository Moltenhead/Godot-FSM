extends FSM
class_name HFSM

var _Children

func _ready():
	_Children = $Children.get_children()

func init(target) -> void:
	super.init(target)
	_propagate_target()

func _propagate_target() -> void:
	for fsm in _Children:
		fsm.init(_Target)

func input(event) -> void:
	super.input(event)
	for fsm in _Children:
		fsm.input(event)

func process(delta) -> void:
	super.process(delta)
	for fsm in _Children:
		fsm.process(delta)

func physics_process(delta, keep_inactive := false) -> void:
	super.physics_process(delta, keep_inactive)
	for fsm in _Children:
		fsm.physics_process(delta, true)

# UTILITIES
func change_child_state_to(child_path: String, state: IState) -> void:
	# Change child state but keep the fsm inactive
	# 	Keeps execution handling through propagation only
	$Children.get_node(child_path).change_state_to(state, true)

func set_processes(boolean: bool) -> void:
	set_process(boolean)
	set_physics_process(boolean)
	set_process_input(boolean)
