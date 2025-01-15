extends characterStats

@onready var area: Area2D = $DetectionArea
@onready var closeArea: Area2D = $closeArea
@export var layer: int
@onready var buffTimer: Timer = $Timer

func _ready() -> void:
	set_collision_mask_value(layer, true)
	set_collision_layer_value(layer, true)
	area.set_collision_mask_value(layer, true)
	closeArea.set_collision_mask_value(layer, true)


func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		$Icon.flip_h = true
	elif velocity.x > 0:
		$Icon.flip_h = false
	
	
	if buffTimer.is_stopped():
		$AnimatedSprite2D.visible = false
		attackPower = 1
		defense = 1
	
	
	if area.character:
		if closeArea.character == null:
			$MoveToPlayer.moveToPlayer(delta)
		else:
			$MoveToPlayer.stopMoving(delta)
	else:
		$MoveToPlayer.stopMoving(delta)

	move_and_slide()

func died() -> void:
	queue_free()

func buff() -> void:
	$AnimatedSprite2D.play("new_animation")
	$AnimatedSprite2D.visible = true
