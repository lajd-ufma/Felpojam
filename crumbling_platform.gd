extends MovingPlatform
 
@export var movable := false
@onready var timer_fall: Timer = $TimerFall

var is_carimbado := false


func _on_detect_player_body_entered(body: Node2D) -> void:
	if !manchou.is_connected(_stop_fall):
		manchou.connect(_stop_fall)
	timer_fall.start()
func _stop_fall():
	is_carimbado = true
	timer_fall.stop()
func _on_timer_fall_timeout() -> void:
	if !is_carimbado:
		queue_free()
