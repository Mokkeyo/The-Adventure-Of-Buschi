extends Node2D

var activeLayer: int = 5
var canUnpause: bool = false
var music: String = "res://music/Area4.mp3"

func _ready() -> void:
	G.start_music(music)
	$AnimationPlayer.play("Layer1Visible")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause") and get_tree().paused == false:
		$CanvasLayer/PauseMenu.visible = true
		$Timer.start()

func _on_layer_0_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		activeLayer = 6
		body.set_collision_mask_value(5, false)
		body.set_collision_mask_value(6, true)
		body.set_collision_layer_value(5, false)
		body.set_collision_layer_value(6, true)
		$AnimationPlayer.play("Layer0Visible")


func _on_layer_1_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		activeLayer = 5
		body.set_collision_mask_value(5, true)
		body.set_collision_mask_value(6, false)
		body.set_collision_layer_value(5, true)
		body.set_collision_layer_value(6, false)
		$AnimationPlayer.play("Layer1Visible")


func _on_timer_timeout() -> void:
	$CanvasLayer/PauseMenu.canUnpause = true
	get_tree().paused = true
