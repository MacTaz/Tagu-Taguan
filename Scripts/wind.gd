extends Area2D

@onready var wind =$WindBgSfx

func _on_body_entered(body: Node2D) -> void:
	wind.play()
