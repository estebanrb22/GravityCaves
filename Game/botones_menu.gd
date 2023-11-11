extends MarginContainer
@onready var jugar: Button = %Jugar
func _ready() -> void:
	jugar.pressed.connect(_on_jugar_pressed)
	
func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Game/Tutorial.tscn")
