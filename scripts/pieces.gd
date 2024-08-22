class_name Pieces extends Area2D


@onready var path1: PathFollow2D = %Path1
@onready var path2: PathFollow2D = %Path2


@onready var first_entry: Area2D = %FirstEntry
@onready var second_entry: Area2D = %SecondEntry

var tween: Tween

static var can_click = true

var random_angle = [
	0, 90, 180, 270
]

func _ready() -> void:
	Globals.connect("restart_areas", _restart_areas)
	rotation_degrees = random_angle.pick_random()
	

func _restart_areas() -> void:
	%Shadow.visible = true
	if tween != null:
		tween.kill()
	first_entry.monitoring = true
	second_entry.monitoring = true
	path1.progress_ratio = 0
	path2.progress_ratio = 0

func path_anim(path: PathFollow2D,ratio: int) -> void:
	#animates start and finish of a path 
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(path,"progress_ratio",ratio,0.4)


func add_player(body: Node2D, path: Node2D) -> void:
	#adds player to the path he is currently on 
	body.reparent(path)


func _on_first_entry_body_entered(body: Node2D) -> void:
	Globals.tile_counter += 1 
	%Shadow.visible = false
	body.global_position = path1.global_position
	path1.progress_ratio = 0
	call_deferred("disable_areas",first_entry)
	call_deferred("disable_areas",second_entry)
	call_deferred("add_player",body, path1)
	path_anim(path1, 1)


func _on_second_entry_body_entered(body: Node2D) -> void:
	Globals.tile_counter += 1 
	%Shadow.visible = false
	body.global_position = path2.global_position
	path2.progress_ratio = 0
	call_deferred("disable_areas",second_entry)
	call_deferred("disable_areas",first_entry)
	call_deferred("add_player",body, path2)
	path_anim(path2,1)


func disable_areas(entry):
	entry.monitoring = false


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
