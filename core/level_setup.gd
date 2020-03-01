extends Node2D

var levelname

func _ready():
	var map_viewer_pckg = preload("res://core/map_viewer.tscn")
	var map_viewer = map_viewer_pckg.instance()
	
	map_viewer.hide()
	$GUILayer.add_child(map_viewer)
	
	var dialogbox_pckg = preload("res://core/dialogbox.tscn")
	var dialogbox = dialogbox_pckg.instance()
	
	dialogbox.hide()
	$GUILayer.add_child(dialogbox)
	
	

func set_up(values, pos):
	$Girl.position = pos
	$Girl.stamina = values["stamina"]
	$Girl.has_key = values["has_key"]
	
	camera_limits()
	set_hint()

#For the graveyard, set the hidden hint that depends on key location
func set_hint():
	if levelname == "graveyard":
		$text/hint_text.text = main_controller.the_hint()

#Set adequate camera limits depending on the level
func camera_limits():
	match levelname:
		"torre_base", "torre_p1", "torre_s1":
			$Girl.camera_lim(-224,-192,800,576)
		"torre_entrada":
			$Girl.camera_lim(0,-288,1056,576)
		_:
			$Girl.camera_lim(-288,-352,1216,864)