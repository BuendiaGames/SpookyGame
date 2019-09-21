extends Area2D

export(String) var scene_name = "namelevel"
export(Vector2) var teleport_place = Vector2(0.0, 0.0)

var controller 

func _ready():
	controller = get_node("/root/main_controller")
	set_process(false)

#Make the teleportation effective
func _on_teleporter_body_entered(body):
	if body.name == "Girl":
		controller.goto_scene(scene_name, teleport_place)
