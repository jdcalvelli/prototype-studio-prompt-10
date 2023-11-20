extends Sprite2D


func _ready():
	var tween = create_tween()
	tween.tween_property(
		self,
		"position:y",
		200,
		BeatManager.beatDuration
	)
