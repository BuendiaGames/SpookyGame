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
	
	if should_rain():
		var rain = Particles2D.new()
		rain.amount = 120
		rain.lifetime = 3.5
		rain.process_material = preload("res://core/shaders/particle_rain.tres")
		rain.position = Vector2(570, -10)
		rain.emitting = true
		rain.texture = preload("res://graphics/trace_01.png")
		$GUILayer.add_child(rain)

func set_up(values, pos):
	$Girl.position = pos
	$Girl.stamina = values["stamina"]
	$Girl.has_key = values["has_key"]
	
	#$Girl/camera/rain.emitting = should_rain()
	
	camera_limits()
	set_hint()
	add_last_death_places()

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

#Returns true in levels with rain
func should_rain():
	return not (levelname.find("torre") != -1 or levelname == "cave")

func add_last_death_places():
	
	var death_level = ""
	var gravescene = preload("res://core/grave.tscn")
	var grave = null
	
	for dpos in main_controller.death_positions:
		
		death_level = dpos[0]
		
		if death_level == levelname:
			grave = gravescene.instance()
			grave.position = dpos[1]
			add_child(grave)
	
