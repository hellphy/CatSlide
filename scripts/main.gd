class_name LevelManager extends Node2D


@onready var respawn_point: Node2D = $respawn_point
@onready var exit: Area2D = $exit


func _ready() -> void:
	Globals.connect("restart", _restart_level)
	_restart_level()


func _physics_process(delta: float) -> void:
	%RichTextLabel.text = str(Globals.level_tiles) + "/" + str(Globals.tile_counter)


func _on_button_pressed() -> void:
	get_tree().call_group("Cat", "play_aniamtion")
	Cat.collider_switch = false
	Cat.area_switch = true
	Pieces.can_click = false
	Cross_Piece.can_click = false


func _restart_level() -> void:
	call_deferred("restart")


func restart() -> void:
	Globals.tile_counter = 0
	get_tree().call_group("Cat", "queue_free")
	var new_cat := preload("res://scenes/cat.tscn").instantiate()
	add_child(new_cat)
	new_cat.transform = respawn_point.transform
	

	Cat.collider_switch = true
	Pieces.can_click = true
	Cross_Piece.can_click = true
	Globals.emit_signal("restart_areas")


func _on_exit_body_entered(body: Node2D) -> void:
	if Globals.tile_counter == Globals.level_tiles:
			%VictoryScreen.visible = true
