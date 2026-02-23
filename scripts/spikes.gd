extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	collision_shape_2d.shape.size = sprite_2d.texture.get_size()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("reload_scene")
		
func reload_scene():
	get_tree().reload_current_scene()
