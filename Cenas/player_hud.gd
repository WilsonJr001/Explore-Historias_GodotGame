extends CanvasLayer

@onready var num_moedas: Label = $Control/MarginContainer/Sprite2D/NumMoedas
var moedas: int = 0

func _ready() -> void:
	Message.pegou_moeda.connect(update_coins)

func update_coins(valor: int) -> void:
	moedas = moedas + valor
	num_moedas.text = str(moedas)
