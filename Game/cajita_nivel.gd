extends Node2D

@onready var vagon1: Vagoneta = $Vagoneta
@onready var vagon2: Vagoneta = $Vagoneta2
@onready var vagon3: Vagoneta = $Vagoneta3
@onready var vagon4: Vagoneta = $Vagoneta4
@onready var palanca1: Palanca = $Palanca
@onready var palanca2: Palanca = $Palanca2
@onready var palanca3: Palanca = $Palanca3
@onready var palanca4: Palanca = $Palanca4
@onready var gravy: GravyClass = $Gravy

func _ready():
	palanca1.set_vagonetas([vagon1, vagon2, vagon3, vagon4])
	palanca2.set_vagonetas([vagon1, vagon2])
	palanca3.set_vagonetas([vagon4])
	vagon1.set_movement(false)
	vagon3.set_speed(100)
	
func _physics_process(delta):
	vagon1.set_gravity_changed(gravy.get_gravity_changed())
	
	

