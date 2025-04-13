extends Control
@onready var transition = $Transition
@onready var sound = $ButtonClickSfx
func _on_play_pressed() -> void:
	transition.play("fade")
	sound.play()



	


func _on_transition_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://intro_game/intro_game.tscn")
