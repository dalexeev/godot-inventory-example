extends Character

onready var _hp_bar: ProgressBar = $HPBar
onready var _hp_bar_label: Label = $HPBar/Label

func _ready() -> void:
	Global.player = self
	_hp_bar.value = hp
	_hp_bar_label.text = str(hp)

func _physics_process(_delta: float) -> void:
	var velocity := Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down')
	move_and_slide(240 * velocity)

func _hp_changed() -> void:
	_hp_bar.value = hp
	_hp_bar_label.text = str(hp)
