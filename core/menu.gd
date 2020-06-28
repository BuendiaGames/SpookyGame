extends Node2D

#Instance of the main controller
var controller

func _ready():
	controller = get_node("/root/main_controller")
	set_process(false)
	pass


#Make the buttons usable just before showing them.
#This function is called in the animation player
func finish_intro():
	
	var nodes_to_show = get_tree().get_nodes_in_group("mbutton")
	
	for node in nodes_to_show:
		node.visible = true
	

#Button actions
func _on_start_pressed():
	#main_controller.music_player.play
	controller.goto_scene("forest", Vector2(-212, -144))
	

func _on_exit_pressed():
	get_tree().quit()



