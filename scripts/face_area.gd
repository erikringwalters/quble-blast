extends Area3D

@onready var mesh: MeshInstance3D = %Mesh

func _ready() -> void:
	connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(_camera: Camera3D, _event: InputEvent, touch_position: Vector3, _normal: Vector3, _shape_idx: float) -> void:
	handle_input(touch_position)

func handle_input(touch_position: Vector3) -> void:
	print("touch input at: ", touch_position)

func _on_area_entered(area: Area3D) -> void:
	print("area entered by: ", area)

func _on_mouse_entered() -> void:
	mesh.visible = true
	
func _on_mouse_exited() -> void:
	mesh.visible = false
