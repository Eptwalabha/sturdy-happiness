class_name Ghost
extends ControllableEntity


onready var animation : AnimationPlayer = $AnimationPlayer

export var ghost_area : int = 200

func _ready() -> void:
	$PlayerDetection/Collision.shape.radius = ghost_area

func _on_PlayerDetection_body_entered(_body: Node) -> void:
	animation.play("in_range")

func _on_PlayerDetection_body_exited(_body: Node) -> void:
	animation.play("RESET")
