extends Node2D

var busIndex:int
var recordEffect:AudioEffectRecord

var levelArray = [false,true,false,true]
var levelArrayIndex = 0

func _ready():
	busIndex = AudioServer.get_bus_index("MicIn")
	
	BeatManager.beatTimer.timeout.connect(
		func():
			# read the levelArray
			if levelArray[levelArrayIndex]:
				print("official beat")
			
			# loop back on array if we exceed size of it
			if levelArrayIndex == levelArray.size() - 1:
				levelArrayIndex = 0
			# else move to next potential beat
			else:
				levelArrayIndex += 1
	)

func _process(delta):
	var audioSample:float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(busIndex, 0))
	if audioSample >= 0.8:
		print("clap reg")
