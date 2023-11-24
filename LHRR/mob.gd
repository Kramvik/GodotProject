extends CharacterBody3D


var player = null
@export var playerpath = "/root/Principale/hero"
const SPEED = 2.0
const JUMP_VELOCITY = 4.5
@export var max_speed = 10
@export var min_speed = 5
@onready var navigationAgent = $NavigationAgent3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready() :
	player = get_node(playerpath)

func _physics_process(delta):
	velocity = Vector3.ZERO
	navigationAgent.set_target_position(player.global_transform.origin)
	var prochaineNav = navigationAgent.get_next_path_position()
	velocity = (prochaineNav - global_transform.origin).normalized()
	rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 5.0)
	look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	velocity = transform.basis.z * -SPEED
	move_and_slide()

		
	
func initialize(start_position, player_position):

	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))

	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
