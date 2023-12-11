extends Control

@onready var volver: Button = $"MarginContainer/CenterContainer/VBoxContainer/Botón de Volver"
@onready var continuar: Button = $"MarginContainer/CenterContainer/VBoxContainer/Botón de Continuar"

func _ready() -> void:
	volver.pressed.connect(_on_volver_pressed)
	continuar.pressed.connect(_on_continuar_pressed)
	visible = false
	
func _input(event):
	if event.is_action_pressed("pausa"):
		visible = not get_tree().paused
		get_tree().paused = not get_tree().paused
		

func _on_volver_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Game/ui/main_menu.tscn")
	
func _on_continuar_pressed():
	visible = not get_tree().paused
	get_tree().paused = false 
	



	
	
