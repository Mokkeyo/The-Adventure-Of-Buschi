extends Node2D
class_name healthcomponent

@export var max_health: float = 100
var health: float
var counter: PackedScene = preload("res://Scenes/damage_count_player.tscn")
var c: Node2D

func _ready() -> void:
	health = max_health


func damage(dmg: float) -> void:
	if health > 0:
		health -= dmg
		if get_parent().is_in_group("Projectile") == false:
			c = counter.instantiate()
			if get_parent().is_in_group("Player"):
				c.color = 0
			c.dmg = dmg
			c.global_position = get_parent().global_position
			get_parent().get_parent().call_deferred("add_child", c)
		if get_parent().is_in_group("Player"):
			get_parent().canMove = true
		if health <= 0:
			if get_parent().has_method("died"):
				get_parent().died()
