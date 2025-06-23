extends Node3D

@export var quble_scene: PackedScene

var quble_width: float = 1.6
var quble_offset: float = quble_width
var quble_axis_count: int = 10

func _ready() -> void:
	spawn_quble()
	# spawn_qubles(quble_axis_count)
	pass

func spawn_qubles(count: int) -> void:
	for i in count:
		for j in count:
			for k in count:
				var quble := spawn_quble()
				var position_offset: float = (quble_width * count * 0.5) - (quble_width * 0.5)
				quble.position = Vector3(
					i * quble_offset - position_offset, \
					j * quble_offset - position_offset, \
					k * quble_offset - position_offset \
				)

func spawn_quble() -> RigidBody3D:
	var quble: RigidBody3D = quble_scene.instantiate()
	add_child(quble)
	return quble

func _on_clicked(destination: Vector3) -> void:
	print("clicked")
	var quble: RigidBody3D = quble_scene.instantiate()
	add_child(quble)
	quble.global_position = destination
