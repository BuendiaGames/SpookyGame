extends MarginContainer

var max_stamina = 1.0

#Init
func _ready():
	set_process(false)
	set_physics_process(false)
	pass

#Set the max value of the bar
func set_max_stamina(maxsta):
	$Bar/Gauge.max_value = maxsta

#Set the current value of the bar
func set_bar_value(v):
	$Bar/Gauge.value = v
	$Bar/BackGround/Number.text = str(int(10 * v / max_stamina))

