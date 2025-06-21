extends Area3D

func _ready() -> void:
	connect("input_event", Callable(self, "_on_input_event"))

func _on_input_event(_camera: Camera3D, _event: InputEvent, touch_position: Vector3, _normal: Vector3, _shape_idx: float) -> void:
	handle_input(touch_position)

func handle_input(touch_position: Vector3) -> void:
	print("touch input at: ", touch_position)