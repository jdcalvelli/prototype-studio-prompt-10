extends Node2D

var busIndex:int
var recordEffect:AudioEffectRecord

# Called when the node enters the scene tree for the first time.
func _ready():
	busIndex = AudioServer.get_bus_index("MicIn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var audioSample:float = db_to_linear(AudioServer.get_bus_peak_volume_left_db(busIndex, 0))
	if audioSample >= 0.8:
		print("clap reg")
