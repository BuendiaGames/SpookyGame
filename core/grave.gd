extends Sprite


var frases = ["I was caught by a ghost.\r\n Now I sleep here.",
				"Guess I should have run faster..."]

#Select a random text for the grave
func _ready():
	randomize()
	
	var index = rand_range(0, len(frases))
	$textarea.text = frases[index]
	print(frases[index])

