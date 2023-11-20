extends Node

var bpm:float = 148
# beat duration = 60 / bpm
var beatDuration:float = 60 / bpm

var beatTimer:Timer = Timer.new()
var eighthTimer:Timer = Timer.new()

func _ready():
	# create a timer for time beatduration
	beatTimer.autostart = true
	beatTimer.wait_time = beatDuration
	add_child(beatTimer)
	# create a timer for time beatduration / 2
	eighthTimer.autostart = true
	eighthTimer.wait_time = beatDuration / 2
	add_child(eighthTimer)
	
	print(beatDuration)
