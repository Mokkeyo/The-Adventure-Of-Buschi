extends Node2D


var musicPlayer: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
var music_db: float = 1
var sound_db: float = 1
var start_Title: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	add_child(musicPlayer)


func start_music(music: String) -> void:
	musicPlayer.stream = load(music)
	musicPlayer.play()

func changeVolume(volume: float) -> void:
	music_db = linear_to_db(volume)
	musicPlayer.volume_db = float(music_db / 100)

func changeSound(_volume: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
