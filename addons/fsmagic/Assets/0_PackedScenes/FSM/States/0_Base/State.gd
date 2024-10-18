extends Node
class_name State

var _IEnter
var _IInput
var _IProcess
var _IPhysics
var _IExit

func _ready():
	_IEnter 	= $IEnter
	_IInput 	= $IInput
	_IProcess 	= $IProcess
	_IPhysics 	= $IPhysics
	_IExit 		= $IExit

func enter(from) -> void:
	_IEnter.execute({ "from": from })

func input(from, event) -> void:
	_IInput.execute({ "from": from, "event": event })

func process(from, delta: float) -> void:
	_IProcess.execute({ "from": from, "delta": delta })

func physics_process(from, delta: float) -> void:
	_IPhysics.execute({ "from": from, "delta": delta })

func exit(from) -> void:
	_IExit.execute({ "from": from })
