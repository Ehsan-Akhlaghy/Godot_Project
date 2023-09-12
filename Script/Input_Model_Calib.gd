#@tool
extends Node
class_name  Input_Model_Manager

var Model
var MyScale:Vector3
var MaxScale:float = 100

var myshape

var my_char_body:CharacterBody3D

var new_node:Node3D =  Node3D.new()

var  my_collision_3dmodel: CollisionShape3D


var can_rotate_y:bool = true
var can_rotate_z:bool = true


var offset_wall:Vector3

var velocity_char:Vector3 = Vector3(0,-9.8,0)

var controller:mycontroller
var myfilemanager:MyFileManager

var path_asset_glb:String
var desk_path:String
var asset_pos:Vector3
var desk_pos:Vector3
var standard_size:Vector3

#constructor of class 
func myconstructor(_path_asset_glb:String,_desk_path:String,_desk_pos:Vector3,_asset_pos:Vector3,_standard_size:Vector3):
	
	path_asset_glb = _path_asset_glb
	desk_path = _desk_path
	asset_pos = _asset_pos	
	standard_size = _standard_size
	desk_pos = _desk_pos
	create_controller()
	create_file()


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("create_desk",desk_path)
	MaxScale = 100
	pass



#check in each physics frame collision happened 
func _physics_process(delta):
	if(my_char_body!=null):
		check_collision_side(delta)

#formulation (feature_unit/current_unit) * current_size = Desired_size 
#we have a standard size which defined in constructor,
#this method find size of meshes and scale it.
func calib_size():
	
	Init_Model()
	
	my_char_body.get_child(0).add_child(new_node)
	
	var center = find_center_mesh_master_per_vertex(Model)

	change_pivot(new_node,center)
	MyReparent(Model,new_node)
	
	new_node.scale = find_desired_size_3(Model)

	change_pivot(my_char_body,center)
	
	my_char_body.global_position = Vector3.ZERO
	
	my_char_body.global_position = asset_pos
	
	my_collision_3dmodel.shape.size = find_size_mesh_master_per_vertex(Model)
	
	pass

#change mynode position to center(for new pivoting)
func change_pivot(mynode:Node3D,center:Vector3):
	
	if(new_node.position.length()!=0):
		new_node.position = Vector3.ZERO
		

	mynode.global_position= center
	
	
	pass


#create hieracrchy of charbody for 3dmodel
func create_Marker3d():	
	my_char_body = CharacterBody3D.new()
	
	my_collision_3dmodel= CollisionShape3D.new()
	myshape = BoxShape3D.new()
	my_collision_3dmodel.shape =myshape
	

	my_collision_3dmodel.shape.size=find_size_mesh_master_per_vertex(Model)
	
	get_parent().add_child(my_char_body)
	
	my_char_body.add_child(my_collision_3dmodel)
	



#rotate method 	
func MyRotation(degree:float,axis:String):
	
	if(axis=="y"):
	
		if(can_rotate_y):
			my_char_body.rotate_object_local(Vector3(0,1,0),degree)
	elif(axis=="z"):
		
		if(can_rotate_z):
			my_char_body.rotate_object_local(Vector3(0,0,1),degree)
	pass
	
#scale method
func DoScale(my_delta:float):
	
	var parent:Node3D = Model.get_parent().get_parent().get_parent()
	
	var _Scale:Vector3 =  Vector3(parent.scale.x+my_delta,parent.scale.y+my_delta
				,parent.scale.z+my_delta) 			

	parent.scale = clamp(_Scale,Vector3(0.1,0.1,0.1),Vector3(MaxScale,MaxScale,MaxScale))

#reparent child to new parent 	
func MyReparent(child:Node3D,parent:Node3D):
	
	child.reparent(parent)

func Init_Model():
	Model.global_position = Vector3(0,0,0)


