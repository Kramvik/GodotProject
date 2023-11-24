extends Area3D

signal touche

@export var principalepath = "/root/Principale"
var score = null
var remaining_enemies = null
var max_health = 100
var current_health = max_health
var ennemi = null
@onready var ennemislifepath = $SubViewport/HealthBar3D
var damage_done = 25
var ennemilife = null
	
func _ready() :
	score = get_node(principalepath)
	remaining_enemies = get_node(principalepath)
	
func take_damage(amount):
	current_health -= amount
	ennemislifepath.value -= damage_done
	if current_health <= 0:
		get_parent().queue_free()
		score.score += 1
		remaining_enemies.remaining_enemies = remaining_enemies.remaining_enemies - 1
		


func _on_body_entered(body):
	if body.is_in_group("epee") && Input.is_action_pressed("taper"):
		print("Aie")
		take_damage(damage_done)
	if body.is_in_group("hero"):
		print("J'ai mal")
		get_tree().call_group("hero", "hurt", 5)
	
func _process(delta):
	pass
