extends Item

func is_consumable() -> bool:
	return false

func use(character: KinematicBody2D) -> void: # character: Character
	character.hp += 25 if randi() % 4 else -75
