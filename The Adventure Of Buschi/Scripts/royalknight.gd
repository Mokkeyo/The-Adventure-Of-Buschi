extends characterStats

@onready var closeArea: Area2D = $DetectionArea3
@onready var area: Area2D = $DetectionArea
@onready var attackArea: Area2D = $DetectionArea2
@onready var buffTimer: Timer = $Timer
var rotationSpeed: int = 5

@export var layer: int
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Node2D = null

func _ready() -> void:
	set_collision_mask_value(layer, true)
	set_collision_layer_value(layer, true)
	area.set_collision_mask_value(layer, true)
	attackArea.set_collision_mask_value(layer, true)
	closeArea.set_collision_mask_value(layer, true)
	
	
func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = false
	elif velocity.x > 0:
		animated_sprite.flip_h = true
	
	
	if buffTimer.is_stopped():
		$AnimatedSprite2D2.visible = false
		attackPower = 1
		defense = 1
	
	var attack: Array[Node2D] = [$SwingAttack, $PointAttack]
	if attackArea.character and $Cooldown.is_stopped():
		var rng: RandomNumberGenerator = RandomNumberGenerator.new()
		var i: int = rng.randf_range(0, 2)
		$Cooldown.start(attack[i].attackSpeed)
		attack[i].attack()

	if area.character:
		#Handels the Attacks
		for i: int in range(0, attack.size()):
			var v: Vector2 = area.character.global_position - attack[i].global_position
			attack[i].rotation = lerp_angle(attack[i].global_rotation, v.normalized().angle(), 0.3)
			$Marker2D.rotation = lerp_angle($Marker2D.global_rotation, v.normalized().angle(), 0.3)
			if area.character.global_position.y > global_position.y:
				move_child($Marker2D, 2)
			else:
				move_child($Marker2D, 0)
				
		if closeArea.character == null:
			$MoveToPlayer.moveToPlayer(delta)
		else:
			$MoveToPlayer.stopMoving(delta)
	else:
		$MoveToPlayer.stopMoving(delta)
	move_and_slide()

func buff() -> void:
	$AnimatedSprite2D.play("new_animation")
	$AnimatedSprite2D2.visible = true

func died() -> void:
	queue_free()
