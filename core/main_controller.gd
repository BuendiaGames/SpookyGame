extends Node

var player = null #Player instance to take its data
var current_scene = null
var lifebar = null
var values = {"stamina":0.0}



#Get player, GUI and and scene
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

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
	
	
	#Set up the new scene
	current_scene.set_up(values)
	
	
	
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)