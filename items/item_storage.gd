extends Reference
class_name ItemStorage
## Хранилище предметов (инвентарь, сундук и т.п.).

## Размер хранилища.
var size setget set_size, get_size

var _items := [] # Array[Item]

## Излучается при возможном изменении размера или содержимого хранилища.
signal changed()

## Задаёт размер хранилища.
func set_size(value: int) -> void:
	_items.resize(value)
	emit_signal('changed')

## Возвращает размер хранилища.
func get_size() -> int:
	return _items.size()

## Возвращает, заполнено ли хранилище.
func is_full() -> bool:
	return _items.find(null) == -1

## Возвращает предмет в ячейке с указанных индексом. null, если ячейка пуста.
func get_item(index: int) -> Item:
	assert(0 <= index && index < _items.size())
	return _items[index]

## Помещает предмет в первую свободную ячейку. Если хранилище заполнено,
## то ничего не происходит.
func push_item(item: Item) -> void:
	var index := _items.find(null)
	if index != -1:
		_items[index] = item
		emit_signal('changed')

## Извлекает содержимое указанной ячейки (предмет или null). Предметы,
## расположенные после указанной ячейки, сдвигаются на одну ячейку к началу.
func pop_item(index: int) -> Item:
	assert(0 <= index && index < _items.size())
	var item: Item = _items.pop_at(index)
	_items.push_back(null)
	emit_signal('changed')
	return item
