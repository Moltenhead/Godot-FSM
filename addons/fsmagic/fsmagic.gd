@tool
extends EditorPlugin

var _panel: VBoxContainer
const TOOL_PANEL = preload("res://addons/fsmagic/FSMagic_Controller.tscn")

func _enter_tree() -> void:
	_panel = TOOL_PANEL.instantiate()
	
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, _panel)

func _exit_tree() -> void:
	remove_control_from_docks(_panel)
	
	_panel.queue_free()
