extends Node
class_name IBehaviour

@export var behaviour: Script

func execute(params):
	behaviour.execute(params)
