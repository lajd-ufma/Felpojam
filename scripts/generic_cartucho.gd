@tool # Permite que o código rode no editor
extends Area2D

enum CartuchoColor {BLUE, RED}

#var mask_vento := preload("res://assets/masks/mask_fujin.png")
#var mask_fogo := preload("res://assets/masks/mask_kagutsuchi.png")
#var mask_escuridao := preload("res://assets/masks/mask_izanami.png")
#var mask_agua := preload("res://assets/masks/mask_suijin.png")

@export var cartucho_color: CartuchoColor:
	set(value):
		cartucho_color = value
		if is_node_ready():
			_update_sprite()

func _ready():
	_update_sprite()

func _update_sprite():
	#var sprite = $Sprite2D
	#if not sprite:
		#return

	match cartucho_color:
		CartuchoColor.BLUE:
			$ColorRect.color = Color.BLUE
			#sprite.modulate = Color.CYAN
			#sprite.texture = mask_vento
		CartuchoColor.RED:
			$ColorRect.color = Color.RED


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.emit_signal("pegou_cartucho", CartuchoColor.keys()[cartucho_color])
		queue_free()
