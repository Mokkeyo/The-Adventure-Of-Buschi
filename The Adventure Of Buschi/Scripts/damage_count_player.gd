extends Node2D

var dmg: float
var color: int = 1

func _ready() -> void:
	$Label.text = str(dmg)
	$AnimationPlayer.play("animation")
	if color == 0:
		$Label.add_theme_color_override("font_color", Color(255, 255, 255))

func _on_animation_player_animation_finished(_anim_name: String) -> void:
	queue_free()
