extends Area2D
@onready var background = $"../../background"
@onready var timer = $Timer2
@onready var tilemap = $"../../TileMap2"
@onready var player = $"../../Player"
@onready var hunt_sound = $EnemyHunt
func _on_body_entered(body: Node2D) -> void:
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("normal")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("normal_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("normal_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("normal_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("normal_4")
	tilemap.visible = true
	timer.start()
	body.set_physics_process(false)
	player.get_node("AnimatedSprite2D").play("Idle")
	hunt_sound.play()
	
	
func turnBg_normal():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("normal")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("normal_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("normal_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("normal_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("normal_4")

func turnBg_orange():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("intro")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("intro_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("intro_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("intro_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("intro_4")


	


func _on_timer_2_timeout() -> void:
	turnBg_orange()
	tilemap.visible = false
	player.set_physics_process(true)
