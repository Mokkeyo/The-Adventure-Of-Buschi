extends ability

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	couldown = tempCouldown + duration

func ability() -> void:
	$HitBox/CollisionShape2D.disabled = false
	$Timer.start(duration)


func _on_timer_timeout() -> void:
	$HitBox/CollisionShape2D.disabled = true
