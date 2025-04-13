extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var progress_bar = $"../ProgressBars/Distance_Progress"
@onready var bed = $"../Furnitures/Bed"
@onready var timer = $CrouchTimer
@onready var crouch_bar = $"../ProgressBars/Crouch_Timer"
@onready var cooldown_timer = $CrouchCooldown

var char_hidden: bool = false
var speed : float = 200
var direction : Vector2 = Vector2(1, 0)
var start_position: Vector2
var target_position: Vector2
var distance: float = 0
var travel: float = 0
var can_crouch: bool = true
var standing: bool = true

var stamina := 150.0
var max_stamina := 150.0
var stamina_deplete_rate := 25.0  
var stamina_regen_rate := 25
var is_crouching := false

var crouch_animation := "crouch"
var idle_animation := "Idle"
var move_animation := "Walk"

func _ready():
	start_position = position
	distance = start_position.distance_to(target_position)
	
func _physics_process(delta):
	if Input.is_action_just_pressed("down") and stamina > 0:
		is_crouching = true
	if Input.is_action_pressed("down") and stamina > 0:
		if char_hidden == false:
			stamina -= stamina_deplete_rate * delta
			set_collision_layer_value(1, false)
	else:
		is_crouching = false
		stamina += stamina_regen_rate * delta
		set_collision_layer_value(1, true)
	
	if Input.is_action_pressed("up") and sprite.visible == true and not is_crouching:
		velocity = direction * speed
		move_and_slide()
		sprite.play(move_animation)
	elif is_crouching:
		sprite.play(crouch_animation)
	else:
		sprite.play(idle_animation)	
		
	
	
	stamina = clamp(stamina, 0, max_stamina)
	
		
	travel = start_position.distance_to(position)
	if position.distance_to(target_position) < 33:
		progress_bar.value = progress_bar.max_value
