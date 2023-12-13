extends Node2D

#speed = 90
@onready var vagon1: Vagoneta = $vagon1
@onready var vagon2: Vagoneta = $vagon2
@onready var vagon3: Vagoneta = $vagon3
@onready var gravy: GravyClass = $Gravy

func _ready():
	vagon1.to_the_left()
	vagon2.to_the_left()
	vagon1.set_speed(100)
	vagon2.set_speed(100)
	vagon3.set_speed(100)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vagon1.set_gravity_changed(gravy.get_gravity_changed())
