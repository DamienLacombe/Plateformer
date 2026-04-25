extends Node2D
@export var level_1_scene : PackedScene
@export var level_2_scene : PackedScene
@onready var level_container = $Level_container
@onready var player = $Player
@onready var hud = $Hud
@onready var hud_layer = $Hud/CanvasLayer
var current_lvl 
var level = 1 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level == 1:
		current_lvl = load_level(level_1_scene)
		setup_lvl(current_lvl)
	hud.replay.connect(func(): replay())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func setup_lvl(current_lvl):
	var spawn = current_lvl.find_child("spawn_player")
	if spawn:
		player.velocity = Vector2.ZERO
		player.spawn_player(spawn)
		player.reset_physics_interpolation()
	var all_vide = get_tree().get_nodes_in_group('vide')
	var all_flag = get_tree().get_nodes_in_group('flag')
	
	for flag in all_flag:
		flag.end_level.connect(func(): _next_level())
	
	for zone in all_vide:
		zone.die.connect(func(): _on_die(spawn))
	
		
	
func load_level(level):
	for enfant in level_container.get_children():
		enfant.queue_free()
	var niveau_instance = level.instantiate()
	level_container.add_child(niveau_instance)
	return niveau_instance
	
func _on_die(marker):
	player.die(marker)

func _next_level():
	await get_tree().process_frame
	level += 1
	print("drapeau prit : ", level)
	if level == 1:
		hud_layer.hide()
		current_lvl = load_level(level_1_scene)
		setup_lvl(current_lvl)
	elif level == 2:
		current_lvl = load_level(level_2_scene)
		setup_lvl(current_lvl)
	else:
		hud_layer.show()

func replay():
	level = 0 
	_next_level()

	
