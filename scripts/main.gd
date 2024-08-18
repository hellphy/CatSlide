extends Node2D

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _on_button_pressed() -> void:
	collision_shape_2d.disabled = false
	Pieces.can_click = false
	Cross_Piece.can_click = false



func _on_cross_pressed() -> void:
	var new_cross := preload("res://scenes/cross.tscn").instantiate()
	%GridContainer.add_child(new_cross)


func _on_straight_pressed() -> void:
	var new_straight := preload("res://scenes/straight.tscn").instantiate()
	%GridContainer.add_child(new_straight)

func _on_curve_pressed() -> void:
	var new_curve := preload("res://scenes/corner.tscn").instantiate()
	%GridContainer.add_child(new_curve)
