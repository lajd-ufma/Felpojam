extends Node2D

const WAIT_DURATION := 1

@onready var platform :AnimatableBody2D = $AnimatableBody2D
@export var move_speed := 3
@export var distance := 192
@export var move_horizontal := true
@export var duracao := 4.0
@export var up_right := true
signal manchou

var follow := Vector2.ZERO
var platform_center = 16

@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D
var tween:Tween
func _exit_tree() -> void:
	tween.kill()
	tween = null
	
func _ready() -> void:
	tween = get_tree().create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

	manchou.connect(_on_manchou)
	move_platform()

func _on_manchou():
	if tween:
		tween.kill()
	animatable_body_2d.modulate = Color.BLACK

func _physics_process(_delta: float) -> void:
	platform.position = platform.position.lerp(follow,0.5)

func move_platform():
	var move_direction = distance * set_direction(move_horizontal,up_right)
	#var duration = move_direction.length()/float(move_speed*platform_center)
	tween.tween_property(self, "follow", move_direction, duracao).set_delay(1)
	tween.tween_property(self, "follow", Vector2.ZERO, duracao).set_delay(1)

func set_direction(move_horizontal,up_right):
	if move_horizontal and up_right:
		return Vector2.RIGHT
	if move_horizontal and !up_right:
		return Vector2.LEFT
	if !move_horizontal and up_right:
		return Vector2.UP
	if !move_horizontal and !up_right:
		return Vector2.DOWN
