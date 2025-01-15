extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MusikSlider.value = int(G.music_db * 100)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		$FullscreenButton.button_pressed = true
	else:
		$FullscreenButton.button_pressed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$MusikValue.text = str("Music: ", $MusikSlider.value)
	$SoundValue.text = str("Sound: ", $SoundSlider.value)

func change_scene_to(scene: String) -> void:
	var animation_player: AnimationPlayer = $Fader.fade_in()
	$Fader.visible = true
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_file(scene)

func _on_zurück_knopf_pressed() -> void:
	change_scene_to("res://Scenes/titlescreen.tscn")



func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	


func _on_controls_button_pressed() -> void:
	change_scene_to("res://Scenes/controls.tscn")


func _on_musik_slider_value_changed(value: float) -> void:
	G.changeVolume($MusikSlider.value)
