extends Node2D


@onready var respawn_point = $"../respawn_point"
@onready var exit = $"../exit"


func _ready() -> void:
	respawn_point.transform = %Respawn_pos.transform
	exit.position = %Exit_pos.position
	Globals.current_level = 1
	Globals.level_tiles = 7

