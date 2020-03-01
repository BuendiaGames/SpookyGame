extends Control

var texto
var elapsed_time 
var next_char = 0.05
var j 

# Called when the node enters the scene tree for the first time.
func _ready():
	j=0
	elapsed_time = 0.0
	set_process(false)

#Open the map!
func open_dialogue(_texto):
	texto = _texto
	print(_texto)
	if (texto == "" or texto==null):
		texto="Something seems to be written here, but \r\nit's impossible to read it"
	$text.text = ""
	get_tree().paused = true
	show()
	set_process(true)


#Character blinking!
func _process(delta):
	elapsed_time += delta
	
	if (j < len(texto)):
		if elapsed_time >= next_char:
			elapsed_time = 0.0
			$text.text += texto[j]
			next_char = rand_range(0.001, 0.12)
			j += 1
	
	if Input.is_action_just_pressed("interact") and j >= len(texto):
		j = 0
		elapsed_time = 0.0
		hide()
		get_tree().paused = false
		set_process(false)