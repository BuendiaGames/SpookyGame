extends Control


#These two consts are the locations of the icon
const locations = {"forest": Vector2(512,300), "pumpkin_place":Vector2(230,160),
				"cave": Vector2(210,370), "graveyard":Vector2(600,390), 
				"boatplace":Vector2(632,110)}

const tower_icon = Vector2(790, 290)

#Frequency of icon blinking
const blink_time = 0.75
var elapsed_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


#Open the map!
func open_map():
	get_tree().paused = true
	show()
	set_icon_loc()
	set_process(true)

func set_icon_loc():
	var currentscene = main_controller.currentlevel()
	
	#The tower has many scenes refering to same map location.
	#So treat it separately
	if "tower" in currentscene:
		$player_icon.position = tower_icon
	else:
		$player_icon.position = locations[currentscene]



#Character blinking!
func _process(delta):
	elapsed_time += delta
	
	print(elapsed_time)
	
	if elapsed_time >= blink_time:
		elapsed_time = 0.0
		$player_icon.visible = not $player_icon.visible
	
	if Input.is_action_just_pressed("Map"):
		hide()
		get_tree().paused = false
		set_process(false)

