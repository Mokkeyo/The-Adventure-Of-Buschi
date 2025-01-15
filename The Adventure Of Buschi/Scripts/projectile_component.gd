extends Node2D

@export var Speed: int = 400
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2(1, 0).rotated(get_parent().rotation)
	get_parent().global_position += velocity * Speed * delta
