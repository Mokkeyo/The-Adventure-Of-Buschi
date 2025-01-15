extends Node2D

var canUnpause: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Einstellungen/MusikSlider.value = int(G.music_db * 100)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		$Einstellungen/Fullscreen.button_pressed = true
	else:
		$Einstellungen/Fullscreen.button_pressed = false
	$Einstellungen/MusikValue.text = str("Music: ", $Einstellungen/MusikSlider.value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause") and get_tree().paused == true and canUnpause:
		canUnpause = false
		get_tree().paused = false
		visible = false
	
	$Einstellungen/MusikValue.text = str("Music: ", $Einstellungen/MusikSlider.value)


func _on_einstellung_button_pressed() -> void:
	$Menu.visible = false
	$Einstellungen.visible = true
	


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_zurück_knopf_pressed() -> void:
	$Einstellungen.visible = false
	$Menu.visible = true


func _on_beenden_button_pressed() -> void:
	get_tree().paused = false
	canUnpause = false
	var animation_player: AnimationPlayer = $Fader.fade_in()
	$Fader.visible = true
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/titlescreen.tscn")
	



func _on_controls_button_pressed() -> void:
	$Einstellungen.visible = false
	$Steuerung.visible = true
	



func _on_zurück_knopf_2_pressed() -> void:
	$Einstellungen.visible = true
	$Steuerung.visible = false


func _on_fortsetzen_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	canUnpause = false


func _on_musik_slider_value_changed(value: float) -> void:
	G.changeVolume($Einstellungen/MusikSlider.value)
