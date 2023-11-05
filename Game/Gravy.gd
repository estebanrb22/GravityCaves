extends CharacterBody2D

var max_lives = 10
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

var jump_speed = -110
var jump_speed_floor = -110

var jump_limit = 15
var jump_count = 0
var jump_inverted_count = 0
var jump_interval = 0
var jump_inverted_interval = 0
var gravity_changes = 0

@onready var label_life: Label = $CanvasLayer/HUD/Label

@onready var pivote: Node2D = $Pivote

@onready var actual_level: Node2D = get_parent()
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationPlayer/AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _ready() -> void:
	label_life.text = str(count_lives)
	posx = position.x
	posy = position.y
	animation_tree.active = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("pinchos"):
		take_damage()
		
	
func take_damage():
	count_lives = max(0, count_lives - 1)
	if count_lives == 0:
		LevelManager.start_game()
	else:
		label_life.text = str(count_lives)
		is_gravity_changed = false
		gravity_changes = 0
		gravy_gravity = 400
		position.x = posx
		position.y = posy
		velocity.x = 0 
		velocity.y = 0
	
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
	#más animación 
	# Ajustar la escala del personaje si la gravedad está invertida
	if is_gravity_changed:
		$Pivote.scale.y = -1  # Invierte verticalmente el personaje
	else:
		$Pivote.scale.y = 1  # Restaura la escala vertical normal del personaje
		
	#OTRAS ANIMACIONES
	if abs(velocity.x)==0 and abs(velocity.y) == 0:
		playback.travel("IDLE")
		
		
		
