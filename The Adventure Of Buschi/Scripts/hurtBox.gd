extends Area2D
class_name hurtBox

@export var healthComponent: healthcomponent

func damage(dmg: float) -> void:
	if healthComponent:
		healthComponent.damage(dmg)
