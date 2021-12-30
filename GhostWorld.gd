class_name GhostHouse
extends Node2D

onready var ui = $Overlay/UI
onready var player : Player = $Player

onready var enemies : Array = get_tree().get_nodes_in_group("ghost")

func _ready():
	ui.set_max_mana(player.mana_max)

func _process(_delta: float) -> void:
	ui.set_mana(player.mana)

func release_enemies() -> void:
	for ghost in enemies:
		if ghost.in_motion:
			player.regain_control(ghost.global_position)
			ghost.in_motion = false

func attempt_to_possess() -> void:
	var closest_ghost = null
	var closest_distance : float = -1.0
	for ghost in enemies:
		var distance = player.global_position.distance_to(ghost.global_position)
		var close_enough = distance < ghost.ghost_area
		ghost.in_motion = false
		if close_enough and (closest_distance < 0.0 or distance < closest_distance):
			closest_ghost = ghost
			closest_distance = distance
	if closest_ghost != null:
		player.possessing()
		closest_ghost.in_motion = true

func _on_Player_mana_depleted() -> void:
	release_enemies()

func _on_Player_possession_released() -> void:
	release_enemies()

func _on_Player_possession_requested() -> void:
	attempt_to_possess()
