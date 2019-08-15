extends MarginContainer

var max_stamina = 1.0
var player_max_stamina
const step = 0.001

#Init
func _ready():
	
	$Bar/Gauge.max_value = max_stamina
	$Bar/Gauge.step = step
	
	set_process(false)
	set_physics_process(false)
	pass

#Set the max value of the bar
func set_max_stamina(maxstam):
	player_max_stamina = maxstam

#Set the current value of the bar
func set_bar_value(v):
	var newv = v / player_max_stamina
	$Bar/Gauge.value = newv
	$Bar/BackGround/Number.text = str(int(100 * newv))

