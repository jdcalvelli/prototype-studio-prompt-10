extends Sprite2D

var timeCreated:float

func _ready():
	var tween = create_tween()
	tween.tween_property(
		self,
		"position:y",
		400,
		BeatManager.beatDuration + 0.15
	)
	tween.tween_callback(
		func():
			self.queue_free()
	)
	
	get_tree().current_scene.clapSuccessful.connect(
		func():
			tween.kill()
			self_modulate = Color.GREEN
			var tween2 = create_tween()
			tween2.tween_property(
				self,
				"scale",
				Vector2(0,0),
				0.1
			)
			tween2.tween_callback(
				func():
					self.queue_free()
			)
	)
