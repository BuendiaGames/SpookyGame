extends Node

var music_player = AudioStreamPlayer.new()

var last_rained = false

var rain_music = preload("res://music/back/spooky_8d.ogg")
var no_rain_music = preload("res://music/back/spooky_8d_no_rain.ogg")

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(music_player)

#Changes music when rain changes
func check_music(is_raining):
	if last_rained and not is_raining:
		var playingpos = music_player.get_playback_position()
		music_player.stop()
		music_player.stream = no_rain_music
		music_player.play(playingpos)
	elif not last_rained and is_raining:
		var playingpos = music_player.get_playback_position()
		music_player.stop()
		music_player.stream = rain_music
		music_player.play(playingpos)
	
	last_rained = is_raining

