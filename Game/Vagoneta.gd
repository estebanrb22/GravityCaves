extends CharacterBody2D

class_name Vagoneta

var gravity = 400
var speed = 90
var acceleration = 10**3
var direction = 1
var move = 1
var just_teleport = false
var is_active = true
var accept_gravy = true
var intercalate = 0.5


@onready var floor_ray_cast = $RayCastFloor
@onready var wall_ray_cast = $RayCastWall
@onready var hitbox = $HitBox
@onready var vagon = $"."


func _ready():
	hitbox.body_entered.connect(_gravy_entered)
	hitbox.body_exited.connect(_gravy_exited)
	
func _gravy_entered(body: CharacterBody2D):
	if not just_teleport and accept_gravy:
		body.position.x = position.x
		body.position.y = position.y - 8
		just_teleport = true
		
func set_movement(accept: bool):
	is_active = accept
	
func _gravy_exited(body: CharacterBody2D):
	just_teleport = false

func iterator():
	is_active = not is_active

func set_speed(num: int):
	if num > 0:
		speed = num

func set_gravity_changed(is_gravity_changed: bool):
	accept_gravy = not is_gravity_changed
	
func change_gravity():
	vagon.rotation = intercalate * 180
	floor_ray_cast.position.x *= -1
	wall_ray_cast.position.x *= -1
	wall_ray_cast.rotation *= -1
	intercalate = 
	
	
func _physics_process(delta): 
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		if not floor_ray_cast.is_colliding() or wall_ray_cast.is_colliding():
			direction *= -1
			floor_ray_cast.position.x *= -1
			wall_ray_cast.position.x *= -1
			wall_ray_cast.rotation *= -1
			
	if is_active: 
		move = 1
	else: 
		move = 0
	
	velocity.x = move_toward(velocity.x, direction * speed * move, acceleration * delta)
	
	move_and_slide()