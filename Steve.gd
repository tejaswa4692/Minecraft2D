extends KinematicBody2D

var speed = 30
var direction = Vector2()
var move: Vector2 = Vector2()
var is_in: bool = false


func _physics_process(_delta):
	if !$RayCast2D.is_colliding():
		move.y += 0.1
		move.y = clamp(move.y, -4 , 6)
	elif $RayCast2D.is_colliding():
		move.y = 0
	
	
	direction.x = Input.get_action_strength("d") - Input.get_action_strength("a")
	
	move.x = lerp(move.x  , direction.x ,0.1)
	
	if Input.is_action_pressed("a"):
		$Sprite.flip_h = true
	if Input.is_action_pressed("d"):
		$Sprite.flip_h = false
	
	
#	if Input.is_action_just_pressed("a") or Input.is_action_just_pressed("d"):
#		$sound.play("walksound")
#	else:
#		$sound.stop()
#
		
	
	
	if Input.is_action_pressed("a") or Input.is_action_pressed("d"):
		$AnimationPlayer.play("walk")
		
	elif Input.is_action_just_released("a") or Input.is_action_just_released("d"):
		$AnimationPlayer.stop()
		$Sprite.frame = 0
	
	if Input.is_action_just_pressed("space") and $RayCast2D.is_colliding():
		move.y = -2.7
	
	
	move_and_slide(move * speed) 
