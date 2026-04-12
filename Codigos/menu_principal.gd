extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerHud.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/Mundo.tscn")
	PlayerHud.visible = true;


func _on_options_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
