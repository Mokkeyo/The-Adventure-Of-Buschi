extends utility

var defaultMax_speed: int
var defaultAccel: int
var defaultFriction: int

func _ready() -> void:
	couldown = tempCouldown + duration
	$durationTimer.wait_time = duration

func ability() -> void:
	$durationTimer.start()
	useAbility = true
	defaultMax_speed = get_parent().max_speed
	defaultAccel = get_parent().accel
	defaultFriction = get_parent().friction
	
	get_parent().max_speed = 900
	get_parent().accel = 8000
	get_parent().friction = 8000

func _on_duration_timer_timeout() -> void:
	get_parent().max_speed = defaultMax_speed
	get_parent().accel = defaultAccel
	get_parent().friction = defaultFriction
	useAbility = false
