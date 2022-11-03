extends PanelContainer

onready var _player := Global.player
onready var _inventory: ItemStorageControl = $'%Inventory'

var _use_button: Button
var _drop_button: Button

func _ready() -> void:
	_inventory.storage = _player.inventory
	_inventory.connect('item_selected', self, '_on_item_selected')
	
	_use_button = Button.new()
	_use_button.text = tr('PLAYER_MENU_INVENTORY_USE')
	_use_button.disabled = true
	_use_button.connect('pressed', self, '_use_item')
	_inventory.add_button(_use_button)
	
	_drop_button = Button.new()
	_drop_button.text = tr('PLAYER_MENU_INVENTORY_DROP')
	_drop_button.disabled = true
	_drop_button.connect('pressed', self, '_drop_item')
	_inventory.add_button(_drop_button)

func _on_item_selected() -> void:
	var item := _inventory.get_selected_item()
	_use_button.disabled = !item || !item.is_usable()
	_drop_button.disabled = !item

func _use_item() -> void:
	_player.use_item(_inventory.get_selected_item_index())

func _drop_item() -> void:
	_player.inventory.pop_item(_inventory.get_selected_item_index())
