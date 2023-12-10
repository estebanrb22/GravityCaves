extends CharacterBody2D


@onready var label_life: Label = $CanvasLayer/HUD/Label
@onready var pivote: Node2D = $Pivote

@onready var actual_level: Node2D = get_parent()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationPlayer/AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

var max_lives = 100000
var count_lives = max_lives

var posx = 0
var posy = 0

var speed = 90
var plus = 1
var extra = 1.5
var acceleration = 10**6
var gravity = 400
var gravy_gravity = 400
var is_gravity_changed = false

var mult = -1
var jump_speed = -110
var jump_limit = 15
var jump_count = 0
var jump_interval = 0
var gravity_changes = 0
var gravity_just_changed = false
var velocity_fall = 0

var push = 50.0

#hola soy yo
func _ready() -> void:
	$Pivote.scale.y = 1
	label_life.text = str(count_lives)
	posx = position.x
	posy = position.y
	animation_tree.active = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("pinchos"):
		take_damage()
		
func take_damage():
	LevelManager.reset_level()
		
func _physics_process(delta):
	
	var move_input = Input.get_axis("move_left", "move_right")
	var shift = Input.is_action_pressed("Shift")
	var just_jump = Input.is_action_just_pressed("move_up")
	
	if shift: plus = extra 
	else: plus = 1
	
	if is_gravity_changed: mult = 1
	else: mult = -1
	
	if gravity_just_changed: velocity_fall = 100
	else: velocity_fall = 0

	velocity.x = move_toward(velocity.x, move_input * speed * plus, acceleration * delta)
	
	#the direction of x
	if move_input != 0:
		pivote.scale.x = sign(move_input)
	
	#the gravity is not inverted
	if not is_gravity_changed:
		if is_on_floor():
			#resets all the variables 
			jump_interval = 0
			jump_count = 0
			gravity_changes = 0
			gravity_just_changed = false
			if just_jump:
				#first jump on normal gravity
				playback.travel("jump_start")
				velocity.y = jump_speed
				jump_count += 1
			if velocity.y > 0:
				playback.travel("land")
			if abs(velocity.x)==0 and abs(velocity.y) == 0:
				playback.travel("IDLE")
			if move_input and velocity.y == 0 and not gravity_just_changed:
				if shift:
					playback.travel("run")
				else:
					playback.travel("walk_start")
		else:
			#gravy in the air receives the acceleration from the gravity
			velocity.y += gravy_gravity * delta
			if just_jump and jump_count == 2:
				#After the two jumps the jump_interval shouldn't add velocity
				jump_count += 1
			if velocity.y > velocity_fall:
				playback.travel("fall")
	else:
		#the gravity is inverted
		if is_on_ceiling():
			#resets all the variables
			jump_interval = 0
			jump_count = 0
			gravity_changes = 0
			gravity_just_changed = false
			if just_jump:
				#first jump on inverted gravity
				playback.travel("jump_start")
				velocity.y = jump_speed * -1
				jump_count += 1
			if velocity.y < 0:
				playback.travel("land")
			if abs(velocity.x)==0 and abs(velocity.y) == 0:
				playback.travel("IDLE")
			if move_input and velocity.y == 0 and not gravity_just_changed:
				if shift:
					playback.travel("run")
				else:
					playback.travel("walk_start")
		else:
			#gravy in the air receives the acceleration from the inverted gravity
			velocity.y += gravy_gravity * delta
			if velocity.y < -velocity_fall:
				playback.travel("fall")
			if just_jump and jump_count == 2:
				#After the two jumps the jump_interval shouldn't add velocity
				jump_count += 1
			
	#gravy is on the air and jump, this makes its special jump 
	if not is_on_floor() and not is_on_ceiling() and jump_count <= 2 and gravity_changes == 0:
		if just_jump:
			gravity_just_changed = true
			$Pivote.scale.y *= -1
			playback.travel("bolita")
			jump_interval = 0
			gravity_changes += 1
			jump_count += 1
			gravy_gravity *= -1
			is_gravity_changed = not is_gravity_changed
			mult *= -1
			velocity.y = jump_speed * mult
	
	if Input.is_action_pressed("move_up") and jump_interval < jump_limit and jump_count <= 2:
		jump_interval += 1
		if is_gravity_changed:
			velocity.y = -jump_speed
		else:
			velocity.y = jump_speed
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			var rigidbody = c.get_collider()
			c.get_collider().apply_central_impulse(-c.get_normal() * push)
