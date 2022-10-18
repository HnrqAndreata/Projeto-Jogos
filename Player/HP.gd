extends ProgressBar

onready var character = get_parent()
func _ready():
	value = 20
	character.connect("damaged", self, "_on_character_damage_taken")

func _on_character_damage_taken(impact):
	value = character.hp - 100
