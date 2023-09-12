
extends Node
class_name  mycontroller


@onready var MyModelManager:Input_Model_Manager =get_node("..")



func _physics_process(delta):
	handle_mouse()
	pass
#handing mouse and keyboard event 	
func handle_mouse():
	
	if(MyModelManager.Model!=null):
		
		
		if(Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
		
			MyModelManager.MyRotation(0.01,"y")
		
		
		elif(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
			
		
			MyModelManager.MyRotation(-0.01,"y")
			
			
		elif(Input.is_action_pressed("z_rotation_p")):
			MyModelManager.MyRotation(0.01,"z")
			
		elif(Input.is_action_pressed("z_rotation_n")):

			MyModelManager.MyRotation(-0.01,"z")

			
		if(Input.is_action_just_released("Scale_up")):

			MyModelManager.DoScale(0.1)
			

		
		elif(Input.is_action_just_released("Scale_down")): 

			MyModelManager.DoScale(-0.1)
			

			MyModelManager.can_rotate_y =true
			MyModelManager.can_rotate_z =true
			

			
		
	#if(Input.is_action_just_pressed("Esc")):
	#		myFileDialog.visible= true


