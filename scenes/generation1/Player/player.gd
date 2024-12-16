extends CharacterBody2D

var window_size : Vector2
var player_speed : int = 10000

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta) :
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * player_speed * delta
	var collision_object = move_and_slide()

func player_death() :
	#$"../../Generation1".restart_game()
	pass
