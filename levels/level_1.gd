extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var frog_path = $Path2D
	var frog = $frog
	var frog2 = $frog2
	var frog3 = $frog3
	var frog4 = $frog4
	var frog5 = $frog5
	var frog_path2 = $Path2D2
	var frog_path3 = $Path2D3
	var frog_path4 = $Path2D4
	var frog_path5 = $Path2D5
	frog.start(frog_path)
	frog2.start(frog_path2)
	frog3.start(frog_path3)
	frog4.start(frog_path4)
	frog5.start(frog_path5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
