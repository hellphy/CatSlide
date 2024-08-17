class_name Cross_Piece extends Area2D



@onready var path1: PathFollow2D = %Path1
@onready var path2: PathFollow2D = %Path2
@onready var path3: PathFollow2D = %Path3
@onready var path4: PathFollow2D = %Path4


@onready var first_entry: Area2D = %FirstEntry
@onready var second_entry: Area2D = %SecondEntry
@onready var third_entry: Area2D = %ThirdEntry
@onready var fourth_entry: Area2D = %FourthEntry


static var can_click = true

func path_anim(path: PathFollow2D,ratio: int) -> void:
	#animates start and finish of a path 
	var tween := create_tween()
	tween.tween_property(path,"progress_ratio",ratio,0.8)


func add_player(body: Node2D, path: Node2D) -> void:
	#adds player to the path he is currently on 
	body.reparent(path)




func disable_areas():
	#if path has a player then both should be disabled 
	if path1.get_child_count() != 0 or path2.get_child_count() != 0 or path3.get_child_count() !=0 or path4.get_child_count() != 0:
		first_entry.monitoring = false
		second_entry.monitoring = false
		third_entry.monitoring = false
		fourth_entry.monitoring = false

	else:
		first_entry.monitoring = true
		second_entry.monitoring = true
		third_entry.monitoring = true
		fourth_entry.monitoring = true
		
		
func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	#rotates pieces 
	var event_is_mouse_click: bool = (
		event is InputEventMouseButton
		and event.button_index == MOUSE_BUTTON_LEFT
		and event.is_pressed()
	)
	
	if event_is_mouse_click and can_click:
		var rotation_tween := create_tween()
		var desired_rotation = rotation_degrees + 90
		rotation_tween.tween_property(self,"rotation_degrees", desired_rotation, 0.3)
		can_click = false
		rotation_tween.finished.connect(reset_click)
		

func reset_click():
	can_click = true


func _on_first_entry_body_entered(body: Node2D) -> void:
	call_deferred("disable_areas")
	call_deferred("add_player",body, path1)
	path_anim(path1, 1)




func _on_second_entry_body_entered(body: Node2D) -> void:
	call_deferred("disable_areas")
	call_deferred("add_player",body, path2)
	path_anim(path2, 1)



func _on_third_entry_body_entered(body: Node2D) -> void:
	print("entered")
	call_deferred("disable_areas")
	call_deferred("add_player",body, path3)
	path_anim(path3, 1)



func _on_fourth_entry_body_entered(body: Node2D) -> void:
	call_deferred("disable_areas")
	call_deferred("add_player",body, path4)
	path_anim(path4, 1)

