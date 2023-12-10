extends MarginContainer

@onready var volver: TextureButton = $"MarginContainer/MarginContainer2/Botón de Volver"

func _ready() -> void:
	volver.pressed.connect(_on_volver_pressed)
	
func _on_volver_pressed():
	get_tree().change_scene_to_file("res://Game/ui/main_menu.tscn")
