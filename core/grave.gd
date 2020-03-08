extends Sprite


var frases = ["I was caught by a ghost.\r\n Now I sleep here.",
				"Guess I should have run faster...",
				"Be careful with ghosts. \r\nDon't let them get you.",
				"Get the key, get the key, \r\nget the key. Get out.",
				"Did you read the graveyard's tombs?\r\nI should have read them",
				"The tower is very big.\r\nIs the key there?",
				"There's even water inside the cave!\r\nThe key could be there...",
				"The pumpkins are very beautiful...\r\nCould the key be hidden with them?",
				"Oh, the wharf... There's no more ships in this region,\r\nbut maybe the key is there.",
				"Get out of the forest\r\nYou'll finde nothing here",
				"Oh, I hate those ghosts!\r\nThey actually took me...",
				"Colors, lights... they follow you...\r\nDon't let the colored ghost touch you!"]

#Select a random text for the grave
func _ready():
	randomize()
	
	var index = rand_range(0, len(frases))
	$textarea.text = frases[index]
	print(frases[index])

