extends Node2D

var busIndex:int
var recordEffect:AudioEffectRecord

var levelArray = [true,false,true,false]
var levelArrayIndex = 0

var timingWindow:float = 0.1

var levelTime:float = 0

var lastBeatTime:float
var nextBeatTime:float

func _ready():
	# offset the playback of the song by the length of 1 beat
	# to get everything on track such that we're registering
	# the start of beats not ends?
	get_tree().create_timer(BeatManager.beatDuration).timeout.connect(
		func():
			$ExampleAudio.play()
	)
	
	busIndex = AudioServer.get_bus_index("MicIn")
	
	BeatManager.beatTimer.timeout.connect(
		func():
			# register beat time and next
			lastBeatTime = levelTime - BeatManager.beatDuration
			nextBeatTime = levelTime
			
			print(levelArrayIndex)
			
			# loop back on array if we exceed size of it
			if levelArrayIndex == levelArray.size() - 1:
				levelArrayIndex = 0
			# else move to next potential beat
			else:
				levelArrayIndex += 1
	)

func _physics_process(delta):
	levelTime += delta
	
	var audioSample:float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(busIndex, 0))
	if audioSample >= 0.6:
		if levelTime <= lastBeatTime + timingWindow or levelTime >= nextBeatTime - timingWindow:
			if levelArray[levelArrayIndex]:
				print("clap on CORRECT beat")
