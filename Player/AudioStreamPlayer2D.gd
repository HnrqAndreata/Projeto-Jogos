extends AudioStreamPlayer2D

var sfxLst

func _ready():
	var gunShotSFX: AudioStream = preload("res://SFX/GunShotSFX.ogg") 
	sfxLst = [gunShotSFX]
	self.set_volume_db(3.0)
	
func playAudio(audio:int):
	self.set_stream(sfxLst[audio])
	play()
	
