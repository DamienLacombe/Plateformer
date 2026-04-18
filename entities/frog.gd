extends CharacterBody2D
signal die
@export var speed := 40

var path: Path2D
var distance := 0.0

func start(p: Path2D):
	path = p
	distance = 0.0
	var local_pos = path.curve.sample_baked(0.0)
	global_position = path.to_global(local_pos)

func _physics_process(delta):
	if path == null:
		return
	var global_pos = path.to_global(path.curve.sample_baked(distance))
	var path_length = path.curve.get_baked_length()
	distance = fmod(distance, path_length)
	distance += speed * delta
	global_position = global_pos
	animate(path_length)

func animate(path_length):
	if distance > path_length / 2:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.play("walk")


func _on_area_2d_body_entered(body: Node2D) -> void:
# On oublie le groupe pour 2 secondes, on teste juste le nom
	if body.name == "Player": 
		print("Le MOB a enfin touché le joueur !")
		die.emit()
