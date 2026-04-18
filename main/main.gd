extends Node2D

@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spawn = $TEST/spawn_player
	player.spawn_player(spawn)
	
	var all_vide = get_tree().get_nodes_in_group('vide')
	
	for zone in all_vide:
		zone.die.connect(func(): _on_die(spawn))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_die(marker):
	player.die(marker)
