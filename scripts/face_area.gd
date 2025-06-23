extends Area3D

signal clicked

@onready var parent: Node3D = get_parent()
@onready var quble_manager: Node3D = get_parent().get_parent()
@onready var mesh: MeshInstance3D = %Mesh
@onready var qunector: Node3D = %Qunector
@onready var destination: Node3D = %Destination

func _ready() -> void:
	connect("input_event", Callable(self, "_on_input_event"))
	connect("clicked", Callable(quble_manager, "_on_clicked"))

func _on_input_event(_camera: Camera3D, event: InputEvent, touch_position: Vector3, _normal: Vector3, _shape_idx: float) -> void:
	handle_input(touch_position)
	if event.is_action_pressed("left_click"):
		qunector.visible = true
		clicked.emit(destination.global_position)

func handle_input(_touch_position: Vector3) -> void:
	# print("touch input at: ", touch_position)
	pass

func _on_area_entered(area: Area3D) -> void:
	# print("area entered by: ", area)
	pass

func _on_mouse_entered() -> void:
	mesh.visible = true

func _on_mouse_exited() -> void:
	mesh.visible = false
