extends Area2D

export var item_code := 'APPLE'

onready var _sprite: Sprite = $Sprite
var _item: Item

func _ready() -> void:
	_item = ItemDB.get(item_code)
	_sprite.texture = _item.get_icon()

func _on_body_entered(body: Node) -> void:
	if is_queued_for_deletion():
		return
	if body is Character && !body.inventory.is_full():
		body.inventory.push_item(_item)
		queue_free()
