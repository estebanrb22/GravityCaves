extends Node2D

@onready var vagon1: Vagoneta = $Vagoneta
@onready var vagon2: Vagoneta = $Vagoneta2
@onready var palanca1: Palanca = $Palanca
@onready var palanca2: Palanca = $Palanca2

func _ready():
	palanca1.set_vagonetas([vagon1, vagon2])
	palanca2.set_vagonetas([vagon1, vagon2])
	
	

