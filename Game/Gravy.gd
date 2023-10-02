extends CharacterBody2D

var speed = 90
var plus = 1
var extra = 1.5
var acceleration = 10**6
var gravity = 400
var gravy_gravity = 400
var is_gravity_changed = false

var jump_speed = -110
var jump_speed_floor = -110

var jump_limit = 15
var jump_count = 0
var jump_inverted_count = 0
var jump_interval = 0
var jump_inverted_interval = 0
var gravity_changes = 0

@onready var pivote: Node2D = $Pivote

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationPlayer/AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _ready() -> void:
	animation_tree.active = true
	
func _physics_process(delta):
	var move_input = Input.get_axis("move_left", "move_right")
	var shift = Input.is_action_pressed("Shift")
	
	if shift: plus = extra
	else: plus = 1

	velocity.x = move_toward(velocity.x, move_input * speed * plus, acceleration * delta)
	
	#animación
	if move_input != 0:
		pivote.scale.x = sign(move_input)
	
	if not is_on_floor() and not is_gravity_changed:
		velocity.y += gravy_gravity * delta
		if Input.is_action_just_pressed("move_up") and jump_count == 1:
			jump_count += 1
	
	if not is_on_ceiling() and is_gravity_changed:
		velocity.y += gravy_gravity * delta
		if Input.is_action_just_pressed("move_up") and jump_inverted_count == 1:
			jump_inverted_count += 1
			
	if not is_on_floor() and not is_on_ceiling():
		if Input.is_action_just_pressed("move_up"):
			gravity_changes += 1
			if not is_gravity_changed and gravity_changes == 1:
				jump_inverted_count += 1
				is_gravity_changed = true
				gravy_gravity *= -1
				velocity.y = jump_speed * -1
			elif is_gravity_changed and gravity_changes == 1:
				jump_count += 1
				is_gravity_changed = false
				gravy_gravity *= -1
				velocity.y = jump_speed
	
	if is_on_floor():
		jump_interval = 0
		jump_inverted_interval = 0
		jump_count = 0
		jump_inverted_count = 0
		if not is_gravity_changed:
			gravity_changes = 0
		if Input.is_action_just_pressed("move_up"):
			velocity.y = jump_speed_floor
			jump_count += 1
	
	if is_on_ceiling():
		jump_interval = 0
		jump_inverted_interval = 0
		jump_count = 0
		jump_inverted_count = 0
		if is_gravity_changed:
			gravity_changes = 0
		if Input.is_action_just_pressed("move_up"):
			velocity.y = jump_speed_floor * -1
			jump_inverted_count += 1
			
	if Input.is_action_pressed("move_up") and jump_interval < jump_limit and jump_count == 1 and not is_gravity_changed:
		jump_interval += 1
		velocity.y = jump_speed
		
	if Input.is_action_pressed("move_up") and jump_inverted_interval < jump_limit and jump_inverted_count == 1 and is_gravity_changed:
		jump_inverted_interval += 1
		velocity.y = -jump_speed
		
	
								
	
	
	move_and_slide()	
	
	#más animación a
	if abs(velocity.x) > 7:
		playback.travel("run")
	else:
		playback.travel("IDLE")
		
	# Ajustar la escala del personaje si la gravedad está invertida
	if is_gravity_changed and is_on_ceiling():
		$Pivote.scale.y = -1  # Invierte verticalmente el personaje
	elif is_on_floor():
		$Pivote.scale.y = 1  # Restaura la escala vertical normal del personaje
