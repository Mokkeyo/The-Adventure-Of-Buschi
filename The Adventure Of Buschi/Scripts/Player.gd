extends characterStats
class_name Player

@onready var grafik: Node2D = $Barbar
@onready var hurtbox: Node2D = $HurtBox/CollisionShape2D
@onready var collision: Node2D = $CollisionShape2D
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

@export var supAbility: ability = null
@export var utilityAbility: utility = null
@export var attackAbility1: ability = null
@export var attackAbility2: ability = null
@export var attackAbility3: ability = null
@onready var weapon: Node2D = $Attack

var Clayer: int = 5
var canMove: bool = true

var max_wut:float = 100
var wut: float
var wut_aufladung: int = 8

var input: Vector2 = Vector2.ZERO
var lastVelocity:Vector2

func _ready() -> void:
	$Attack/HitBox.connect("entered",Callable(self, "set_wut"))
	#sets the health to max_health
	wut = max_wut
	addAbility()

func set_wut() -> void:
	wut += wut_aufladung
	if wut > max_wut:
		wut = 100
	$Label.text = str(wut," / ", max_wut)

func addAbility() -> void:
	#adds the ability  to dodgeroll
	utilityAbility = load("res://Scenes/dodgeRoll.tscn").instantiate()
	attackAbility1 = load("res://Scenes/spawn_erdbruch.tscn").instantiate()
	attackAbility2 = load("res://Scenes/sichel_welle.tscn").instantiate()
	supAbility = load("res://Scenes/licht.tscn").instantiate()
	add_child(utilityAbility)
	add_child(attackAbility1)
	add_child(attackAbility2)
	add_child(supAbility)
#	weapon = load("res://Scenes/dolch.tscn").sinstantiate()
#	add_child(weapon)

func _physics_process(delta: float) -> void:
	$HpBar.setProcessBar($healthComponent.health, $healthComponent.max_health)
	$WutBar.setProcessBar(wut, max_wut)
	$Label.text = str(wut, " / ", max_wut)
	$HpLabel.text = str($healthComponent.health, " / ", $healthComponent.max_health)
	
	if velocity.x < 0:
		$Barbar.flip_h = true
	elif velocity.x > 0:
		$Barbar.flip_h = false
	
	if weapon != null:
		weapon.look_at(get_global_mouse_position())
	player_movement(delta)
	#checks if the player pressed a button
	check_key_input()
	#the default function of the charcterbody to handle the player movement
	move_and_slide()

func get_input() -> Vector2:
	if canMove == false:
		input = Vector2(0,0)
		velocity = Vector2(0,0)
		return input
	#if a player presses a button, it returns a value: 0 = false, 1 = true
	#for input.x, if  the player presses Right it is 1 - 0 = 1
	#for input.x, if  the player presses Right it is 0 - 1 = -1
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	#for input.y, if  the player presses Up it is 0 - 1 = -1
	#for input.y, if  the player presses Right it is 1 - 0 = 1
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	return input.normalized()

func player_movement(delta: float) -> void:
	if canMove == false:
		input = Vector2(0,0)
		velocity = Vector2(0,0)
		return
	
	input = get_input()
	
	#checks if the player is not pressing anything
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			#slows the character down, if its velocity didn't reache 0
			velocity -= velocity.normalized() * (friction * delta)
		else:
			#completly stops him, if its velocity reached 0
			velocity = Vector2.ZERO
	else:
		#if the Player presses in the direction, move him in that direction
		#the character speeds up until he reaches the max speed
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
		lastVelocity = input


#handels every keyInput except for the movement
func check_key_input() -> void:
	if Input.is_action_just_pressed("AttackAbility1") and $Attack1Timer.is_stopped():
		if attackAbility1 and attackAbility1.wut <= wut:
			wut -= attackAbility1.wut
			if wut < 0:
				wut = 0 
			$Label.text = str(wut," / ", max_wut)
			$Attack1Timer.start(attackAbility1.couldown)
			attackAbility1.ability()
	
	if Input.is_action_just_pressed("AttackAbility2") and $Attack2Timer.is_stopped():
		if attackAbility2 and attackAbility2.wut <= wut:
			wut -= attackAbility2.wut
			if wut < 0:
				wut = 0 
			$Label.text = str(wut," / ", max_wut)
			$Attack2Timer.start(attackAbility2.couldown)
			attackAbility2.ability()
	
	#if player pressed utlilityAbility, then the utilityTimer timer and DRCouldown timer starts
	if Input.is_action_just_pressed("UtilityAbility") and $UtilityCouldown.is_stopped():
		if utilityAbility and utilityAbility.wut <= wut:
			wut -= utilityAbility.wut
			if wut < 0:
				wut = 0 
			$Label.text = str(wut," / ", max_wut)
			$UtilityCouldown.start(utilityAbility.couldown)
			utilityAbility.ability()

	if Input.is_action_just_pressed("supportAbility") and $SupportTimer.is_stopped():
		if supAbility and supAbility.wut <= wut:
			animatedSprite.play("default")
			animatedSprite.visible = true
			if wut < 0:
				wut = 0 
			$Label.text = str(wut," / ", max_wut)
			$SupportTimer.start(supAbility.couldown)
			supAbility.ability()

	if Input.is_action_just_pressed("Attack") and $WeaponCooldown.is_stopped():
		if(weapon != null):
			$WeaponCooldown.start(weapon.attackSpeed)
			weapon.attack()

func changeHp(hp: int) -> void:
	$healthComponent.health += hp
	if $healthComponent.health > $healthComponent.max_health:
		$healthComponent.health = 100
	print($healthComponent.health)

func died() -> void:
	call_deferred("respawn")

func respawn() -> void:
	var animation_player: AnimationPlayer = $Fader.fade_in()
	await animation_player.animation_finished
	get_tree().paused = false
	get_tree().reload_current_scene()
