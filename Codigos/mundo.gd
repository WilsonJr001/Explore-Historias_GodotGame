extends Node2D

@onready var som_floresta: AudioStreamPlayer2D = $"Sons ambientes/SomFloresta"


	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	som_floresta.play(0);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
