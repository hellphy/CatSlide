class_name  Cat extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

static var collider_switch := true
static var area_switch := false

func _physics_process(delta: float) -> void:
	%CatCollider.disabled = collider_switch
	%CatArea.monitoring = area_switch 


func _on_cat_area_body_entered(body: Node2D) -> void:
	Globals.emit_signal("restart")
	
	
func play_aniamtion():
	animated_sprite_2d.play("new_animation")