func find_desired_size_3(node):

	var biggest_boundingbox:Vector3 
		
	biggest_boundingbox = find_size_mesh_master_per_vertex(node)
	
	var Scale= [float(standard_size.x)/float(biggest_boundingbox.x),
						float(standard_size.y)/float(biggest_boundingbox.y),
						float(standard_size.z)/float(biggest_boundingbox.z)]
	
								
	Scale.sort()
	#in order to scale properly and doesn't change overall shape of mesh use below 
	MyScale= Vector3(Scale[0],Scale[0],Scale[0])
	#MyScale= Vector3(Scale[0],Scale[1],Scale[2])
	
	return MyScale

#after loading file from hard this file is called 	
func new_file_added():
	
	if(my_char_body!=null):
		my_char_body.get_parent().remove_child(my_char_body)
		can_rotate_y = true
		can_rotate_z = true

	MaxScale = 100
	add_child(Model)
	create_Marker3d()
	calib_size()
		
#find all chilren and node itself	
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr

#get all meshes of node 
func get_all_meshes(mynodes):
	var allmeshes = []
	
	for i in mynodes:
		
		#if i is Node3D:
			#i.scale = Vector3.ONE
		if(i is MeshInstance3D):
			allmeshes.append(i)
			#print("size aabb mesh:"+str(i.get_aabb().size))
			#print("center aabb mesh:"+str(i.get_aabb().get_center()))
	return allmeshes
	
#find size of single mesh with different approach
func find_size_mesh_per_vertex(mymesh:MeshInstance3D):
	var _min = mymesh.get_aabb().position
	var _max = mymesh.get_aabb().end
	print("size_vertex_approah:"+str(_max-_min))
	
#find size of multiple meshes of single node 
func find_size_mesh_master_per_vertex(mynode:Node3D):
	var all_aabb = get_all_meshes_aabb_transfromed(get_all_children(mynode))
	var min_v = Vector3(INF,INF,INF)
	var max_v = Vector3(-INF,-INF,-INF)
	for i in all_aabb:
		#print(i.position)
		if(min_v>=i.position):
			min_v = i.position
		if(max_v<=i.end):
			max_v = i.end
		#min_v = min(min_v,i.position)
		#max_v = max(max_v,i.end)
	var mysize = max_v-min_v
	
	print("size meshes:"+str(mysize))
	
	
	return mysize	

#find center of multiple meshes 
func find_center_mesh_master_per_vertex(mynode:Node3D):
	var all_aabb = get_all_meshes_aabb_transfromed(get_all_children(mynode))
	var min_v = Vector3(INF,INF,INF)
	var max_v = Vector3(-INF,-INF,-INF)
	for i in all_aabb:
		#print(i.position)
		if(min_v>=i.position):
			min_v = i.position
		if(max_v<=i.end):
			max_v = i.end
		#min_v = min(min_v,i.position)
		#max_v = max(max_v,i.end)
	
	var mycenter= (max_v+min_v)/2
	
	print("center:"+str(mycenter))
	#print("center rotation:"+str())
	return mycenter

#in godot 4, we must handle change coordinate form local space 
#of object to world environment
func get_all_meshes_aabb_transfromed(mynodes):
	var allmeshes = []
	
	for i in mynodes:
		
	
		if(i is MeshInstance3D):
			allmeshes.append(i.global_transform*i.get_aabb())
		
	return allmeshes	

#when using characte2d, use this method for handling collision
func check_collision_side(mydelta):
	
	my_char_body.velocity += velocity_char *mydelta


	if(my_char_body.is_on_floor() && my_char_body.is_on_ceiling()):
				print("on floor & on celing")
				my_char_body.velocity = Vector3.ZERO
				activation_deactivation_char_body(true)
				MaxScale = my_char_body.scale[0]
				can_rotate_z = false
				my_char_body.move_and_slide()
				return
				

	elif(my_char_body.is_on_wall() && my_char_body.is_on_floor()):
				#print("on floor & on celing")
				my_char_body.velocity = Vector3.ZERO
				activation_deactivation_char_body(true)
				MaxScale = my_char_body.scale[0]
				can_rotate_z = false
				can_rotate_y = false
				my_char_body.move_and_slide()
				return


