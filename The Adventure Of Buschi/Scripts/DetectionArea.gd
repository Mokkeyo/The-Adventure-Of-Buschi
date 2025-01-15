extends Area2D

var character: CharacterBody2D = null

#0 = Detect Player, 1 = Detect enemy
@export var chr:int = 0

func _on_body_entered(body: Node2D) -> void:
	if chr == 0:
		if body.is_in_group("Player"):
			character = body
	else:
		if body.is_in_group("Enemy"):
			character = body

func _on_body_exited(body: Node2D) -> void:
	if chr == 0:
		if body.is_in_group("Player"):
			character = null
	else:
		if body.is_in_group("Enemy"):
			character = null
