extends MovingPlatform

func _ready() -> void:
	super()
	manchou.connect(_fall)

func _fall():
	animation_player.play("caino")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "caino":
		queue_free()
