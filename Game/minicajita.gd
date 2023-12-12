extends CharacterBody2D

class_name Cajita

var gravity = 400
var accelaration = 2000
var desacceleration = 25
var max_speed = 2000
var move = false
var direction = 0
var count = 0
var gravy_position = 0

@onready var hitbox = $collision_hitbox
func _ready():
	set_connections()

func _gravy_entered(body: CharacterBody2D):
	if not move:
		direction = getDirection()
		move = true
		gravy_position = body.position.x
		
	
func _gravy_exited(body: CharacterBody2D):
	if move:
		move = false
		
func getDirection():
	return Input.get_axis("move_left", "move_right")

func set_connections():
	hitbox.body_entered.connect(_gravy_entered)
	hitbox.body_exited.connect(_gravy_exited)

func sign(num: int):
	if num < 0: return -1
	else: return 1
	
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if move and direction != 0:
			var new_direction = position.x - gravy_position
			velocity.x = move_toward(velocity.x, sign(new_direction) * max_speed, accelaration *delta)
		else:
			velocity.x = move_toward(velocity.x, 0, desacceleration *delta)	

	move_and_slide()
