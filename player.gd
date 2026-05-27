extends KinematicBody2D

var direc = Vector2()
const accel = 10
var move: Vector2 = Vector2()
var speed = 100
onready var camera = $Camera2D
var campos
export var shakestr = 0.5
var bullet = preload("res://nade.tscn")
var mousein = false
var mousepos

func _physics_process(delta):
	sprint()
	#camshake()
	
	if Input.is_action_just_pressed("click") and mousein:
		mousepos = get_global_mouse_position()
		global_position = mousepos
		if Input.is_action_just_released("click"):
			$AnimationPlayer.play("New Anim")
	
	
	
	
	direc = Vector2()
	
	if $rolltime.is_stopped():
		direc.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direc.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#print(Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up"))
	
	move.x = lerp(move.x  , direc.x ,0.1)
	move.y = lerp(move.y , direc.y , 0.1)
	
	move_and_slide(move * speed)
	
#	if Input.is_action_just_pressed("v"):
#		fire()
	
	$Node2D.look_at(get_global_mouse_position())

func sprint():
	if Input.is_action_pressed("space"):
		speed = lerp(speed, 200, 0.3)
	else:
		speed = lerp(speed, 100, 0.5)


func camshake():
	campos = Vector2()
	campos.x = rand_range(shakestr, -shakestr)
	campos.y = rand_range(shakestr, -shakestr)
	camera.offset_h = campos.x
	camera.offset_v = campos.y

	$rolltime.start()
	var keys = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	while !$rolltime.is_stopped():
		direc = keys * 100

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $Node2D/Position2D.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(500,0).rotated($Node2D.rotation))
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	
func _on_Area2D_mouse_entered():
	mousein = true

func _on_Area2D_mouse_exited():
	mousein = false
