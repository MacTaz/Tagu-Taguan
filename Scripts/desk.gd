extends Area2D

@onready var sprite = $AnimatedSprite2D
var player_inside = false
var player_sprite : AnimatedSprite2D = null
@onready var crouch_sound = $CrouchSfx
func _process(delta: float) -> void:
	if player_inside and player_sprite:
		var player = player_sprite.get_parent()
		if Input.is_action_pressed("down"):
			player.char_hidden = true
			sprite.play("hide")
			player_sprite.visible = false
			player.set_collision_layer_value(1, false)
			player.set_collision_layer_value(2, true)
		else:
			sprite.play("Idle")
			player_sprite.visible = true
			player.set_collision_layer_value(1, true)
			player.set_collision_layer_value(2, true)
		if Input.is_action_just_released("down"):
			player.char_hidden = false
		
func _on_body_entered(body: Node2D) -> void:
	player_inside = true
	player_sprite = body.get_node("AnimatedSprite2D")
	
func _on_body_exited(body: Node2D) -> void:
	player_inside = false
	
