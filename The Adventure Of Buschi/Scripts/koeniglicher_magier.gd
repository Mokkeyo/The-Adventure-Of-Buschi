extends characterStats

var b: Node2D
var ball: PackedScene = preload("res://Scenes/air_ball.tscn")

@onready var area: Area2D = $DetectionArea
@onready var attackArea: Area2D = $DetectionArea2
@onready var teamArea: Area2D = $TeamBuffArea
@onready var buffTimer: Timer = $Timer
@export var buffDauer: int
@export var layer: int

func _ready() -> void:
	set_collision_mask_value(layer, true)
	set_collision_layer_value(layer, true)
	area.set_collision_mask_value(layer, true)
	attackArea.set_collision_mask_value(layer, true)

func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		$Barbar.flip_h = true
	elif velocity.x > 0:
		$Barbar.flip_h = false
	
	
	if buffTimer.is_stopped():
		$AnimatedSprite2D.visible = false
		attackPower = 1
		defense = 1

	if attackArea.character:
		$Marker2D.look_at(attackArea.character.global_position)

		if $Timer.is_stopped():
			var rng: RandomNumberGenerator = RandomNumberGenerator.new()
			var number: int = rng.randi_range(1, 5)
			#var number = 1
			var list: int = 0
			$Timer.start()
			if number > 2:
				for body: Node2D in teamArea.get_overlapping_bodies():
					if body.is_in_group("Enemy") and body.attackPower == 1:
						list += 1
				if list > 0:
					boostAllys()
				else:
					summonAir()
			else:
				summonAir()
	
	if area.character:
		$MoveToPlayer.moveAway(delta)
	else:
		$MoveToPlayer.stopMoving(delta)
	move_and_slide()

func boostAllys() -> void:
	for body: Node2D in teamArea.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			if body.has_method("buff"):
				body.buff()
				body.buffTimer.start(buffDauer)
				body.attackPower = 1.15

func died() -> void:
	queue_free()

func summonAir() -> void:
	b = ball.instantiate()
	b.global_position = global_position
	b.rotation = $Marker2D.rotation
	get_parent().call_deferred("add_child", b)
