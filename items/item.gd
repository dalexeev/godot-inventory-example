extends Reference
class_name Item
## Базовый класс предмета.

## Возвращает код предмета (в нижнем регистре).
func get_code() -> String:
	return get_script().resource_path.get_file().get_basename()

## Возвращает название предмета.
func get_name() -> String:
	return tr('ITEM_%s_NAME' % get_code().to_upper())

## Возвращает описание предмета.
func get_desc() -> String:
	return tr('ITEM_%s_DESC' % get_code().to_upper())

## Возвращает иконку предмета.
func get_icon() -> Texture:
	var icon: Texture = load('res://items/db/%s.png' % get_code())
	return icon

## Возвращает, может ли быть предмет использован.
func is_usable() -> bool:
	return true

## Возвращает, расходуется ли предмет при использовании.
func is_consumable() -> bool:
	return true

## Вызывается, когда персонаж использует этот предмет.
func use(_character: KinematicBody2D) -> void: # _character: Character
	pass
