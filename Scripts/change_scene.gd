extends Area2D
@onready var timer = $AnimationTimer
@onready var animation = $AnimatedSprite2D/AnimationPlayer
@onready var audio = $AudioStreamPlayer
@onready var background = $"../background"
@onready var audiobirds = $"../PlaySound/AudioStreamPlayer"
@onready var tilemap = $"../TileMap2"
@onready var wings = $WingsFlapSfx
func _on_body_entered(body: Node2D) -> void:
	wings.play()
	audio.play()
	animation.play("move")
	body.set_physics_process(false)
	body.get_node("AnimatedSprite2D").play("Idle")
	audiobirds.stop()
	
func change_scene():
	get_tree().change_scene_to_file("res://game.tscn")

func turnBg_normal():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("normal")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("normal_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("normal_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("normal_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("normal_4")

func tilemap_visible():
	tilemap.visible = true

func wings_flap():
	wings.play()
