extends Node2D

@onready var vagon1: Vagon = $vagon1
@onready var gravy: GravyClass = $Gravy

func _ready():
	vagon1.set_speed(130)
	vagon1.move_wall_ray_cast(5)


func _physics_process(delta):
	vagon1.set_gravity_changed(gravy.get_gravity_changed())
	gravy.set_can_jump(not vagon1.get_just_teleport())
