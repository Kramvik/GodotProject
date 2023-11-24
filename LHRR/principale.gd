extends Node3D

var remaining_enemies = 0
var score = 0
@export var mob_scene: PackedScene
var player = null
@export var playerpath = "/root/Principale/hero"
var mob_spawn_location
var cpt = 0
var changement = false
var changement2 = false
var changement3 = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.score >= 6 && self.score < 12:
		if changement == false:
			cpt = 0
			changement = true
			mob_spawn_location = get_node("Path3D/PathFollow3D")
	elif self.score >= 12 && self.score < 24: 
		if changement2 == false:
			cpt = 0
			changement2 = true
			mob_spawn_location = get_node("Path3D2/PathFollow3D")
	elif self.score >= 24: 
		if changement3 == false:
			get_tree().change_scene_to_file("res://before_boss_fight.tscn")
	else:
		mob_spawn_location = get_node("SpawnPath/SpawnLocation")


func _on_mob_timer_timeout():
	var mob

	mob = mob_scene.instantiate()
	mob_spawn_location.progress_ratio = randf()
	var player_position = $hero.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	if mob_spawn_location == get_node("Path3D2/PathFollow3D"):
		if cpt < 12 :
			add_child(mob)
			remaining_enemies += 1
			cpt = cpt + 1
	else:
		if cpt < 6 :
			add_child(mob)
			remaining_enemies += 1
			cpt = cpt + 1
