extends Area2D

@export var recharge_value := 30

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.emit_signal("recarregou_tinta", recharge_value)
		queue_free()
