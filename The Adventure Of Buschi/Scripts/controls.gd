extends Node2D

func _on_zurück_knopf_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/optionen.tscn")
