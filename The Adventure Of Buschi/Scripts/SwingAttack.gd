extends Node2D

@export var weaponArt: String
@export var attackSpeed: float = 0.4
@export var attackDuration: float = 0.2
@export var Hitbox: hitbox

func attack() -> void:
	$AttackDuration.start(attackDuration)
	Hitbox.collision.disabled = false
	$AttackAnimation.play("Attack")
	$AttackAnimation.visible = true

func _on_attack_duration_timeout() -> void:
	Hitbox.collision.disabled = true
	$AttackAnimation.stop()
	$AttackAnimation.visible = false
