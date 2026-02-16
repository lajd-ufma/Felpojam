extends CanvasLayer

signal gastou_tinta(value)
signal recarregou_tinta(value)

@onready var barra_de_tinta: ProgressBar = $barra_de_tinta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gastou_tinta.connect(decrementar_barra_de_tinta)
	recarregou_tinta.connect(incrementar_barra_de_tinta)

func get_value_barra_de_tinta() -> float:
	return barra_de_tinta.value

func incrementar_barra_de_tinta(value):
	barra_de_tinta.value += value
func decrementar_barra_de_tinta(value):
	barra_de_tinta.value -= value
