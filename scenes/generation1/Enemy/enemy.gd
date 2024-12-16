extends CharacterBody2D

var speed = 150.0
const ACCELERATION = 5
var window_size : Vector2
var collision_object
const SPAWN_SAFE_ZONE = 50


func _ready() -> void:
	window_size = get_viewport_rect().size
	randomize() #Randomize seed to be used for other random functions
	start_position()

func _physics_process(delta: float) -> void:
	movement_and_collision(delta)

func start_position() :
	position.x = randi_range(0, window_size.x)
	position.y = randi_range(0, window_size.y)
	respawn_close_enemys()

func start_direction() :
	velocity.x = [-1,1][randi() % 2]
	velocity.y = [-0.78, 0.78][randi() % 2]
	
func movement_and_collision(delta) :
	collision_object = move_and_collide(velocity * speed * delta)
	if collision_object :
		velocity = velocity.bounce(collision_object.get_normal())
		if speed < 250 :
			speed += ACCELERATION
		elif speed < 500 :
			speed += ACCELERATION/5
		detect_collision_with_player(collision_object)

func respawn_close_enemys() :
	if position.x <= $"../../Player".position.x + SPAWN_SAFE_ZONE and position.x >= $"../../Player".position.x - SPAWN_SAFE_ZONE and position.y <= $"../../Player".position.y + SPAWN_SAFE_ZONE and position.y >= $"../../Player".position.y - SPAWN_SAFE_ZONE :
		start_position()

func detect_collision_with_player(collision_object) :
	if collision_object.get_collider() == $"../../Player" : 
		$"../../Player".player_death()


func _on_start_movement_timeout() -> void:
	start_direction()
