extends Node3D
@export_group("Camera")
@export_range(0.0, 10.0) var camera_mouse_sensitivity: float = 0.25
@export_range(0.0, 10.0) var camera_stick_sensitivity: float = 0.5
@export_range(1.0, 10.0) var mouse_mult: float = 0.01
@export_range(1.0, 10.0) var camera_stick_mult: float = 10.0
@export var min_spring_arm_length: float = 4.0
@export var med_spring_arm_length: float = 12.0
@export var max_spring_arm_length: float = 20.0
@export var spring_arm_length: float = max_spring_arm_length
@export var zoom_speed: float = 0.1
@export var max_angle_up: float = PI / 2.0
@export var max_angle_down: float = -PI / 2.5

@onready var parent: Node3D = get_parent()
@onready var camera: Camera3D = %Camera
@onready var spring_arm: SpringArm3D = %SpringArm
@onready var camera_pivot: Node3D = %CameraPivot

var camera_mouse_direction := Vector2.ZERO
var camera_stick_rotation := Vector2.ZERO
var camera_stick_input := Vector2.ZERO
var is_camera_motion: bool = false
var camera_orbit_active: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click") || event.is_action_pressed("middle_click"):
		camera_orbit_active = true
	if event.is_action_released("right_click") || event.is_action_released("middle_click"):
		camera_orbit_active = false
	if event.is_action_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pass
	if event.is_action_pressed("zoom_in"):
		spring_arm_length = clamp(spring_arm_length - 1.0, min_spring_arm_length, max_spring_arm_length)
	if event.is_action_pressed("zoom_out"):
		spring_arm_length = clamp(spring_arm_length + 1.0, min_spring_arm_length, max_spring_arm_length)
	# if event.is_action_pressed("zoom_in_big"):
	# 	spring_arm_length = handle_big_zoom_in(spring_arm_length)
	# if event.is_action_pressed("zoom_out_big"):
	# 	spring_arm_length = handle_big_zoom_out(spring_arm_length)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && camera_orbit_active:
		camera_mouse_direction = event.screen_relative * camera_mouse_sensitivity * mouse_mult

func _process(delta: float) -> void:
	move_camera(delta)
	pass

func move_camera(delta: float) -> void:
	# Camera Movement
	camera_stick_input = Input.get_vector(
		"camera_left",
		"camera_right",
		"camera_up",
		"camera_down"
	)

	camera_stick_rotation = (camera_stick_input * camera_stick_mult * camera_stick_sensitivity)
	spring_arm.rotation.x -= camera_mouse_direction.y + (camera_stick_rotation.y * delta)
	spring_arm.rotation.x = clamp(spring_arm.rotation.x, max_angle_down, max_angle_up)
	spring_arm.rotation.y -= camera_mouse_direction.x + (camera_stick_rotation.x * delta)
	camera_mouse_direction = Vector2.ZERO

	spring_arm.spring_length = lerp(spring_arm.spring_length, spring_arm_length, zoom_speed)

func handle_big_zoom_in(length: float) -> float:
	if length > min_spring_arm_length && length <= med_spring_arm_length:
		return min_spring_arm_length
	elif length > med_spring_arm_length && length <= max_spring_arm_length:
		return med_spring_arm_length
	else:
		return length

func handle_big_zoom_out(length: float) -> float:
	if length >= min_spring_arm_length && length < med_spring_arm_length:
		return med_spring_arm_length
	elif length >= med_spring_arm_length && length < max_spring_arm_length:
		return max_spring_arm_length
	else:
		return length
