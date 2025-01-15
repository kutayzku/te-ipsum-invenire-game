extends CharacterBody2D

var mov_speed = 50.0
@export var target : Node2D = null
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _ready():
	call_deferred("hoca_setup")
	
	
func hoca_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		
func _physics_process(delta):
	if navigation_agent_2d.is_navigation_finished():
		return
	var current_agent_pos = navigation_agent_2d.get_next_path_position()
	var next_path_pos = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_pos.direction_to(next_path_pos) * mov_speed
	move_and_slide()
	
