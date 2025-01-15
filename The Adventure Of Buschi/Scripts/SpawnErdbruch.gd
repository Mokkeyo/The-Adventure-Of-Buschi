extends ability

var b: Node2D
var ball: PackedScene = preload("res://Scenes/erdbruch.tscn")
var parent: Node2D

func _ready() -> void:
	couldown = tempCouldown + duration
	parent = get_parent()

func ability() -> void:
	print("ability")
	b = ball.instantiate()
	b.duration = duration
	b.global_position = global_position
	parent.get_parent().call_deferred("add_child", b)
