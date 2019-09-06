extends Node

var player = null #Player instance to take its data
var current_scene = null
var lifebar = null
var values = {"stamina":0.0}
var key_spawner = "pumpkin_place.tscn"


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
		key_spawner = "cave.tscn"
	elif (rand_num <= 0.4):
		key_spawner = "graveyard.tscn"
	elif (rand_num <= 0.6):
		key_spawner = "TORRE.TSCN" # FIXME Poner nombre de escena
	elif (rand_num <= 0.8):
		key_spawner = "boatplace.tscn"
	else:
		key_spawner = "pumpkin_place.tscn"
		
	print(key_spawner)

func free_key_if_not_spawn(currentscene):
	if (currentscene != key_spawner):
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

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	
	#Save all our values
	values["stamina"] = player.stamina
	
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	
	# Instance the new scene, save it
	current_scene = s.instance()
	free_key_if_not_spawn(current_scene)
	
	
	#Set up the new scene
	#current_scene.set_up(values)
	
	
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)