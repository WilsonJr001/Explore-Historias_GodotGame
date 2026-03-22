extends Area2D
class_name ItemColetavel

@export var type : String
const COIN = preload("res://Imagens/free-2d-top-down-pixel-dungeon-asset-pack/Tiled_files/Objects.png")
const CHAVE = preload("res://Imagens/Free-Cursed-Land-Top-Down-Pixel-Art-Tileset/Tiled_files/Objects.png")


func _ready() -> void:
	set_data()
	connect_signals()
	
	
func set_data() -> void:
	if type == "Coin":
		$Sprites/Chave.hide()
	elif type == "Chave":
		$Sprites/Coin.hide()
		
func connect_signals() -> void:
	connect("body_entered", collect)
	
func collect(body : Node2D) -> void:
	if body is Player:
		$Sprites.hide()
		if type == "Coin":
			$Sprites/Coin/MoedaSom.play(0)
			await $Sprites/Coin/MoedaSom.finished
		queue_free()
	
	
