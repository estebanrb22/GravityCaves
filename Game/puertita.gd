extends Area2D

@onready var label: Label = $Label
var inside: Array[GravyClass] = []

func _ready():
	label.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(body: Node):
	inside.append(body)
	if not label.visible:
		label.show()
		
func _on_body_exited(body: Node):
	inside.erase(body)
	if inside.is_empty():
		label.hide()
		
func _input(event):
	if event.is_action_pressed("puertas"):
		for body in inside:
			LevelManager.next_level()
