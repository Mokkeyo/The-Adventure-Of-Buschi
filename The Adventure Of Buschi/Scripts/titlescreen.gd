extends Node2D

var music: String = "res://music/TitleScreen.mp3"

func _ready() -> void:
	if G.start_Title:
		G.start_music(music)
		G.start_Title = false
		$Fader.visible = true
		$Fader.do_it()

func change_scene_to(scene: String) -> void:
	var animation_player: AnimationPlayer = $Fader.fade_in()
	$Fader.visible = true
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)


func _on_optionen_knopf_pressed() -> void:
	change_scene_to("res://Scenes/optionen.tscn")


func _on_start_knopf_pressed() -> void:
	change_scene_to("res://Scenes/level_1.tscn")
	G.start_Title = true

func _on_exit_knopf_pressed() -> void:
	get_tree().quit()


func _on_credits_knopf_pressed() -> void:
	change_scene_to("res://Scenes/credits.tscn")
