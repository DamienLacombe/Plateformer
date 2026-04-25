extends Area2D
@export var cible_tp = Vector2(1228, -1260)

func _on_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
	if body is CharacterBody2D:
		body.global_position = cible_tp
		print ("Joeur tp en ", cible_tp)
