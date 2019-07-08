extends Node2D

#Instance of the main controller
var controller

func _ready():
	controller = get_node("/root/main_controller")
	pass

#Make the buttons usable just before showing them.
#This function is called in the animation player
func finish_intro():
	
	var nodes_to_show = get_tree().get_nodes_in_group("mbutton")
	
	for node in nodes_to_show:
		node.visible = true
	

#Button actions
func _on_start_pressed():
	controller.goto_scene("levels/forest")

func _on_wiki_pressed():
	pass # replace with function body

func _on_map_pressed():
	pass # replace with function body

func _on_exit_pressed():
	get_tree().quit()



