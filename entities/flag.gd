extends Area2D
var taking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if taking == false:
		$AnimatedSprite2D.animation = "moove"
	else:
		$AnimatedSprite2D.animation = "take"
	$AnimatedSprite2D.play()
	
	

func _on_body_entered(body: Node2D) -> void:
	taking = true
	body.die()
