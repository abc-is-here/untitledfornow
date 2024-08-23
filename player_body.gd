extends CharacterBody3D

var speed = 10.0
var turn_speed = 30

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var parent

@export var jump_impulse = 10

@onready var cam_h: Node3D = $"../CamOrigin/h"
@onready var cam_v: Node3D = $"../CamOrigin/h/v"

var falling = true

func _ready():
	
	capture_mouse()
	parent = get_parent()
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
		
func _process(delta: float) -> void:
	parent.position = position
	
func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	
	var direction = (cam_h.transform.basis*Vector3(input_dir.x, 0, input_dir.y))
	
	if not is_on_floor():
		velocity.y -= gravity*delta
		$playerScene/player/AnimationPlayer.play("Armature|mixamo_com|Layer0")
		
	if direction:
		velocity.x = direction.x*speed
		velocity.z = direction.z*speed
		
		rotation.y = lerp_angle(rotation.y, atan2(-direction.x, -direction.z), turn_speed*delta)
		
	move_and_slide()
	
func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
