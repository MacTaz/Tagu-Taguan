extends Area2D

@onready var local_posX = position.x
@onready var local_posY = position.y
@onready var twy = $Twy
@onready var monster = $"../../Monster/Monster"
@onready var background = $"../../background"
@onready var game_manager = $"../../GameManager"
@onready var NormalMusic = $"../../Music/NormalMusic"
@onready var VictoryMusic = $"../../Music/VictoryMusic"
@onready var ReversalMusic = $"../../Music/ReversalMusic"
@onready var InvisibilityMusic = $"../../Music/InvisibilityMusic"
@onready var VictoryOverlay = $"../../VictoryOverlay"
@onready var ProgressBars = $"../../ProgressBars"
@onready var wings =  $"../../GameManager/WingsFlapSfx"
func _on_body_entered(body: Node2D) -> void:
	wings.stop()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	ProgressBars.visible = false
	VictoryOverlay.visible = true
	ReversalMusic.stop()
	InvisibilityMusic.stop()
	NormalMusic.stop()
	turnBg_green()
	VictoryMusic.play()
	body.set_physics_process(false)
	body.set_collision_layer_value(1, false)
	body.set_collision_layer_value(2, true)
	body.visible = false
	twy.visible = true
	monster.visible = false
	for child in monster.get_children():
		if child is Timer:
			child.stop()
	monster.get_node("IdleAudio").volume_db = -100
	monster.get_node("HuntAudio").volume_db = -100
	monster.get_node("DevourAudio").volume_db = -100
	for child in game_manager.get_children():
		if child is Timer:
			child.stop()
	

func turnBg_green():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("win")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("win_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("win_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("win_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("win_4")
	
