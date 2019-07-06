extends Area2D

var recup = 5.0

# Choose the color of the sweeeets
func set_color():
	var r = randf()
	if (r <= 0.33):
		$Sprite.region_rect.position.x = 0.0
	elif (r <= 0.66):
		$Sprite.region_rect.position.x = 32.0
	else:
		$Sprite.region_rect.position.x = 64.0
	pass
	

func _ready():
	pass

# Recover stamina when you get the sweeeet 
func _on_Area2D_body_entered(body):
	body.recover_stamina(recup)
	queue_free()
