extends ColorRect

@export var start: bool = false

func _ready() -> void:
	if start:
		do_it()

func do_it() -> void:
	fade_out()

func fade_in() -> AnimationPlayer:
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	return $AnimationPlayer

func fade_out() -> AnimationPlayer:
	get_tree().paused = false
	$AnimationPlayer.play("fade_out")
	return $AnimationPlayer
