extends KinematicBody2D
class_name Character
## Базовый класс персонажа.

## Здоровье персонажа.
var hp := 100 setget set_hp

## Инвентарь персонажа.
var inventory := ItemStorage.new()

## Излучается при возможном изменении здоровья персонажа.
signal hp_changed()

## Задаёт здоровье персонажа.
func set_hp(value: int) -> void:
	hp = int(clamp(value, 0, 100))
	_hp_changed()
	emit_signal('hp_changed')

## Использовать предмет из ячейки инвентаря.
func use_item(index: int) -> void:
	var item := inventory.get_item(index)
	if item && item.is_usable():
		if item.is_consumable():
			inventory.pop_item(index)
		item.use(self)

## Вызывается при возможном изменении здоровья персонажа.
func _hp_changed() -> void:
	pass
