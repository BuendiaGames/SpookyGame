extends Node2D

var scene_name = null #Name of this scene

func _ready():
	pass # Replace with function body.

func set_up(values, pos):
	$Girl.position = pos
	$Girl.stamina = values["stamina"]
	$Girl.has_key = values["has_key"]
	
	camera_limits(scene_name)

#Set adequate camera limits depending on the level
func camera_limits(level_name):
	match level_name:
		"torre_base", "torre_p1", "torre_s1":
			$Girl.camera_lim(-224,-192,800,576)
		"torre_entrada":
			$Girl.camera_lim(0,-288,1056,576)
		_:
			$Girl.camera_lim(-288,-352,1216,864)