extends CharacterBody3D

var speed = 10.0
var lane_distance = 1.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var camera_height_offset = 2.0
var lane_change_speed = 5.0 # Speed at which the player changes lanes

var target_x = 0.0 # Target x position for lane change

@onready var cam_h: Node3D = $"../CamOrigin/h"
@onready var cam_v: Node3D = $"../CamOrigin/h/v"

func _ready():
	capture_mouse()
	target_x = position.x # Initialize target_x with the player's starting x position

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
		$playerScene/player/AnimationPlayer.play("Armature|mixamo_com|Layer0")

	# Check if the left or right key is being held down
	if Input.is_action_pressed("left"):
		target_x -= lane_distance * delta * lane_change_speed # Move target left continuously
	elif Input.is_action_pressed("right"):
		target_x += lane_distance * delta * lane_change_speed # Move target right continuously

	# Smoothly move towards the target_x position
	position.x = lerp(position.x, target_x, lane_change_speed * delta)

	move_and_slide()

	# Update camera position
	cam_h.position.y = position.y + camera_height_offset
	cam_h.position.z = position.z
	cam_h.rotation.x = -PI / 2

func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
