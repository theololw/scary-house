extends Node

var sad_descent_playing = false
var sad_town_playing = false
var time_driving_playing = false
var space_cadet_playing = false

var music_playing = false
func _process(delta):
	if Global.gamemodeNumber == 0:
		if sad_descent_playing == false:
			$Sad_Descent.playing = true
			$Sad_town.playing = false
			$Time_driving.playing = false
			$Space_cadet.playing = false
			sad_descent_playing = true
			
	elif Global.gamemodeNumber == 1:
		if sad_town_playing == false:
			$Sad_Descent.playing = false
			$Sad_town.playing = true
			$Time_driving.playing = false
			$Space_cadet.playing = false
			sad_town_playing = true
			
	elif Global.gamemodeNumber == 2:
		if time_driving_playing == false:
			$Sad_Descent.playing = false
			$Sad_town.playing = false
			$Time_driving.playing = true
			$Space_cadet.playing = false
			time_driving_playing = true
			
	elif Global.gamemodeNumber == 3:
		if space_cadet_playing == false:
			$Sad_Descent.playing = false
			$Sad_town.playing = false
			$Time_driving.playing = false
			$Space_cadet.playing = true
			space_cadet_playing = true
