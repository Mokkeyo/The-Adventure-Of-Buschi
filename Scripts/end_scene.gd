extends Node2D

var music: String = "res://music/Area2.mp3"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.start_music(music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")
