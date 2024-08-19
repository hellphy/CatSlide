extends Node2D


@onready var cat_collider = get_node("root/Node2D/Cat/CatCollider")
@onready var cat_area = get_node("root/Node2D/Cat/CatArea")
@onready var cat: CharacterBody2D = $Cat
@onready var respawn_point: Node2D = %respawn_point

func _on_button_pressed() -> void:
	print(cat.position)
	cat_collider.disabled = false
	Pieces.can_click = false
	Cross_Piece.can_click = false
	cat_area.monitoring = true


func _on_cross_pressed() -> void:
	var new_cross := preload("res://scenes/cross.tscn").instantiate()
	%GridContainer.add_child(new_cross)


func _on_straight_pressed() -> void:
	var new_straight := preload("res://scenes/straight.tscn").instantiate()
	%GridContainer.add_child(new_straight)


func _on_curve_pressed() -> void:
	var new_curve := preload("res://scenes/corner.tscn").instantiate()
	%GridContainer.add_child(new_curve)



func _on_area_2d_body_entered(body: Node2D) -> void:
	call_deferred("restart")


func restart() -> void:
	cat.queue_free()
	var new_cat := preload("res://scenes/cat.tscn").instantiate()
	add_child(new_cat)
	new_cat.transform = respawn_point.transform
	cat_collider.disabled = true
	Pieces.can_click = true
	Cross_Piece.can_click = true
	Globals.emit_signal("restart_areas")
