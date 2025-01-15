extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Golem: Node2D = get_node("../Golem")
	Golem.connect("fall", Callable(self, "falling"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func falling() -> void:
	$AnimationPlayer.play("falling")

func _on_animation_player_animation_finished(_anim_name: String) -> void:
	$HitBox.position.y = 0
	$HitBox/CollisionShape2D.disabled = true
