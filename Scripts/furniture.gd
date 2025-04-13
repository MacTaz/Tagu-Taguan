extends Area2D

@onready var sprite = $AnimatedSprite2D
var player_inside = false
var player_ref : Node2D = null

func _process(delta: float) -> void:
	if player_inside and player_ref:
		if Input.is_action_pressed("down"):
			sprite.play("hide")
			player_ref.visible = false
		else:
			sprite.play("Idle")
			player_ref.visible = true
		
func _on_body_entered(body: Node2D) -> void:
	player_inside = true
	player_ref = body

func _on_body_exited(body: Node2D) -> void:
	player_inside = false
