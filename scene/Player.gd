class_name Player
extends ControllableEntity

signal possession_requested
signal possession_released
signal mana_depleted

export var mana_idle : float = 150
export var mana_ghost : float = 5
export var mana_possessed : float = 25
export var mana_max : float = 200

var mana : float = mana_max
var possessing := false

func _ready() -> void:
	in_motion = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		if not possessing:
			emit_signal("possession_requested")
		else:
			emit_signal("possession_released")

func _process(delta: float) -> void:
	if possessing:
		mana -= mana_ghost * delta
		if mana <= 0:
			emit_signal("mana_depleted")
	else:
		mana += mana_idle * delta
	mana = clamp(mana, 0.0, mana_max)

func set_possessing(is_possessing_ghost: bool) -> void:
	possessing = is_possessing_ghost
	in_motion = not possessing
	visible = in_motion
	$CollisionShape2D.disabled = possessing

func possessing() -> void:
	set_possessing(true)

func regain_control(new_global_position: Vector2) -> void:
	global_position = new_global_position
	set_possessing(false)
