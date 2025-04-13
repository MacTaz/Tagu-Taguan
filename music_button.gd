extends TextureButton
@onready var sound = $"../ButtonClickSfx"
var music_bus = AudioServer.get_bus_index("Music")
@onready var music = "../AudioStreamPlayer"


func _on_pressed() -> void:
	sound.play()
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
