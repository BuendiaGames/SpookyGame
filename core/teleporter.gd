extends Area2D

export(String) var scene_name = "namelevel"

var controller 

func _ready():
	controller = get_node("/root/main_controller")
	set_process(false)

#Make the teleportation effective
func _on_teleporter_body_entered(body):
	controller.goto_scene("levels/" + scene_name + ".tscn")
