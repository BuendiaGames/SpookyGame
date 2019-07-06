extends MarginContainer

var max_stamina = 1.0

func _ready():
	set_process(false)
	set_physics_process(false)
	pass

func set_max_stamina(maxsta):
	$Bar/Gauge.max_value = maxsta

func set_bar_value(v):
	$Bar/Gauge.value = v

