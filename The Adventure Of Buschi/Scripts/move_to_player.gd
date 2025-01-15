extends Node2D

var parent: characterStats

func _ready() -> void:
	parent = get_parent()

func moveToPlayer(delta: float) -> void:
	parent.velocity += (parent.position.direction_to(parent.area.character.position) * parent.accel * delta)
	parent.velocity = parent.velocity.limit_length(parent.max_speed)
	
func stopMoving(delta: float) -> void:
	if parent.velocity.length() > (parent.friction * delta):
		#slows the character down, if its velocity didn't reache 0
		parent.velocity -= parent.velocity.normalized() * (parent.friction * delta)
	else:
		#completly stops him, if its velocity reached 0
		parent.velocity = Vector2.ZERO

func moveAway(delta: float) -> void:
	parent.velocity -= (parent.position.direction_to(parent.area.character.position) * parent.accel * delta)
	parent.velocity = parent.velocity.limit_length(parent.max_speed)
