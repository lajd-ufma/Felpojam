extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var hud: CanvasLayer = $hud
@onready var platform_detector: RayCast2D = $platform_detector

signal recarregou_tinta

var is_jumping := false

# Valores ajustáveis
var min_jump_force := 450.0
var max_jump_force := 700.0
var charge_speed := 200.0  # quanto acumula por segundo

var current_charge := 0.0

func _ready() -> void:
	recarregou_tinta.connect(recarregar_tinta)

func recarregar_tinta(value):
	hud.emit_signal("recarregou_tinta", value)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# 1. Começou a pressionar → começa a carregar
	if Input.is_action_just_pressed("jump") and is_on_floor():
		current_charge = min_jump_force

	# 2. Está segurando → continua carregando (limitado ao máximo)
	if Input.is_action_pressed("jump") and is_on_floor():
		current_charge = clamp(
			current_charge + charge_speed * delta,
			min_jump_force,
			max_jump_force
		)

	# 3. Soltou o botão → aplica o pulo com a força carregada
	if Input.is_action_just_released("jump") and current_charge > 0.0:
		var value_decrement_tinta = current_charge/max_jump_force * 25
		if hud.get_value_barra_de_tinta()-value_decrement_tinta>0:
			hud.emit_signal("gastou_tinta", value_decrement_tinta)
			velocity.y = -current_charge
			cpu_particles_2d.emitting = true
			if platform_detector.is_colliding():
				print("detectou plataformaa")
				print(platform_detector.get_collider().get_parent())
				platform_detector.get_collider().get_parent().emit_signal("manchou")
		is_jumping = false
		current_charge = 0.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _process(_delta: float) -> void:
	set_animation()

func set_animation():
	var anim := "RESET"
	if is_jumping:
		sprite_2d.frame = 1
	else:
		sprite_2d.frame = 0
		if velocity.x != 0:
			anim = "walking"
	animation_player.play(anim)
