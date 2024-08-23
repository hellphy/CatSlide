extends Control


func _physics_process(delta: float) -> void:
	%AnimatedSprite2D.rotation_degrees += 20 * delta


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
