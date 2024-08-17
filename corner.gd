extends Area2D


@onready var path1: PathFollow2D = %Path1
@onready var path2: PathFollow2D = %Path2

@onready var first_entry: Area2D = %FirstEntry
@onready var second_entry: Area2D = %SecondEntry


func path_anim(path: PathFollow2D,ratio: int) -> void:
	var tween := create_tween()
	tween.tween_property(path,"progress_ratio",ratio,0.5)


func add_player(body: Node2D, path: Node2D) -> void:
	body.reparent(path)


func _on_first_entry_body_entered(body: Node2D) -> void:
	call_deferred("disable_areas")
	call_deferred("add_player",body, path1)
	path_anim(path1, 1)


func _on_second_entry_body_entered(body: Node2D) -> void:
	call_deferred("disable_areas")
	call_deferred("add_player",body, path2)
	path_anim(path2,1)


func disable_areas():
	#if path has a player then both should be disabled 

	if path1.get_child_count() != 0 or path2.get_child_count() != 0:
		first_entry.monitoring = false
		second_entry.monitoring = false
		print("not disabled")
	else:
		first_entry.monitoring = true
		second_entry.monitoring = true
		print("disabled")
		
		
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	)
	
	if event_is_mouse_click:
		var rotation_tween := create_tween()
		var desired_rotation = rotation_degrees + 90
		rotation_tween.tween_property(self,"rotation_degrees", desired_rotation, 0.3)

