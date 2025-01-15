extends characterStats

#Der Schwere Ritter 

@onready var buffTimer: Area2D = $Timer
@onready var area: Area2D = $DetectionArea
@onready var attackArea: Area2D = $AttackArea
@onready var closeArea: Area2D = $CloseArea

var health: int = 180
var damage: int = 15 
var isDashing: bool = false
var dashVelocity: Vector2
@export var dashSpeed: int = 300
@export var layer: int

func _ready() -> void:
	set_collision_mask_value(layer, true)

func _physics_process(delta: float) -> void:
	if buffTimer.is_stopped():
		attackPower = 1
		defense = 1

	if area.character:
		if $Timer.is_stopped() and isDashing == false:
			$Timer.start()
			if attackArea.character == null:
				dash(delta)
			else:
				closeAttack()
		if isDashing == false:
			var v: Vector2 = area.character.global_position - $Node2D.global_position
			$Node2D.rotation = lerp_angle($Node2D.global_rotation, v.normalized().angle(), 0.3)
			if $CloseArea.character == null:
				$MoveToPlayer.moveToPlayer(delta)
			else:
				$MoveToPlayer.stopMoving(delta)
		else:
			$Node2D/HitBox/CollisionShape2D.disabled = false
			$MoveToPlayer.stopMoving(delta)
			if is_on_wall() or closeArea.character or is_on_ceiling() or is_on_floor():
				$Timer.start()
				isDashing = false
				$Node2D/HitBox/CollisionShape2D.disabled = true
	else:
		$MoveToPlayer.stopMoving(delta)
	move_and_slide()

func dash(delta: float) -> void:
	var v: Vector2 = area.character.global_position - $Node2D.global_position
	$Node2D.rotation = lerp_angle($Node2D.global_rotation, v.normalized().angle(), 0.3)
	isDashing = true
	dashVelocity = (area.character.position - position)
	dashVelocity += (position.direction_to($Node2D.position) * accel * delta)
	dashVelocity = velocity.limit_length(dashSpeed)

func died() -> void:
	queue_free()

func closeAttack() -> void:
	$Node2D/HitBox/CollisionShape2D.disabled = false
	$durationTimer.start(0.5)


func _on_duration_timer_timeout() -> void:
	$Node2D/HitBox/CollisionShape2D.disabled = true
