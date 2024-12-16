extends Node2D

var window_height : float
var window_width : float
var general_scale : Vector2 = Vector2 (1.0,1.0)
var round_counter : int = 1
const MINIMUM_ROUND_TIME : int = 10
const ROUND_TIME_INCREMENT : int = 3

var enemy_scane = preload("res://scenes/generation1/Enemy/enemy.tscn")

func _ready() -> void:
	%InitialTimer.start()
	pass

func _process(delta: float) -> void:
	pass

func enemy_spawn() :
	var enemy = enemy_scane.instantiate()
	%EnemyHolder.add_child(enemy)

func destroy_enemies() :
	for i in %EnemyHolder.get_children():
		i.queue_free()

func restart_game() :
	get_tree().reload_current_scene()

func round_lenght() :
	return MINIMUM_ROUND_TIME + (round_counter * ROUND_TIME_INCREMENT)

func new_round(time) :
	for i in round_counter: 
		enemy_spawn()
		$Round_Lenght.start(time)
		change_hud_round_counter()

func end_round() :
	for i in $"%EnemyHolder".get_children():
		i.queue_free()
	round_counter += 1


func change_hud_round_counter() :
	$HUD/Round.text = str("%d" %round_counter)


func _on_round_lenght_timeout() -> void:
	end_round()
	new_round(round_lenght())
func _on_initial_timer_timeout() -> void:
	new_round(MINIMUM_ROUND_TIME)
