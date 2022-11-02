extends Node

onready var _player: Character = $'%Player'
onready var _player_menu: PanelContainer = $'%PlayerMenu'

func _ready() -> void:
	_player.inventory.size = 36
	_player.inventory.push_item(ItemDB.APPLE)
	_player.inventory.push_item(ItemDB.APPLE)
	_player.inventory.push_item(ItemDB.CHICKEN)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('x_menu'):
		_player_menu.visible = !_player_menu.visible

func _on_player_hp_changed() -> void:
	if _player.hp == 0:
		get_tree().reload_current_scene()
