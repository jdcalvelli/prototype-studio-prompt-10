extends Node2D

var busIndex:int
var recordEffect:AudioEffectRecord

var levelArray = [0,1,0,1]
var beatCounter = 0

var timingWindow:float = 0.2

var levelTime:float = 0
var lastBeatTime:float
var nextBeatTime:float
var thisBeat:int
var nextBeat:int

var noteObject = preload("res://prefabs/test_object.tscn")

func _ready():
	$ExampleAudio.play()
	
	busIndex = AudioServer.get_bus_index("MicIn")
	
	BeatManager.beatTimer.timeout.connect(
		func():
			lastBeatTime = levelTime
			nextBeatTime = levelTime + BeatManager.beatDuration
			
			thisBeat = beatCounter % 4
			
			if thisBeat + 1 < levelArray.size():
				nextBeat = thisBeat + 1
			else:
				nextBeat = 0
			
			# if the next beat in the array is true
			if levelArray[nextBeat]:
				add_child(noteObject.instantiate())
			
			beatCounter += 1
	)

func _physics_process(delta):
	var audioSample:float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(busIndex, 0))
	if audioSample >= 0.6:
		if levelTime >= lastBeatTime and levelTime <= lastBeatTime + timingWindow:
			print("within last beat window")
		elif levelTime >= nextBeatTime - timingWindow and levelTime <= nextBeatTime:
			print("within next beat window")
		
	levelTime += delta
