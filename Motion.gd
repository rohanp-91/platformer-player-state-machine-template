extends Node

# Reference to the state machine
var fsm: StateMachine

# Reference to player varants
var Player = preload("res://scripts/Player.gd")

# Instance of Player
var player = Player.new()

# Ground motion variables
var max_ground_speed = player.max_ground_speed
var acceleration = player.acceleration
var friction = player.friction
var idle_threshold = player.idle_threshold

# Aerial motion variables
var gravity = player.gravity
var jump_velocity = player.jump_velocity
var jump_decceleration = player.jump_decceleration
var air_jump_multiplier = player.air_jump_multiplier
var fall_multiplier = player.fall_multiplier
var low_fall_multiplier = player.low_fall_multiplier
var max_horizontal_air_speed = player.max_horizontal_air_speed
var air_acceleration = player.air_acceleration
var air_friction = player.air_friction

# Private variables
var _velocity: Vector2 = Vector2.ZERO

func exit(state_name, args = null):
	fsm.change_to_state(state_name, args)
	
func back():
	fsm.return_to_previous_state()
	
func unhandled_input(event):
	get_tree().set_input_as_handled()
	
func physics_process(delta):
	_velocity = owner.move_and_slide(_velocity, Vector2.UP)
	_velocity.y += gravity * delta

func get_input_direction():
	var left = int(Input.is_action_pressed("left"))
	var right = int(Input.is_action_pressed("right"))
	
	return (right - left)
	
func flip_sprite(direction):
	if not [-1, 1].has(direction):
		return
		
	var sprite = owner.get_node("Sprite")
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
