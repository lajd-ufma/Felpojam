extends MovingPlatform

@onready var timer_fall: Timer = $TimerFall
@onready var anim: AnimationPlayer = $AnimatableBody2D/AnimationPlayer

var is_falling := false
var fall_velocity := Vector2.ZERO
var fall_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	manchou.connect(_fall)


func _fall():
	is_falling = true


func _physics_process(delta: float):
	if is_falling:
		fall_velocity.y += fall_gravity * delta
		platform.position += fall_velocity * delta
		
		if platform.global_position.y > 2500:
			queue_free()
	else:
		super._physics_process(delta)
