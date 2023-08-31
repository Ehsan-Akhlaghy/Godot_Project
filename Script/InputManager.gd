
extends Node


#@onready var MyModelManager=$"../../../blackboard"
@export var MyModelManager:Input_Model_Manager
@export var myFileDialog:FileDialog
# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	print(MyModelManager.name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(MyModelManager.name)
	#GD.print(MyModelManager.name)
	
	handle_mouse()
	pass
	
func handle_mouse():
	
	if(MyModelManager.Model!=null):
		
		#if(Input.is_action_just_pressed("Rotation_Right")):
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
			#MyModelManager.MyRotation(0.1)
			MyModelManager.MyRotation(0.01,"y")
			
			#MyModelManager.check_collision_side()
			#print("Wheel up!");
		#elif(Input.is_action_just_pressed("Rotation_Left")):
		elif(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			
			#MyModelManager.MyRotation(-0.1)
			MyModelManager.MyRotation(-0.01,"y")
			
			#MyModelManager.check_collision_side()
			
			
			
			#print("Wheel down!");
		elif(Input.is_action_pressed("z_rotation_p")):
			#print("z_rotation_p")
			MyModelManager.MyRotation(0.01,"z")
			
			#MyModelManager.check_collision_side()
			
		elif(Input.is_action_pressed("z_rotation_n")):
			#print("z_rotation_n")
			MyModelManager.MyRotation(-0.01,"z")
			
			#MyModelManager.check_collision_side()
			
		if(Input.is_action_just_released("Scale_up")):
			#print("wheel up")
			#MyModelManager.DoScale(0.01)
			MyModelManager.DoScale(0.1)
			
			#MyModelManager.check_collision_side()
			
		
		elif(Input.is_action_just_released("Scale_down")): 
			#print("wheel down")
			MyModelManager.DoScale(-0.1)
			
			#MyModelManager.check_collision_side()
			
			
			#MyModelManager.decrease_pivot()
		
	if(Input.is_action_just_pressed("Esc")):
			myFileDialog.visible= true
#	if(Input.is_action_just_pressed("MoveUP")):
#		#print("wheel up")
#		MyModelManager.Move("R")
#	elif(Input.is_action_just_pressed("MoveDown")):
#		#print("wheel up")
#		MyModelManager.Move("L")
		
		
#func _input(event):
#	if(event == InputEventMouseButton):
##		if (event.is_pressed()):
##			if (event.get_indexed(BUTTON_WHEEL_UP)):
##				print("wheel up");
##			elif(event.get_indexed(BUTTON_WHEEL_DOWN)):
##				print("wheel down");
#		if(event.is_action_pressed("Rotation_Right")):
#			print("wheel up");







#eplace with function body.
