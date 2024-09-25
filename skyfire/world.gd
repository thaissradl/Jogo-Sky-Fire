extends Node2D

const Bomb = preload("res://bomb.tscn")
const Enemy = preload("res://enemy.tscn")
const Explosion = preload("res://explosion.tscn")

var is_game_over: bool = false
var score: int

func new_bomb(pos: Vector2) -> void:
	var bomb = Bomb.instantiate()
	bomb.position = pos
	add_child(bomb)
	
func new_explosion(pos: Vector2):
	var explosion = Explosion.instantiate() # instanciamos um objeto Explosion
	explosion.position = pos                # colocamos ele na posicao
	add_child(explosion) 
	
func _on_enemy_timer_timeout() -> void:
	if is_game_over:
		return
	var enemy = Enemy.instantiate()
	add_child(enemy)
	$EnemyTimer.wait_time = (randi() % 2) + 1
	$EnemyTimer.start()
	
func game_over() -> void:
	is_game_over = true
	$GameOver.visible = true
	$EnemyTimer.stop()
	$Music.stop()
