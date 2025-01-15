extends ability

var charging: bool = false
@export var health: int 

func _ready() -> void:
	couldown = tempCouldown + duration


func _process(_delta: float) -> void:
	if charging and Input.is_action_just_released("supportAbility") and $durationTimer.is_stopped() == false:
		get_parent().animatedSprite.stop()
		get_parent().animatedSprite.visible = false
		charging = false
		$durationTimer.stop()
		get_parent().canMove = true
	if get_parent().canMove:
		charging = false
		$durationTimer.stop()

func ability() -> void:
	get_parent().canMove = false
	charging = true
	$durationTimer.start(duration)


func _on_duration_timer_timeout() -> void:
	get_parent().animatedSprite.stop()
	get_parent().animatedSprite.visible = false
	get_parent().changeHp(health)
	get_parent().wut -= wut
	charging = false
	get_parent().canMove = true
