class_name LevelManager extends Node2D


@onready var respawn_point: Node2D = $respawn_point


var level: Node2D

var levels: Array = [
	"res://Levels/level_scenes/level_1.tscn",
	"res://Levels/level_scenes/level_2.tscn",
	"res://Levels/level_scenes/level_3.tscn",
	"res://Levels/level_scenes/level_4.tscn",
	"res://Levels/level_scenes/level_5.tscn",
	"res://Levels/level_scenes/level_6.tscn",
	"res://Levels/level_scenes/level_7.tscn",
	"res://Levels/level_scenes/level_8.tscn",
	
	
	
]


func _ready() -> void:
	print(levels.size())
	print(Globals.current_level)
	_add_level()
	Globals.connect("restart", _restart_level)
	Globals.connect("finish", _finished)
	
	_restart_level()


func _physics_process(delta: float) -> void:
	%RichTextLabel.text = str(Globals.tile_counter) + "/" + str(Globals.level_tiles)
	%CurrentLevel.text = "level: " + str(Globals.current_level)


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


func _finished() -> void:
	if Globals.tile_counter == Globals.level_tiles:
			%CanvasLayer.visible = true


func _add_level() -> void:
	level = load(levels[Globals.current_level - 1]).instantiate()
	add_child(level)


func _on_next_level_button_pressed() -> void:
	if Globals.current_level >= levels.size():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
		Globals.current_level = 1
	else:
		%CanvasLayer.visible = false
		level.queue_free()
		Globals.current_level += 1
		_add_level()
		_restart_level()

