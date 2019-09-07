extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_key_body_entered(body):
	if (body.name == "Girl"):
		body.has_key = true
		queue_free()

