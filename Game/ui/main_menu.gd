extends MarginContainer
@onready var jugar: TextureButton = $"MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Botón de Jugar"
@onready var creditos: TextureButton = $"MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Botón de Opciones"
@onready var opciones: TextureButton = $"MarginContainer/CenterContainer/VBoxContainer/VBoxContainer/Botón de Créditos"
@onready var salida: TextureButton = $"MarginContainer/MarginContainer/Botón de Salir"

func _ready() -> void:
	jugar.pressed.connect(_on_jugar_pressed)
	creditos.pressed.connect(_on_creditos_pressed)
	opciones.pressed.connect(_on_opciones_pressed)
	salida.pressed.connect(_on_salida_pressed)
	#$"BotónSalidaFrame2".hide()
	

func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Game/Tutorial.tscn")
	
func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://Game/ui/pantalla_de_créditos.tscn")
	
func _on_opciones_pressed():
	get_tree().change_scene_to_file("res://Game/ui/menú_de_opciones.tscn")
	
func _on_salida_pressed():
	
	#$"BotónSalidaFrame1".hide()
	#"BotónSalidaFrame2".show()
	get_tree().quit()
