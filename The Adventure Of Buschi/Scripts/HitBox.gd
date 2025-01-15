extends Area2D
class_name hitbox

signal entered

@export var dmg: float
@onready var collision: CollisionShape2D = $CollisionShape2D
@export var parent: Node2D

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtbox") and area.get_parent() != parent:
		if parent:
			area.damage(int(dmg * parent.attackPower))
		else:
			area.damage(dmg)
		emit_signal("entered")
