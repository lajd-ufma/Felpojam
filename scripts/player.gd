extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var hud: CanvasLayer = $hud
@onready var r_platform_detector: RayCast2D = $r_platform_detector
@onready var l_platform_detector: RayCast2D = $l_platform_detector


signal recarregou_tinta

var is_jumping := false
var is_charging := false

# Valores ajustáveis
var min_jump_force := 450.0
var max_jump_force := 700.0
var charge_speed := 200.0
var current_charge := 0.0

func _ready() -> void:
	recarregou_tinta.connect(recarregar_tinta)

func recarregar_tinta(value):
	hud.emit_signal("recarregou_tinta", value)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	# INÍCIO DO CHARGE
	if Input.is_action_just_pressed("jump") and is_on_floor():
		is_charging = true
		current_charge = min_jump_force

	# CONTINUAR CHARGE
	if is_charging and Input.is_action_pressed("jump") and is_on_floor():
		current_charge = clamp(
			current_charge + charge_speed * delta,
			min_jump_force,
			max_jump_force
		)

	if is_charging and Input.is_action_just_released("jump"):
		is_charging = false

		var tinta = current_charge/max_jump_force * 25
		if hud.get_value_barra_de_tinta() - tinta > 0:
			hud.emit_signal("gastou_tinta", tinta)
			velocity.y = -current_charge
			cpu_particles_2d.emitting = true
			
			if r_platform_detector.is_colliding():
				r_platform_detector.get_collider().get_parent().emit_signal("manchou")
			elif l_platform_detector.is_colliding():
				l_platform_detector.get_collider().get_parent().emit_signal("manchou")

		current_charge = 0.0

	var direction := Input.get_axis("move_left", "move_right")
	if direction and !Input.is_action_pressed("jump"):
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _process(_delta: float) -> void:
	set_animation()

func set_animation():
	var anim := "RESET"

	if velocity.x != 0 and is_on_floor() and not is_charging:
		anim = "walking"
	elif is_charging:
		anim = "charging"

	animation_player.play(anim)
