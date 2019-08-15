extends Sprite

#Instance of player and other ghosts in the scene
var player
var other_ghosts

#Speed and velocity
var speed = 30.0
var follow_offset = 0.0
var v
var centre
var angle = 0.0
var rotate_speed = 1
var radio = 75

#Enabler vars
var is_active = false

#Ghost behaviour controller
const STUPID = 0
const CLEVER = 1
const CIRCLE = 2
const RANDOM = 3
export(int, "Stupid", "Clever", "Circle", "Random") var tipo = 0

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
	elif (tipo == CIRCLE):
		speed = 30.0
		set_color(Color("cdad20"))
		centre = self.position
	elif (tipo == RANDOM):
		speed = 60.0
		set_color(Color("46cbce"))
	
	#Get the player
	controller = get_node("/root/main_controller")
	player = controller.player
	
	v = Vector2(0.0, 0.0)
	
	other_ghosts = get_tree().get_nodes_in_group("ghost")
	
	
	set_process(is_active)

#Processing of our ghost
func _process(delta):
	
	var direction = Vector2(0.0, 0.0)
	var force = repulsion()
	
	#Do the behaviour corresponding to its type
	if (tipo == STUPID):
		direction = seek_point(player.position)
	elif (tipo == CLEVER):
		direction = seek_point(player.position + player.vel * follow_offset)
	elif (tipo == CIRCLE):
		position = do_circle(delta)
	elif (tipo == RANDOM):
		pass
	
	if (tipo != CIRCLE):
		position += force + direction.normalized() * speed * delta

# Make movement, do circles
func do_circle(d):
	angle += rotate_speed * d
	var circunf = Vector2(sin(angle), cos(angle)) * radio
	var nueva_pos = centre + circunf
	return nueva_pos

#Process repulsion with other ghosts
func repulsion():
	if (tipo == CIRCLE):
		pass
	var force = Vector2(0.0, 0.0)
	for ghost in other_ghosts:
			if (ghost != self and ghost.is_active):
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



#The enabler makes ghosts to be on and off
func _on_enabler_screen_entered():
	is_active = true
	show()
	set_process(true)


func _on_enabler_screen_exited():
	is_active = false
	hide()
	set_process(false)
