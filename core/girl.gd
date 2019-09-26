extends KinematicBody2D

#Some constants
const speed = 1.0
const run_factor = 1.5
const max_stam = 10.0 #Time you can run (seconds)  
const stam_comsumption = 1.0 #Consumption factor

#Current speed and direction
var current_speed
var vel = Vector2(0.0, 0.0)
var stamina = max_stam #Seconds left

#Current anim
var anim = ""

#Controller
var maincontroller = null

#Collision logic
var collider = null #Who I am detecting to interact with

#Controls key possesion
var has_key = false
var finished = false


# ----------- Main logic --------------- #

func _ready():
	
	maincontroller = get_node("/root/main_controller")
	maincontroller.init_player(self)
	
	set_process(true)


func _process(delta):
	
	move_input(delta) #Make the movement
	interact() #Possible interact with things
	
	
	move_and_collide(current_speed * vel)

	

	if (has_key and maincontroller.currentlevel() == "starthall" and not finished):
		print("YASSSSS QUEEEN")
		fade_out()
		finished = true


# ----------- Core functions --------- #


#This function accounts for the movement of the character
func move_input(delta):
	
	
	#Direction where should I move
	if Input.is_action_pressed("ui_up"):
		set_anim("up")
		vel = Vector2(0.0, -1.0)
	elif Input.is_action_pressed("ui_down"):
		set_anim("down")
		vel = Vector2(0.0, 1.0)
	elif Input.is_action_pressed("ui_right"):
		set_anim("right")
		vel = Vector2(1.0, 0.0)
	elif Input.is_action_pressed("ui_left"):
		set_anim("left")
		vel = Vector2(-1.0, 0.0)
	else:
		anim = ""
		$anim.stop()
		vel = Vector2(0.0, 0.0)
	
	#Check if we are running or not
	if Input.is_action_pressed("run") and stamina > 0.0 and vel != Vector2(0.0,0.0):
		current_speed = speed * run_factor
		$anim.playback_speed = run_factor
		reduce_stamina(delta)
	else:
		$anim.playback_speed = 1.0
		current_speed = speed


#Interact with objects in the environment
func interact():
	if Input.is_action_just_pressed("interact"):
		if collider != null:
			print("Estoy interaccionando")
		else:
			print("Nada por aqui")

#Recovers a bit of stamina
func recover_stamina(sta):
	stamina = min(stamina + sta, max_stam)
	maincontroller.update_bar(stamina)

#Gradually reduces stamina up to 0
func reduce_stamina(amount):
	
	if (stamina > 0.0):
		stamina = max(stamina - stam_comsumption * amount, 0.0)
	
	maincontroller.update_bar(stamina)

# ---------- Colision management ------- #

func _on_check_area_entered(area):
	collider = area

func _on_check_area_exited(area):
	collider = null

#Caught by monsters
func caught():
	print("AAAAAAAAAAA")
	fade_out()

# ----------- Auxiliary stuff -----------#

#Animation changer
func set_anim(new_anim):
	if (new_anim != anim):
		$anim.play(new_anim)
		anim = new_anim

#Set camera limits
func camera_lim(left, top, right, down):
	$camera.limit_left = left
	$camera.limit_right = right
	$camera.limit_bottom = down
	$camera.limit_top = top

#fade out
func fade_out():
	$rectangle/AnimationPlayer.play("modulate")
	get_node("../GUILayer/GUI").hide()
	
func menu_fin():
	get_node("../GUILayer/menu").show()
