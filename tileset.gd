tool
extends Node2D

export(Texture) var TileTex
export(Texture) var NormalTex
export(int) var size = 32
export(bool) var GenerateTiles = false setget generate
export(bool) var Block = true

func _ready():
	pass


func generate(newVar):
	
	if Engine.is_editor_hint() and not Block:
		
		if GenerateTiles:
			for child in get_children():
				child.queue_free()
		else:
			if TileTex != null and NormalTex != null:
				var nx = int(TileTex.get_size().x / size)
				var ny = int(TileTex.get_size().y / size)
				
				var sprite
				var normalspr
				
				for i in range(nx):
					for j in range(ny):
						sprite = Sprite.new()
						sprite.texture = TileTex
						sprite.normal_map = NormalTex
						sprite.region_enabled = true
						sprite.region_rect = Rect2(i*size, j*size, size, size)
						sprite.position = Vector2(i*size, j*size)
						add_child(sprite)
						sprite.set_owner(get_tree().get_edited_scene_root())
						
			
		#Modify var
		GenerateTiles = newVar
	else:
		print("[ERROR]: define textures first to generate tiles")
			