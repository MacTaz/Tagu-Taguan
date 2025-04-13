extends Button
@onready var button_click = $"../../Sounds/ButtonClickSfx"



func _on_pressed() -> void:
	button_click.play()
	get_tree().quit()
