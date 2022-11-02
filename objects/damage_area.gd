extends Area2D

func _on_body_entered(body: Node) -> void:
	if body is Character:
		body.hp -= 20
