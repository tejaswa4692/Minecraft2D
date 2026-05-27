extends Node2D

var block_type = 0
var inventory = {0: 0 , 1: 0, 2:0, 3:0}

func _on_Button_pressed():
		block_type = 0
		print('stump')

func _ready():
	$textbox.hide()
	$textbox2.hide()

func _process(delta):
	
	if Input.is_action_just_released("mouse"):
		var cell = $tree.world_to_map(get_global_mouse_position())
		if $tree.get_cellv(cell) != -1:
			inventory[$tree.get_cellv(cell)] += 1
		$tree.set_cellv(cell, -1)
		print(inventory)
		if block_type == 0:
			$Steve/Control/stumplabel.set_text(str(inventory[0]))
			$Steve/Control/stumplabel.update()
		elif block_type == 1:
			$Steve/Control/leaves.set_text(str(inventory[1]))
			$Steve/Control/leaves.update()
		
		
	if Input.is_action_just_pressed(" rit") :
		if $tree.get_cellv($tree.world_to_map(get_global_mouse_position())) == -1:
			if inventory[block_type] > 0:
				var cell = $tree.world_to_map(get_global_mouse_position())
				$tree.set_cellv(cell, block_type)
				inventory[block_type] -= 1
				print(inventory)
				if block_type == 0:
					$Steve/Control/stumplabel.set_text(str(inventory[0]))
					$Steve/Control/stumplabel.update()
				elif block_type == 1:
					$Steve/Control/leaves.set_text(str(inventory[1]))
					$Steve/Control/leaves.update()




func _on_Button2_pressed():
	block_type = 1
	print('leave')


func _on_Area2D_mouse_entered():
	$textbox.show()


func _on_Area2D_mouse_exited():
	$textbox.hide()


func _on_blox_mouse_entered():
	$textbox2.show()


func _on_blox_mouse_exited():
	$textbox2.hide()


func _on_Button3_pressed():
	if inventory[0] >= 1:
		inventory[0] -= 1
		inventory[3] += 4
	 


func _on_planks_pressed():
	block_type = 3
