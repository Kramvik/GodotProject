extends Node3D

@export var dragon_scene : PackedScene
var cpt = 0
var vie_boss = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_dragon_timer_timeout():
	var drake = dragon_scene.instantiate()

	var dragon_spawn_location = get_node("Path3D/PathFollow3D")
	dragon_spawn_location.progress_ratio = randf()

	var player_position = $hero.position
	drake.initialize(dragon_spawn_location.position, player_position)
	
	if cpt < 1 :
		cpt += 1
		add_child(drake)
