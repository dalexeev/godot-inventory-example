extends Item

func use(character: KinematicBody2D) -> void: # character: Character
	character.hp += 15
