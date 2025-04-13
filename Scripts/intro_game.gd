extends Node2D
@onready var transition = $Transition
@onready var audio = $PlaySound/AudioStreamPlayer/AnimationPlayer
@onready var MUSIC = $"In-gameThemeHungryWings"

func _on_ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	transition.play("fade_out")

func playmusic():
	MUSIC.volume_db = -80
	MUSIC.play()
	var tween = create_tween()
	tween.tween_property(MUSIC, "volume_db", 0, 5.68)
	
