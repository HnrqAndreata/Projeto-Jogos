extends ProgressBar

onready var character = get_parent()
func _ready():
	value = 100
	character.connect("damaged", self, "_on_character_damage_taken")

func _on_character_damage_taken(impact):
	print(character.hp, " , foda", impact)
	value = character.hp - impact

