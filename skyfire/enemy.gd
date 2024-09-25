extends CharacterBody2D

const type: String = "enemy"
const LEFT: int = 0
const RIGHT: int = 1
var screensize: Vector2
var direction: int
var half_w: int
var half_h: int
var speed_y: int = 200
var speed_x: int = 300

func _ready() -> void:
	randomize()
	screensize = get_viewport_rect().size
	half_w = $Sprite2D.texture.get_width() / 2
	half_h = $Sprite2D.texture.get_width() / 2
	position.x = randi() % int(screensize.x)
	direction = randi() % 2
	
func _physics_process(delta: float) -> void:
	var vec = Vector2()
	vec.y += speed_y
	if direction == RIGHT:
		vec.x += speed_x
		if position.x + half_w > screensize.x:
			direction = LEFT
			
	else:
		vec.x -= speed_x
		if position.x - half_w < 0:
			direction = RIGHT
	var collision = move_and_collide(vec * delta)
	if collision:
		var entity = collision.get_collider()
		if 'ship' in entity.type:
			kill()
			entity.kill()
	
func kill() -> void:
	get_parent().new_explosion(position)
	queue_free()	
