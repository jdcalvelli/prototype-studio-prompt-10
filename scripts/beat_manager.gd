extends Node

var bpm:float = 148
# beat duration = 60 / bpm
var beatDuration:float = 60 / bpm

var beatTimer:Timer = Timer.new()

func _ready():
	# create a timer for time beatduration
	beatTimer.autostart = true
	beatTimer.wait_time = beatDuration
	add_child(beatTimer)
