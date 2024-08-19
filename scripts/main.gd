extends Node2D


@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var cat: Cat = %Cat

var cat_position: Vector2
var cat_rotation: float


func _ready() -> void:
	cat_position = cat.position
	cat_rotation = cat.rotation
	print(cat.position)


func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		cat.position = cat_position
		cat.rotation = cat_rotation
		cat.reparent(self)
		collision_shape_2d.disabled = true
		Pieces.can_click = true
		Cross_Piece.can_click = true
		Globals.emit_signal("restart_areas")


func _on_button_pressed() -> void:
	collision_shape_2d.disabled = false
	Pieces.can_click = false
	Cross_Piece.can_click = false
	ray_cast_2d.enabled = true


func _on_cross_pressed() -> void:
	var new_cross := preload("res://scenes/cross.tscn").instantiate()
	%GridContainer.add_child(new_cross)


func _on_straight_pressed() -> void:
	var new_straight := preload("res://scenes/straight.tscn").instantiate()
	%GridContainer.add_child(new_straight)


func _on_curve_pressed() -> void:
	var new_curve := preload("res://scenes/corner.tscn").instantiate()
	%GridContainer.add_child(new_curve)

