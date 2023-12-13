extends Area2D

class_name Palanca

var gravy_in = false
@onready var pixel_art = $pixel_art
@onready var hitbox = $"."

var vagonetas: Array[Vagon] = []

func _ready():
	hitbox.body_entered.connect(_gravy_entered)
	hitbox.body_exited.connect(_gravy_exited)
	
func _gravy_entered(body: CharacterBody2D):
	if not gravy_in:
		gravy_in = true
		
func _gravy_exited(body: CharacterBody2D):
	if gravy_in:
		gravy_in = false
		
func set_vagonetas(new_vagonetas: Array[Vagon]): 
	for v in new_vagonetas:
		vagonetas.append(v)

func interact():
	for v in vagonetas:
		v.iterator()
		
func _physics_process(delta):
	if Input.is_action_just_pressed("active_palanca") and gravy_in:
		pixel_art.flip_h = not pixel_art.flip_h
		interact()
