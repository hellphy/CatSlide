extends Node2D


@onready var respawn_point = $"../respawn_point"


func _ready() -> void:
	respawn_point.transform = %Respawn_pos.transform
	Globals.level_tiles = 18

