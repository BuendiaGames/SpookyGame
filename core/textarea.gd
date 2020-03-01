extends StaticBody2D

export(String, MULTILINE) var text = ""

func _ready():
	add_to_group("interactables")

