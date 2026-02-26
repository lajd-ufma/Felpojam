extends MovingPlatform

@onready var timer_fall: Timer = $TimerFall
@onready var animation_player_shake: AnimationPlayer = $AnimatableBody2D/AnimationPlayer

var is_carimbado := false

func _on_detect_player_body_entered(body: Node2D) -> void:
	animation_player_shake.play("shake")
	print(animation_player_shake.current_animation)
	if !manchou.is_connected(_stop_fall):
		manchou.connect(_stop_fall)
	timer_fall.start()
func _stop_fall():
	is_carimbado = true
	animation_player_shake.stop()
	timer_fall.stop()
func _on_timer_fall_timeout() -> void:
	if !is_carimbado:
		queue_free()
