extends Node
class_name IMultiBehaviour

@export var behaviours: Array[Script]

func execute(params):
	for behaviour in behaviours:
		behaviour.execute(params)
