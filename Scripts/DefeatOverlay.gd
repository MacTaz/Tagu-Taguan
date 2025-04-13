extends CanvasLayer
@onready var sound = $ButtonRevised


func _on_restart_pressed() -> void:
	sound.play()
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	sound.play()
	get_tree().change_scene_to_file("res://main_menu.tscn")
