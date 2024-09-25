extends CharacterBody2D

const type: String = "ship"
var speed: int = 500
var screensize: Vector2
var half_w : int
var half_h : int

func _ready() -> void:
	screensize = get_viewport_rect().size
	half_w = $Sprite2D.texture.get_width() / 2
	half_h = $Sprite2D.texture.get_height() / 2
func _physics_process(delta: float) -> void:
	var vec = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		vec.x -= speed
	elif Input.is_action_pressed("ui_right"):
		vec.x += speed
		
	if Input.is_action_just_pressed("ui_select"):
		get_parent().new_bomb(Vector2(position.x, position.y - half_h - 20))
	move_and_collide(vec * delta)
	position.x = clamp(position.x, half_w, screensize.x- half_w)
	
func kill() -> void:
	queue_free()
	get_parent().new_explosion(position)
	get_parent().game_over()
