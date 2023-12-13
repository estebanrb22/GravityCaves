extends Vagon

class_name Vagoneta_Fall

var gravity = 400
var speed = 90
var acceleration = 10**3
var direction = 1
var move = 1
var just_teleport = false
var accept_gravy = true
var intercalate = 1


@onready var wall_ray_cast = $RayCastWall
@onready var hitbox = $HitBox
@onready var pixel_art = $Sprite2D
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
	
func move_wall_ray_cast(distance: int):
	wall_ray_cast.position.x += distance
	
func move_wall_ray_cast(distance: int):
	wall_ray_cast.position.x += distance
	
func _gravy_exited(body: CharacterBody2D):
	just_teleport = false

func set_speed(num: int):
	if num > 0:
		speed = num

func to_the_left():
	change_direction()
	
func change_direction():
	direction *= -1
	wall_ray_cast.position.x *= -1
	wall_ray_cast.rotation *= -1
	
func set_gravity_changed(is_gravity_changed: bool):
	accept_gravy = not is_gravity_changed
	
func _physics_process(delta): 
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if wall_ray_cast.is_colliding():
			change_direction()
			
	if is_active: 
		move = 1
		pixel_art.frame = 1
	else: 
		move = 0
		pixel_art.frame = 0
	
	velocity.x = move_toward(velocity.x, direction * speed * move, acceleration * delta)
	
	move_and_slide()

