extends Control

onready var progress : ProgressBar = $Mana

func set_mana(new_mana_value: float) -> void:
	progress.value = new_mana_value

func set_max_mana(max_mana: float) -> void:
	progress.max_value = max_mana
