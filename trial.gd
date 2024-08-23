extends Node3D

@onready var player: Node3D = $player
@onready var spawn_pos: Marker3D = $player/spawnPos
var spawn_offset = Vector3(0, 50.0, 0)

func _process(delta: float) -> void:
	spawn_pos.position = player.position + spawn_offset
