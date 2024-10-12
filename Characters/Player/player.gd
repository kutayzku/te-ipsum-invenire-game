extends CharacterBody2D

const asd = 3.5

const ACCELERATION = 500 * asd
const MAX_SPEED = 100 * asd
const FRICTION = 500 * asd

func _ready() -> void:
	velocity = Vector2.ZERO

#selamun aleykum

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	#print(input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	print(velocity)
		
	move_and_slide()
