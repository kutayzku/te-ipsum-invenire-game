extends CharacterBody2D

@export var patrol_direction : Node2D

func _physics_process(delta):
	velocity = patrol_direction.direction * 200
	move_and_slide()
