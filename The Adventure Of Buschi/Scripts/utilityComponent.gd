extends Node
class_name utility

@export var duration: float = 0.3
@export var tempCouldown: float = 1
@export var dodgeSpeed: float = 500
@export var wut: int = 0

var velocity: Vector2
var couldown: float
var lastVelocity: Vector2
var useAbility: bool = false

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func ability() -> void:
	pass

func dodgeRoll(_delta: float) -> void:
	pass
