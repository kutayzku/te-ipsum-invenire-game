extends CharacterBody2D

#normal movement(hareket) constantları
const ACCELERATION = 1750
const MAX_SPEED = 350
const FRICTION = 1750

#dash ile ilgili ivirzivir
const DASH_SPEED_CARPANİ = 15.0 #duruma göre degistirilebilir
const DASH_SURESI = 0.15 # saniye
var is_dashing = false
var dash_time_left = 0.0

@onready var animatonPlayer = $AnimationPlayer
@onready var animatonTree = $AnimationTree
@onready var animatonState = animatonTree.get("parameters/playback")


func _ready() -> void:
	velocity = Vector2.ZERO
	#animatonPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	#print(input_vector)

	#---------------------------------------------------------------------
	#DASH BASLANGİC	
	if not is_dashing and Input.is_action_just_pressed("ui_dash") and input_vector != Vector2.ZERO and not is_dashing:
		is_dashing = true;
		dash_time_left = DASH_SURESI;
		velocity = input_vector * MAX_SPEED * 5.313169;
	elif is_dashing:
		while dash_time_left > 0:
			dash_time_left -= 0.0005;
		velocity = input_vector * MAX_SPEED;
	if dash_time_left <= 0:
		is_dashing = false;
	#DASH BİTİS
	#---------------------------------------------------------------------
	
	#NORMAL HAREKET
	if not is_dashing:
		if input_vector != Vector2.ZERO:
			animatonTree.set("parameters/Idle/blend_position", input_vector)
			animatonTree.set("parameters/Run/blend_position", input_vector)	
			animatonState.travel("Run")
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)		
		else:
			animatonState.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	#print(velocity)
	move_and_slide()
