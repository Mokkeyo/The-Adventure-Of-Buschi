extends utility

func _ready() -> void:
	couldown = tempCouldown + duration
	$durationTimer.wait_time = duration

func _process(delta: float) -> void:
	if useAbility:
		dodgeRoll(delta)

func ability() -> void:
	#gets the last direction the player moved to
	velocity = get_parent().lastVelocity
	#sets the player invisible
	get_parent().grafik.visible = false
	$durationTimer.start()
	useAbility = true
	$DisabelHurtbox.disableHurtBox()
	get_parent().set_collision_mask_value(3, false)
	$HitBox/CollisionShape2D.disabled = false
	#the character gets unable to move

func dodgeRoll(delta: float) -> void:
	#checks if the DurationTimer is running (isn't stopped)
	if $durationTimer.is_stopped() == false:
		#moves the player automaticaly to the last direction you walked to
		get_parent().velocity = velocity * dodgeSpeed * delta * 100
		get_parent().move_and_slide()
	else:
		useAbility = false
		lastVelocity = Vector2(0,0)
		$DisabelHurtbox.enableHurtBox()
		get_parent().set_collision_mask_value(3,true)
		$HitBox/CollisionShape2D.disabled = true
		get_parent().grafik.visible = true
