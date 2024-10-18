@tool
extends VBoxContainer

var _file_dialog: FileDialog
var _current_path_tscn: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_file_dialog = $FileDialog

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_button_up() -> void:
	_file_dialog.visible = true

func _on_file_dialog_confirmed() -> void:
	var dir = DirAccess.open("res://")
	_current_path_tscn = _get_current_path_to_tscn()
	dir.copy("res://addons/fsmagic/Assets/0_PackedScenes/Utilities/StatesLogic/IStatesLogic.tscn", _current_path_tscn)
	_update_interface()

func _get_current_path_to_tscn() -> String:
	var target_path: String = _file_dialog.current_path
	if target_path.ends_with('.tscn'):
		return target_path
	else:
		return target_path + '.tscn'

func _get_current_path_dir() -> String:
	return _file_dialog.current_path.get_base_dir()

func _update_interface():
	EditorInterface.open_scene_from_path(_current_path_tscn)
	EditorInterface.save_scene()
	EditorInterface.select_file(_current_path_tscn)
	EditorInterface.set_main_screen_editor('2D')
