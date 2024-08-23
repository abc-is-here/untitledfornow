extends Node3D

@onready var obstacle = preload("res://obstacle.tscn")
@onready var spawn_pos: Marker3D = $"../player/spawnPos"

func _on_spawn_delay_timeout() -> void:
	var obstacleInstance = obstacle.instantiate()
	obstacleInstance.position = spawn_pos.position + Vector3(randf_range(-10,10),0,0)
	add_child(obstacleInstance)
