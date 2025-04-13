extends Area2D

@onready var sprite = $AnimatedSprite2D
@onready var death_timer = $death_timer
@onready var collision_shape = $CollisionShape2D
@onready var attack_cooldown = $attack_cooldown
@onready var attack_time = $attack_time
@onready var animation = $AnimationPlayer
@onready var background = $"../../background"
@onready var NormalMusic = $"../../Music/NormalMusic"
@onready var DefeatMusic = $"../../Music/DefeatMusic"
@onready var InvisibilityMusic = $"../../Music/InvisibilityMusic"
@onready var ReversalMusic = $"../../Music/ReversalMusic"
@onready var SpeedMusic = $"../../Music/SpeedMusic"
@onready var DefeatOverlay = $"../../DefeatOverlay"
@onready var ProgressBars = $"../../ProgressBars"
@onready var GameManager = $"../../GameManager"
@onready var DevourAudio = $DevourAudio
@onready var HuntAudio = $HuntAudio
@onready var IdleAudio = $IdleAudio

func _ready() -> void:
	IdleAudio.play()
	collision_shape.disabled = true
	start_attack_cooldown()
	
func _process(delta: float) -> void:
	var time_left = attack_cooldown.time_left
	
	if time_left <= 3.0 and time_left > 2.5:
		IdleAudio.stop()
		HuntAudio.play()
		turnBg_red()
	elif time_left <= 2.5 and time_left > 2.0:
		turnBg_normal()
	elif time_left <= 2.0 and time_left > 1.5:
		turnBg_red()
	elif time_left <= 1.5 and time_left > 1.0:
		turnBg_normal()
	elif time_left <= 1.0 and time_left > 0.5:
		turnBg_red()
	elif time_left <= 0.5 and time_left > 0.0:
		turnBg_normal()

func start_attack_cooldown():
	print("attack cooldown started")
	var rand_time = randi_range(7, 10)
	attack_cooldown.start(rand_time)

func _on_body_entered(body: Node2D) -> void:
	visible = true
	GameManager.set_process(false)
	for child in GameManager.get_children():
		if child is Timer:
			child.stop()
	ProgressBars.visible = false
	if body.name != "Player":
		return
	ReversalMusic.stop()
	InvisibilityMusic.stop()
	SpeedMusic.stop()
	NormalMusic.stop()
	turnBg_white()
	animation.pause()
	HuntAudio.stop()
	IdleAudio.stop()
	DevourAudio.play()
	sprite.play("devour")
	print("you died!")
	death_timer.start()
	body.set_physics_process(false)
	body.get_node("AnimatedSprite2D").play("death")
	flip_back()
	set_process(false)
	for child in get_children():
		if child is Timer:
			child.stop()
	death_timer.start()

func _on_death_timer_timeout() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	DefeatMusic.play()
	DefeatOverlay.visible = true
	for child in get_children():
		if child is Timer:
			child.stop()

func _on_attack_cooldown_timeout() -> void:
	print("attack cooldown ended")
	attack_time.start()
	turnBg_red()
	sprite.play("attack")
	print("Trap activated!")
	collision_shape.disabled = false
	
	
func _on_attack_time_timeout() -> void:
	IdleAudio.play()
	turnBg_normal()
	print("Trap deactivated")
	collision_shape.disabled = true
	sprite.play("idle")
	start_attack_cooldown()
	
func flip_sprite():
	sprite.flip_h = true

func flip_back():
	sprite.flip_h = false

func turnBg_red():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("hunt")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("hunt_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("hunt_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("hunt_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("hunt_4")

func turnBg_normal():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("normal")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("normal_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("normal_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("normal_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("normal_4")

func turnBg_white():
	background.get_node("ParallaxBackground/Layer1/AnimatedSprite2D").play("death")
	background.get_node("ParallaxBackground/Layer2/AnimatedSprite2D").play("death_1")
	background.get_node("ParallaxBackground/Layer3/AnimatedSprite2D").play("death_2")
	background.get_node("ParallaxBackground/Layer4/AnimatedSprite2D").play("death_3")
	background.get_node("ParallaxBackground/Layer5/AnimatedSprite2D").play("death_4")
