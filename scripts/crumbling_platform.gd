extends MovingPlatform

@onready var timer_fall: Timer = $TimerFall
@onready var anim: AnimationPlayer = $AnimatableBody2D/AnimationPlayer

var is_carimbado := false
var is_falling := false
var is_shaking := false
var fall_velocity := Vector2.ZERO
var fall_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	super()

func _on_detect_player_body_entered(_body: Node2D) -> void:
	if !is_carimbado and timer_fall.is_stopped() and !is_shaking and !is_falling:
		timer_fall.start()

func _on_manchou():
	if is_shaking or is_falling:
		return
		
	super._on_manchou()
	
	is_carimbado = true
	animation_player_shake.stop()
	timer_fall.stop()

func _on_timer_fall_timeout() -> void:
	if !is_carimbado:
		is_shaking = true
		anim.play("shake")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "shake":
		is_shaking = false
		is_falling = true
		if tween:
			tween.kill()

func _physics_process(delta: float):
	if is_falling:
		fall_velocity.y += fall_gravity * delta
		platform.position += fall_velocity * delta
		
		if platform.global_position.y > 2500:
			queue_free()
	else:
		super._physics_process(delta)
