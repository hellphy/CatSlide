extends Node2D

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _on_button_pressed() -> void:
	collision_shape_2d.disabled = false
	Pieces.can_click = false
