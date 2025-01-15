extends Node2D

var AttackPower: float = 1.0

func died() -> void:
	queue_free()

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy") == false:
		$HurtBox.damage(1)
