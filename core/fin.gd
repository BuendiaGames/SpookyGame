extends Node2D



func _ready():
	pass

func _process(delta):
	pass


#Make the buttons usable just before showing them.
#This function is called in the animation player
func finish_intro():
	
	var nodes_to_show = get_tree().get_nodes_in_group("mbutton")
	
	for node in nodes_to_show:
		node.visible = true
	

#Button actions
func _on_start_pressed():
	main_controller.restart_game()

func _on_exit_pressed():
	get_tree().quit()
