extends Area2D

var direction = 1
const speed = 10

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()

func _process(delta: float) -> void:
	position.x+= speed*direction
