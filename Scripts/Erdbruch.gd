extends ability

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("beeben")
	$durationTimer.start(duration)
	$PausebetweenAttack.start(0.2)

func _on_duration_timer_timeout() -> void:
	queue_free()


func _on_pausebetween_attack_timeout() -> void:
	change_hitbox()

func change_hitbox() -> void:
	if $HitBox/CollisionShape2D.disabled == true:
		$HitBox/CollisionShape2D.disabled = false
	else:
		$HitBox/CollisionShape2D.disabled = true
	$PausebetweenAttack.start(0.2)
