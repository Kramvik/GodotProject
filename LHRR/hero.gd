extends CharacterBody3D

@export var acceleration = 1.0
@export var esquive_vitesse = 4.25

var is_hurt = false
var is_dead = false
var forward_speed = 0.0
var esquive_input = 0.0
var health = 100

@onready var animation = $AnimationPlayer

func _ready():
	velocity = Vector3.ZERO

func _get_input(delta):
	if Input.is_action_pressed("marcher"):
		var target_speed = lerp(forward_speed, -7.0, 0.5)
		forward_speed = target_speed
		animation.play("marcher")
	if Input.is_action_pressed("taper"):
		if !$AudioStreamPlayer.playing:
			$AudioStreamPlayer.play()
		animation.play("taper")
	if Input.is_action_pressed("reculer"):
		forward_speed = lerp(forward_speed, 5.0, acceleration * delta)
		animation.play("marcher")
	var target_esquive_input = Input.get_action_strength("esquive gauche") - Input.get_action_strength("esquive droite")
	esquive_input = lerp(esquive_input, target_esquive_input, 0.1)

	if Input.is_action_just_released("marcher"):
		forward_speed = 0.0
		animation.stop()
	if Input.is_action_just_released("reculer"):
		forward_speed = 0.0
		animation.stop()


func hurt(hit_points):
	if hit_points < health: 
		health -= hit_points
	else: 
		health = 0
	$Camera/HealthBar.value = health
	if health == 0: 
		die()

func restore_health(hit_points):
	if((hit_points + health) < 100):
		health += hit_points
	else: 
		health = 100 
	$Camera/HealthBar.value = health
	$healsound.play()
func die():
	queue_free()
	get_tree().change_scene_to_file("res://end_menu.tscn")
		
func _physics_process(delta):
	_get_input(delta)
	var target_basis = transform.basis.rotated(transform.basis.y, esquive_input * esquive_vitesse * delta)
	transform.basis = lerp(transform.basis, target_basis, 0.7)
	transform.basis = transform.basis.orthonormalized()
	velocity = transform.basis.z * forward_speed
	move_and_collide(velocity * delta)



