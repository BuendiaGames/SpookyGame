extends Node

var player = null #Player instance to take its data
var current_scene = null
var next_sc_name = null
var lifebar = null
var values = {"stamina":0.0, "has_key":false}
var key_spawner = "pumpkin_place"


#Get player, GUI and and scene
func _ready():
	randomize()
	choose_scene_spawner()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

# ---------------- Key spawn ---------------------- #
func choose_scene_spawner():
	var rand_num = randf()
	if (rand_num <= 0.2):
		key_spawner = "cave"
	elif (rand_num <= 0.4):
		key_spawner = "graveyard"
	elif (rand_num <= 0.6):
		key_spawner = "torre_p1" # FIXME Poner nombre de escena
	elif (rand_num <= 0.8):
		key_spawner = "boatplace"
	else:
		key_spawner = "pumpkin_place"
		
	print(key_spawner)

#Delete the key if this was not the chosen zone
func free_key_if_not_spawn(currentscene):
	if (currentscene.name != key_spawner):
		if current_scene.has_node("key"):
			current_scene.get_node("key").queue_free()
			print("LLAVE ELIMINADA")

# --------------- Player Management --------------- #

func init_player(p):
	player = p
	init_bar()

# --------------- Lifebar controller -------------- #

#Configure lifebar
func init_bar():
	lifebar = current_scene.get_node("GUILayer/GUI")
	lifebar.set_max_stamina(player.max_stam)
	lifebar.set_bar_value(player.stamina)

#Update the value
func update_bar(value):
	lifebar.set_bar_value(value)


# --------------- Scene controller ---------------- #

func goto_scene(scene_name, pos):
	next_sc_name = scene_name
	var path = "levels/" + scene_name + ".tscn"
	call_deferred("_deferred_goto_scene", path, pos)


func _deferred_goto_scene(path, pos):
	
	#Save all our values
	values["stamina"] = player.stamina
	values["has_key"] = player.has_key
	
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	
	# Instance the new scene, save it
	current_scene = s.instance()
	free_key_if_not_spawn(current_scene)
	
	
	#Set up the new scene
	current_scene.scene_name = next_sc_name
	current_scene.set_up(values, pos)
	
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)