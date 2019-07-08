extends Sprite

var player
var other_ghosts

const speed = 30.0
var v

export var tipo = 0

var controller 

func _ready():
	add_to_group("ghost")
	
	controller = get_node("/root/main_controller")
	player = controller.player
	
	v = Vector2(0.0, 0.0)
	
	other_ghosts = get_tree().get_nodes_in_group("ghost")
	
	set_process(true)

func _process(delta):
	
	var direction = player.position - position
	var force = Vector2(0.0, 0.0)

	if (tipo == 0):
		force = ghost_1(force)
	elif (tipo == 1):
		direction = ghost_2dir(direction)
		force = ghost_2for(force)
	
	position += force + direction.normalized() * speed * delta

func ghost_1(force):
	for ghost in other_ghosts:
		if (ghost != self):
			var d = position - ghost.position 
			force += 30*d / d.length_squared()
	return force
	pass
	
func ghost_2dir(direction):
	if (player.vel == Vector2(0.0, -1.0)):
		direction += Vector2(0.0, -30.0)
	elif (player.vel == Vector2(0.0, 1.0)):
		direction += Vector2(0.0, 30.0)
	elif (player.vel == Vector2(1.0, 0.0)):
		direction += Vector2(30.0, 0.0)
	else:
		direction += Vector2(-30.0, 0.0)
	return direction
	pass
	
func ghost_2for(force):
	#self.modulate = Color(200,200,200,255)
	
	for ghost in other_ghosts:
		if (ghost != self):
			var d = position - ghost.position
			force += 15*d /d.length_squared()
	return force
	pass


func _on_area_body_entered(body):
	if (body.name == "Girl"):
		body.caught()
