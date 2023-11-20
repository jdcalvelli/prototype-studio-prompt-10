extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	BeatManager.beatTimer.timeout.connect(
		func():
			var tween = create_tween()
			tween.tween_property(
				self,
				"scale",
				Vector2(0.95, 0.95),
				BeatManager.beatDuration / 2 
			)
			tween.tween_callback(
				func():
					self.scale = Vector2(1,1)
			)
	)
