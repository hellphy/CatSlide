extends Node2D


@onready var respawn_point: Node2D = %respawn_point


func _ready() -> void:
	Globals.connect("restart", _restart_level)
	_restart_level()


func _on_button_pressed() -> void:
	Cat.collider_switch = false
	Cat.area_switch = true
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



func _restart_level() -> void:
	call_deferred("restart")


func restart() -> void:
	get_tree().call_group("Cat", "queue_free")
	var new_cat := preload("res://scenes/cat.tscn").instantiate()
	add_child(new_cat)
	new_cat.transform = respawn_point.transform
	Cat.collider_switch = true
	Pieces.can_click = true
	Cross_Piece.can_click = true
	Globals.emit_signal("restart_areas")
