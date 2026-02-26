extends MovingPlatform

func _ready() -> void:
	manchou.connect(_fall)

func _fall():
	queue_free()
