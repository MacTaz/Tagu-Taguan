extends Node

@onready var player = $"../Player"
@onready var monster = $"../Monster/Monster"
@onready var coolDown = $coolDown
@onready var statusEffect = $statusEffect
@onready var statusEffect_label = $"../ProgressBars/Label"
@onready var NormalMusic = $"../Music/NormalMusic"
@onready var ReversalMusic = $"../Music/ReversalMusic"
@onready var InvisibleMusic = $"../Music/InvisibilityMusic"
@onready var SpeedMusic = $"../Music/SpeedMusic"
@onready var Ghost = $"../Player/Ghost"
@onready var flickertime = $flickertime
@onready var wings = $WingsFlapSfx
var i = null

func _on_ready() -> void:
	wings.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	NormalMusic.play()
	coolDown.start()

func _process(delta: float) -> void:
	change_ghost(i)
	if NormalMusic.volume_db < 0:
		NormalMusic.volume_db += 10 * delta
		if NormalMusic.volume_db > 0:
			NormalMusic.volume_db = 0
func _on_timer_timeout() -> void:
	i = randi_range(0, 2)
	statusEffect.start()
	flickertime.start()
	change_ghost(i)

func _on_status_effect_timeout() -> void:
	Ghost.get_node("AnimatedSprite2D").play("normal")
	statusEffect_label.text = "Status Effect : Normal"
	print("Status Effect Done!")
	monster.get_node("AnimatedSprite2D").play("idle")
	player.speed = 200
	player.direction = Vector2(1, 0)
	player.move_animation = "Walk"
	player.crouch_animation = "crouch"
	player.idle_animation = "Idle"
	monster.visible = true
	InvisibleMusic.stop()
	ReversalMusic.stop()
	SpeedMusic.stop()
	NormalMusic.play()
	coolDown.start()
	player.reversed_movement = false

func change_ghost(i):
	var time_left = flickertime.time_left
	var effect = i
	if i == 0:
		effect = "invisible"
	elif i == 1:
		effect = "reverse"
	elif i == 2:
		effect = "slowed"
	if time_left <= 3.0 and time_left > 2.5:
		print("flicker (effect)")
		Ghost.get_node("AnimatedSprite2D").play(effect)
	elif time_left <= 2.5 and time_left > 2.0:
		print("flicker (normal)")
		Ghost.get_node("AnimatedSprite2D").play("normal")
	elif time_left <= 2.0 and time_left > 1.5:
		print("flicker (effect)")
		Ghost.get_node("AnimatedSprite2D").play(effect)
	elif time_left <= 1.5 and time_left > 1.0:
		print("flicker (normal)")
		Ghost.get_node("AnimatedSprite2D").play("normal")
	elif time_left <= 1.0 and time_left > 0.5:
		print("flicker (effect)")
		Ghost.get_node("AnimatedSprite2D").play(effect)
	elif time_left <= 0.5 and time_left > 0.0:
		print("flicker (normal)")
		Ghost.get_node("AnimatedSprite2D").play("normal")

func _on_flickertime_timeout() -> void:
	NormalMusic.stop()
	if i == 0: # Invisible Monster
		monster.visible = false
		Ghost.get_node("AnimatedSprite2D").play("invisible")
		InvisibleMusic.play()
		statusEffect_label.text = "Status Effect : Invisible"  
		print("Status Effect Applied! (Invisible)")
		
	elif i == 1: # Reversed Movement
		Ghost.get_node("AnimatedSprite2D").play("reverse")
		ReversalMusic.play()
		statusEffect_label.text = "Status Effect : Reverse"  
		print("Status Effect Applied! (Reverse)")
		player.move_animation = "WalkBack"
		player.reversed_movement = true
		player.direction = Vector2(-1, 0)
		player.move_animation = "WalkBack"
		player.crouch_animation = "crouchBack"
		player.idle_animation = "WalkBack"
		
	elif i == 2: # Slowed Movement
		Ghost.get_node("AnimatedSprite2D").play("slowed")
		SpeedMusic.play()
		statusEffect_label.text = "Status Effect : Slowed"  
		print("Status Effect Applied! (Slowed)")
		player.speed = 150
