extends Node2D

@export var parent: Node2D
# Called when the node enters the scene tree for the first time.
func disableHurtBox() -> void:
	parent.get_parent().hurtbox.disabled = true
	
func enableHurtBox() -> void:
	parent.get_parent().hurtbox.disabled = false
	
