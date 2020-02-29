extends Node2D

func _ready():
	var map_viewer_pckg = preload("res://core/map_viewer.tscn")
	var map_viewer = map_viewer_pckg.instance()
	map_viewer.hide()
	$GUILayer.add_child(map_viewer)

func set_up(values, pos):
	$Girl.position = pos
	$Girl.stamina = values["stamina"]
	$Girl.has_key = values["has_key"]
	
	camera_limits()

#Set adequate camera limits depending on the level
func camera_limits():
	var level_name =  main_controller.currentlevel()
	match level_name:
		"torre_base", "torre_p1", "torre_s1":
			$Girl.camera_lim(-224,-192,800,576)
		"torre_entrada":
			$Girl.camera_lim(0,-288,1056,576)
		_:
			$Girl.camera_lim(-288,-352,1216,864)