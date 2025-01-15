extends characterStats
class_name golem

signal fall

var b: Node2D
var ball: PackedScene = preload("res://Scenes/air_ball.tscn")
var attacking: bool = false
@onready var area: Area2D = $DetectionArea
@onready var closeArea: Area2D = $CloseArea
@onready var movementComponent: Node2D = $MoveToPlayer
@onready var attackArea: Area2D = $AttackArea
@onready var timer: Timer = $AttackTimer
var playerEntred: bool = false
var music: String = "res://music/BossMusic.mp3"

func _physics_process(delta: float) -> void:
	$CanvasLayer/TextureRect.setProcessBar($healthComponent.health, $healthComponent.max_health)
	
	if timer.is_stopped():
		timer.start(3)
		attacking = true
		var rng: RandomNumberGenerator = RandomNumberGenerator.new()
		var number: int = rng.randi_range(1, 5)
		if attackArea.character:
			if number < 2:
				attack()
			else:
				fallingSpikes()
		else:
			if number < 2:
				throwRock()
			else:
				fallingSpikes()
	
	if attacking:
		movementComponent.stopMoving(delta)
		return

	if attackArea.character:
		$Marker2D.look_at(attackArea.character.global_position)

	if area.character:
		if playerEntred == false:
			G.start_music(music)
			$CanvasLayer/TextureRect.visible = true
			playerEntred = true
		var v: Vector2 = area.character.global_position - $Node2D.global_position
		$Node2D.rotation = lerp_angle($Node2D.global_rotation, v.normalized().angle(), 0.3)
		if closeArea.character == null:
			movementComponent.moveToPlayer(delta)
		else:
			movementComponent.stopMoving(delta)
	else:
		movementComponent.stopMoving(delta)
	
	move_and_slide()

func attack() -> void:
	$Node2D/AttackAnimation.visible = true
	$Node2D/AttackAnimation.play("Attack")
	$Node2D/HitBox/CollisionShape2D.disabled = true
	$AttackDurtion.start(0.5)

func fallingSpikes() -> void:
	$AttackDurtion.start(2)
	emit_signal("fall")

func died() -> void:
	call_deferred("load_end")

func load_end() -> void:
	get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")

func throwRock() -> void:
	$AttackDurtion.start(2)
	b = ball.instantiate()
	b.global_position = global_position
	b.rotation = $Marker2D.rotation
	get_parent().call_deferred("add_child", b)

func _on_attack_durtion_timeout() -> void:
	$Node2D/HitBox/CollisionShape2D.disabled = false
	$Node2D/AttackAnimation.visible = false
	$Node2D/AttackAnimation.stop()
	attacking = false