#
	elif(my_char_body.is_on_floor()):
			#print("on floor")
			velocity_char = Vector3(0,-9.8,0)
			activation_deactivation_char_body(false)
			
			my_char_body.move_and_slide()
			return

	elif(my_char_body.is_on_ceiling()):
			#print("on celing")
			velocity_char = Vector3(0,-9.8,0)
			
			activation_deactivation_char_body(false)
			
			my_char_body.move_and_slide()
			return

	elif(my_char_body.is_on_wall()):
			var collision:KinematicCollision3D =	my_char_body.get_last_slide_collision()

			if(wall_Is_right(my_char_body,collision.get_position(0))):
				my_char_body.move_and_slide()
				return
				
			else:
				my_char_body.move_and_slide()
				return

	
	
	activation_deactivation_char_body(false)
						
	my_char_body.move_and_slide()

#this method is used to find point is left or right of myobject
func wall_Is_right(myobject:Node3D,point:Vector3)->bool:
	
	var diff_vec:Vector3 = point-myobject.global_position
	
	var right:float = rad_to_deg(diff_vec.angle_to(Vector3.RIGHT))
	if(right>90): right = 180 - right
	
	
	var back:float = rad_to_deg(diff_vec.angle_to(Vector3.BACK))
	if(back>90): back = 180 - back
	
	print("Right:"+str(rad_to_deg(diff_vec.angle_to(Vector3.RIGHT))))
	print("back:"+str(rad_to_deg(diff_vec.angle_to(Vector3.BACK))))
	
	if(back>right):
		if(myobject.global_position.x-point.x>0):
	
			return false
		else:
		
			return true
		
	else:
		if(myobject.global_position.z-point.z>0):
	
			return false
		else:

			return true
		

#create desk with area3d or staticbody at runtime 
func create_desk(path:String):
	
		var static_desk:StaticBody3D = StaticBody3D.new()
		static_desk.name = "Esi"
		get_parent().add_child(static_desk)
	
	
		
		static_desk.global_position = desk_pos

	
				
		var collision_desk:CollisionShape3D = CollisionShape3D.new()
	
		static_desk.add_child(collision_desk)
		

		
		var mygltf:GLTFDocument = GLTFDocument.new()
		var gltf_state:GLTFState = GLTFState.new()
		
		mygltf.append_from_file(path,gltf_state)
		
		var model_desk =mygltf.generate_scene(gltf_state)
		
		get_parent().add_child(model_desk)
		

		var box_colision = BoxShape3D.new()
		collision_desk.shape =  box_colision

		box_colision.size = find_size_mesh_master_per_vertex(model_desk)
		
		
		model_desk.reparent(collision_desk)
	
		
		
		
		
		
		var	new_node_2:Node3D  = Node3D.new()
		
		static_desk.get_child(0).add_child(new_node_2)
		#var center = all_centers(model_desk)
		var center = find_center_mesh_master_per_vertex(model_desk)
		print("center:"+str(center))
		change_pivot(new_node_2,center)
		MyReparent(model_desk,new_node_2)


		new_node_2.position = Vector3.ZERO
		

#method for activation_deactivation of behavior of characterbody
func activation_deactivation_char_body(enable:bool):
	my_char_body.axis_lock_angular_x=enable
	my_char_body.axis_lock_angular_y=enable
	my_char_body.axis_lock_angular_z=enable
	my_char_body.axis_lock_linear_x=enable
	my_char_body.axis_lock_linear_y=enable
	my_char_body.axis_lock_linear_z=enable

#create controller class for handling controlling 
func create_controller():
	controller =  mycontroller.new()
	add_child(controller)
	
#create file class for handling reading from model from file 
func create_file():
	myfilemanager = MyFileManager.new()
	add_child(myfilemanager)
