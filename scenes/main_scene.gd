extends Node2D

var busIndex:int

var levelArray = [0,0,0,1]
var beatCounter = 0

var timingWindow:float = 0.07

var levelTime:float = 0
var lastBeatTime:float
var nextBeatTime:float
var thisBeat:int
var nextBeat:int

var noteObject = preload("res://prefabs/test_object.tscn")

signal clapSuccessful()

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
				var noteToAdd = noteObject.instantiate()
				noteToAdd.timeCreated = levelTime
				add_child(noteToAdd)
			
			beatCounter += 1
			
			if beatCounter % 4 == 0:
				levelArray.shuffle()
	)

func _physics_process(delta):
	var audioSample:float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(busIndex, 0))
	if audioSample >= 0.6:
		if levelTime >= lastBeatTime and levelTime <= lastBeatTime + timingWindow:
			print("within last beat window")
			# send off some signal?
			clapSuccessful.emit()
		elif levelTime >= nextBeatTime - timingWindow and levelTime <= nextBeatTime:
			print("within next beat window")
			# send off some signal?
			clapSuccessful.emit()
		
	levelTime += delta
