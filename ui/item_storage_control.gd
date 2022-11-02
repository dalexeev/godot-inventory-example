extends Control
class_name ItemStorageControl
## Элемент управления для взаимодействия с хранилищем предметов.

## Хранилище предметов.
var storage: ItemStorage setget set_storage

var _items: ItemList
var _item_name: Label
var _item_desc: RichTextLabel
var _buttons: VBoxContainer

## Излучается при возможной смене выбранного предмета или снятии выделения.
signal item_selected()

func _init() -> void:
	var body: VBoxContainer = preload('res://ui/item_storage_control.tscn').instance()
	body.set_anchors_and_margins_preset(PRESET_WIDE, PRESET_MODE_MINSIZE, 8)
	add_child(body)
	
	_items = body.get_node('%Items')
	_item_name = body.get_node('%ItemName')
	_item_desc = body.get_node('%ItemDesc')
	_buttons = body.get_node('%Buttons')
	
	_items.connect('item_selected', self, '_on_items_item_selected')
	_item_name.text = ''
	_item_desc.text = ''
	clear_buttons()

## Задаёт хранилище предметов.
func set_storage(value: ItemStorage) -> void:
	if storage:
		storage.disconnect('changed', self, '_update_items')
	
	storage = value
	storage.connect('changed', self, '_update_items')
	_update_items()

## Добавляет кнопку в нижнее меню.
func add_button(button: Button) -> void:
	_buttons.show()
	_buttons.add_child(button)

## Удаляет все кнопки из нижнего меню.
func clear_buttons() -> void:
	_buttons.hide()
	for button in _buttons.get_children():
		button.queue_free()

## Возвращает выделенный предмет или null, если предмет не выбран.
func get_selected_item() -> Item:
	if !storage:
		return null
	var index := get_selected_item_index()
	return null if index == -1 else storage.get_item(index)

## Возвращает индекс выделенного предмета или -1, если предмет не выбран.
func get_selected_item_index() -> int:
	var si := _items.get_selected_items()
	return -1 if si.empty() else si[0]

func _update_items() -> void:
	var old_index := get_selected_item_index()
	
	_items.clear()
	
	if storage:
		for i in storage.size:
			var item := storage.get_item(i)
			if item:
				_items.add_icon_item(item.get_icon())
			else:
				_items.add_icon_item(preload('res://items/db/empty.png'))
	
	if old_index != -1:
		_items.select(old_index)
	
	_update_selected_item_info()
	emit_signal('item_selected')

func _update_selected_item_info() -> void:
	var index := get_selected_item_index()
	if index == -1:
		_item_name.text = ''
		_item_desc.text = ''
		return
	
	var item := storage.get_item(index)
	if item:
		_item_name.text = item.get_name()
		_item_desc.text = item.get_desc()
	else:
		_item_name.text = tr('ITEM_EMPTY_NAME')
		_item_desc.text = tr('ITEM_EMPTY_DESC')

func _on_items_item_selected(_index: int) -> void:
	_update_selected_item_info()
	emit_signal('item_selected')