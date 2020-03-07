extends Node

var player = null #Player instance to take its data
var current_scene = null #Which is the current scene
var scenename = "" #String to identify the current level
var next_sc_name = null
var lifebar = null
var values = {"stamina":10.0, "has_key":false} #Player vars
var key_spawner = "pumpkin_place" #Where will the key appear

var death_positions = []


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
		key_spawner = "torre_p1"
	elif (rand_num <= 0.8):
		key_spawner = "boatplace"
	else:
		key_spawner = "pumpkin_place"
		
	print(key_spawner)

#Delete the key if this was not the chosen zone
func free_key_if_not_spawn():
	if (currentlevel() != key_spawner):
		if current_scene.has_node("key"):
			current_scene.get_node("key").queue_free()
			#print("LLAVE ELIMINADA " + currentlevel())

func the_hint():
	var hint = ""
	match key_spawner:
		"cave":
			hint = "Where the sunlight does not reach, \r\nbut water found its way,\r\nyou should find your key"
		"graveyard":
			hint = "Just keep going around,\r\n not really far away,\r\nthere two trees and treasure\r\nto be found"
		"torre_p1":
			hint = "Big and magnificient,\r\nthe tower shows itself.\r\nAt the top of the castle you'll find\r\n your reward"
		"boatplace":
			hint = "At the edge of the sea,\r\nthere's the key"
		"pumpkin_place":
			hint = "Is it already Halloween? \r\nThe decoration says so,\r\nfind the pumpkins,\r\nthen travel north"
	return hint


# --------------- Player Management --------------- #

func init_player(p):
	player = p
	init_bar()

func add_death_position(pos):
	death_positions.append(pos)
	print(death_positions)


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
	scenename = scene_name
	var path = "levels/" + scene_name + ".tscn"
	call_deferred("_deferred_load_level", path, pos)

func restart_game():
	player=null
	next_sc_name = null
	scenename = ""
	values = {"stamina":10.0, "has_key":false} #Player vars
	call_deferred("_deferred_load_menu")


func currentlevel():
	return scenename


func _deferred_load_level(path, pos):
	
	#Save all our values
	if player != null:
		values["stamina"] = player.stamina
		values["has_key"] = player.has_key
	
	
	# It is now safe to remove the current scene
	current_scene.free()
	
	# Load the new scene.
	var s = ResourceLoader.load(path)
	
	
	# Instance the new scene, save it
	current_scene = s.instance()
	free_key_if_not_spawn()
	
	# See if you won the game
	
	#Set up the new scene
	current_scene.levelname = currentlevel()
	current_scene.set_up(values, pos)
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)

func _deferred_load_menu():
	
	current_scene.free()
	var s = ResourceLoader.load("res://core/menu.tscn")
	
	# Instance the new scene, save it
	current_scene = s.instance()
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)