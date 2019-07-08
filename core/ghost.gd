extends Sprite

#Instance of player and other ghosts in the scene
var player
var other_ghosts

#Speed and velocity
var speed = 30.0
var follow_offset = 0.0
var v


#Ghost behaviour controller
const STUPID = 0
const CLEVER = 1
const RANDOM = 2
export(int, "Stupid", "Clever", "Random") var tipo = 0

#Instance of main controller
var controller 

#As soon as I enter the tree, register myself as a ghost
#This will allow to get all ghosts later in ready
func _enter_tree():
	add_to_group("ghost")

func _ready():
	
	#Properties depending on type
	if (tipo == STUPID):
		speed = 30.0
		set_color(Color("#d031da"))
	elif (tipo == CLEVER):
		speed = 30.0
		follow_offset = 60.0
		set_color(Color("ccbc10"))
	elif (tipo == RANDOM):
		speed = 60.0
		set_color(Color("46cbce"))
	
	#Get the player
	controller = get_node("/root/main_controller")
	player = controller.player
	
	v = Vector2(0.0, 0.0)
	
	other_ghosts = get_tree().get_nodes_in_group("ghost")
	
	print("GG")
	print(len(other_ghosts))
	
	set_process(true)

#Processing of our ghost
func _process(delta):
	
	var direction = Vector2(0.0, 0.0)
	var force = repulsion()
	
	#Do the behaviour corresponding to its type
	if (tipo == STUPID):
		direction = seek_point(player.position)
	elif (tipo == CLEVER):
		direction = seek_point(player.position + player.vel * follow_offset)
	elif (tipo == RANDOM):
		pass
	
	position += force + direction.normalized() * speed * delta

#Process repulsion with other ghosts
func repulsion():
	var force = Vector2(0.0, 0.0)
	for ghost in other_ghosts:
			if (ghost != self):
				var d = position - ghost.position 
				force += 30*d / d.length_squared()
	return force

#Go for the player
func seek_point(point):
	return point - position

#Set the color of the ghost via the light color
func set_color(c):
	$light.color = c



#Check if we have caught the girl
func _on_area_body_entered(body):
	if (body.name == "Girl"):
		body.caught()
