extends Node2D

@onready var vagon1: Vagoneta = $vagon1
@onready var vagon2: Vagoneta_Inverted = $vagon_inverted
@onready var vagon3: Vagoneta = $vagon3
@onready var vagon4: Vagoneta = $vagon4
@onready var gravy: GravyClass = $Gravy
@onready var palanca1: Palanca = $palanca1

func _ready():
	vagon1.set_movement(false)
	vagon1.set_speed(120)
	vagon1.move_wall_ray_cast(5)
	vagon2.to_the_left()
	palanca1.set_vagonetas([vagon1])

func _process(delta):
	vagon1.set_gravity_changed(gravy.get_gravity_changed())
	vagon2.set_gravity_changed(gravy.get_gravity_changed())
	vagon3.set_gravity_changed(gravy.get_gravity_changed())
	vagon4.set_gravity_changed(gravy.get_gravity_changed())
	gravy.set_can_jump(not vagon2.get_just_teleport())
