extends Button
@onready var button_click = $"../../ButtonClickSfx"



func _on_pressed() -> void:
	button_click.play()
	get_tree().quit()
