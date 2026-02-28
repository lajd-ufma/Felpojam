extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $sprite_spikes

func _ready() -> void:
	collision_shape_2d.shape.size = sprite_2d.region_rect.size

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.emit_signal("caiu_espinho")
