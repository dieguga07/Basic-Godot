extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -310.0

var attack_throw = false #varibale que controla el estado del ataque
var attack_animation_duration = 0.5 #tiempo qeu se tarda en hacer la animacion
var attack_timer = 0.0 #temporizador del ataque al que le restaremos el delta

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		$BasicPlayerAnimation.play("run")
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_released("basic_attack") and not attack_throw:
		attack_throw = true
		attack_timer = attack_animation_duration
		print("se ataco")
		$BasicPlayerAnimation.play("attack")
		
	if attack_throw:
		attack_timer -= delta
		if attack_timer <= 0:
			attack_throw = false
			
			
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0 :
		$BasicPlayerAnimation.flip_h = direction < 0
		if (attack_throw != true):
			$BasicPlayerAnimation.play("run")
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if (attack_throw != true):
			$BasicPlayerAnimation.play("idle")

	move_and_slide()
