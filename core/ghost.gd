extends Sprite

var player
var other_ghosts

const speed = 30.0
var v

func _ready():
	add_to_group("ghost")
	
	v = Vector2(0.0, 0.0)
	
	player = get_tree().root.get_node("level/Girl")
	
	other_ghosts = get_tree().get_nodes_in_group("ghost")
	
	set_process(true)

func _process(delta):
	
	var direction = player.position - position
	var force = Vector2(0.0, 0.0)

	
	for ghost in other_ghosts:
		if (ghost != self):
			var d = position - ghost.position 
			force += 30*d / d.length_squared()
	
	position += force + direction.normalized() * speed * delta


func _on_area_body_entered(body):
	if (body.name == "Girl"):
		body.caught()
