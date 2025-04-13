extends Area2D
@onready var sound = $AudioStreamPlayer



func _on_body_entered(body: Node2D) -> void:
	sound.play()
