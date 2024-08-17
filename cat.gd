class_name  Cat extends CharacterBody2D

var direction := Vector2.UP
var speed := 50

func _physics_process(delta: float) -> void:
	position += direction.rotated(rotation) * speed * delta
