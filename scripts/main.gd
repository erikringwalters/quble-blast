extends Node3D

@export var quble_scene: PackedScene

var quble_distance_offset: float = 2.0

func _ready() -> void:
	spawn_qubles(1)

func spawn_qubles(count: int) -> void:
	for i in count:
		for j in count:
			for k in count:
				print(i, j, k)
				var quble: RigidBody3D = quble_scene.instantiate()
				add_child(quble)
				quble.position = Vector3(i * quble_distance_offset, j * quble_distance_offset, k * quble_distance_offset)
