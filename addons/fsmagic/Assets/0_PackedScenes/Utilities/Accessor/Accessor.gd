extends Node
class_name Accessor

func access(string: String) -> Variant:
	if "/" in string:
		var target = self
		for query in string.split("/"):
			target = target.get_node(query)
		return target
	
	return get_node(string)
