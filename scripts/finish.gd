extends Control


func _ready() -> void:
	%Shadow.visible = true
	Globals.connect("restart_areas", _restart_areas)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Cat"):
		Globals.tile_counter += 1
		Globals.emit_signal("finish")
		%Shadow.visible = false

func _restart_areas() -> void:
	%Shadow.visible = true
