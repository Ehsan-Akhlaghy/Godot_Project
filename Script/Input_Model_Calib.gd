#@tool
extends Node
class_name  Input_Model_Manager



#var Model:Node3D
var Model
@export var standard_size:Vector3






var center_pivot:Node3D
var MyScale:Vector3
var MaxScale:float = 100

var myshape
var my_area:Area3D





# Called when the node enters the scene tree for the first time.
func _ready():
	


	#call_deferred("create_Marker3d")
	
	#call_deferred ("calib_size")
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

#formulation (feature_unit/current_unit) * current_size = Desired_size 
func calib_size():
	
	Init_Model()
	
	var biggest_bounding_box:AABB = find_biggest_bounding_box(Model)
	
	var new_node:Node3D = Node3D.new()
	
	center_pivot.get_child(0).get_child(0).add_child(new_node)
	#*****change_pivot(new_node,find_center_3dObj(biggest_bounding_box.get_center()))
	
	change_pivot(new_node,all_centers(Model))
	MyReparent(Model,new_node)
	

	
	new_node.scale = find_desired_size(biggest_bounding_box)
	
	
	
	
	
	change_pivot(center_pivot,all_centers(Model))
	
	#*******change_pivot(center_pivot,find_center_3dObj(biggest_bounding_box.get_center()))
	#change_pivot(center_pivot,find_center_3dObj(all_centers(Model)))
	#MyReparent(Model,center_pivot.get_child(0).get_child(0))
	
	
	#new_node.position = Vector3(0,0,0)
	pass
func find_center_3dObj(Mymesh:Vector3)->Vector3:
	
	#var center:Vector3 = Model.to_global(Mymesh.get_center())
	
	#*************
	var center:Vector3 = Model.to_global(Mymesh)
	
	
	
	
	#var center:Vector3 = Mymesh.to_global(Mymesh.get_center())
	
	#var center:Vector3 = center_pivot.to_global(Mymesh.get_center())
	
	#print("centerMesh:"+ str(center))
	#print("before changing cordinate:"+str(Mymesh.get_center()))
	#print("afer changing cordinate:"+str(center))
	
	print("before changing cordinate:"+str(Mymesh))
	print("afer changing cordinate:"+str(center))
	
	
	return center
	#return Mymesh.get_center()
	pass
func change_pivot(mynode:Node3D,center:Vector3):
	
	#print("center before:"+ str(center_pivot.global_position) )
	#mynode.global_position= center
	
	mynode.global_position= center
	
	#print("center after:"+ str(center_pivot.global_position) )
	
	#MyReparent(Model,center_pivot)




	#MyReparent(Model,mynode.get_child(0).get_child(0))
	
	#MyReparent(Model,mynode)
	
	pass

#func MyLoad_prefab():
#	center_pivot = ResourceLoader.load("res://Prefab/center_pivot.tscn")
#	print(center_pivot.resource_name)
	
	
func create_Marker3d():	
	center_pivot = Node3D.new()
	
	#center_pivot.global_position = Vector3(0,10,0)
	
	my_area = Area3D.new()
	
	#my_area.gravity = 0
	#my_area.area_entered.connect(My_area_enterted())
	
	#my_rigid = RigidBody3D.new()
	#my_rigid.gravity_scale = 0
	#my_rigid.freeze_mode =RigidBody3D.FREEZE_MODE_KINEMATIC
	#my_rigid.contact_monitor=true
	#my_rigid.body_entered.connect(My_area_enterted)
	
	#my_char = CharacterBody3D.new()
	#desk_3dobj.body_entered.connect(My_area_enterted)
	#my_char.motion_mode=CharacterBody3D.MOTION_MODE_FLOATING
	
	
	var  my_collision: CollisionShape3D = CollisionShape3D.new()
	myshape = BoxShape3D.new()
	my_collision.shape =myshape
	
	
	#my_collision.shape.size=standard_size/1.5
	
	my_collision.shape.size=standard_size
	
	
	get_parent().add_child(center_pivot)
	
	center_pivot.add_child(my_area)
	my_area.add_child(my_collision)
	
	#center_pivot.add_child(my_rigid)
	#my_rigid.add_child(my_collision)
	
	#center_pivot.add_child(my_char)
	#my_char.add_child(my_collision)
	
	#Model.add_to_group("can_rotation")
	for i in center_pivot.get_children():
		i.add_to_group("can_rotation")
	
func MyRotation(degree:float):
	
	
	#InputModel.rotate_y(degree)
	
	center_pivot.rotate_y(degree)
	
	pass

func DoScale(my_delta:float,max_scale =1 ):
	

	#MyReparent(Model,Model.get_parent().get_parent())
	
	
	
	
	#***********
	#MyReparent(Model,Model.get_parent().get_parent().get_parent().get_parent())
	
	
	
	
	#change_pivot(find_center_3dObj(Model.get_aabb()))
	
	#var _Scale:Vector3 =  Vector3(Model.scale.x+my_delta,Model.scale.y+my_delta
		#		,Model.scale.z+my_delta) 
		
	#===============================
	
	#**********var parent:Node3D = Model.get_parent().get_parent().get_parent()
	
	var parent:Node3D = Model.get_parent().get_parent().get_parent().get_parent()
	
	var _Scale:Vector3 =  Vector3(parent.scale.x+my_delta,parent.scale.y+my_delta
				,parent.scale.z+my_delta) 			
				
	#=======================
	
	

	parent.scale = clamp(_Scale,Vector3(0.1,0.1,0.1),Vector3(MaxScale,MaxScale,MaxScale))
	#============
	
	
	#print("ScaleName:"+str(Model.get_parent().name))
	
func MyReparent(child:Node3D,parent:Node3D):
	
	child.reparent(parent)

func Init_Model():
	
	
	
	
	Model.global_scale(Vector3.ONE)
	#Model.global_position = Vector3(0,0,0)

	#Model.rotation = Vector3.ZERO
	MyReparent(Model,Model.get_parent().get_parent())
	
	#Model.position = Vector3(0,0,0)
	Model.global_position = Vector3(0,0,0)
	
func find_desired_size(mymesh:AABB)->Vector3:
	#var  Mymesh:AABB = Model.get_aabb()
	
	
	#var  Mymesh:AABB = Model.get_child(2).get_aabb()
	var Bounding_box: Vector3 = mymesh.size
	#print("Bounding box pre:"+ str(Bounding_box) )
	
	var Scale= [float(standard_size.x)/float(Bounding_box.x),
						float(standard_size.y)/float(Bounding_box.y),
						float(standard_size.z)/float(Bounding_box.z)]
	
	
								
	Scale.sort()
	MyScale= Vector3(Scale[0],Scale[0],Scale[0])
	
	#var parent:Node3D = Model.get_parent().get_parent().get_parent()
	
	return MyScale
	#parent.scale= MyScale
	#var New_AABB:AABB =Mymesh.grow(float(standard_size.x-Bounding_box.x)/2)
	
	pass
	
func new_file_added():
	if(center_pivot!=null):
		center_pivot.get_parent().remove_child(center_pivot)
	#self.get_parent().add_child(Model)
	MaxScale = 100
	add_child(Model)
	create_Marker3d()
	calib_size()
	
	
func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr

func get_all_meshes_aabb(mynodes):
	var allmeshes = []
	
	for i in mynodes:
		
		#if i is Node3D:
			#i.scale = Vector3.ONE
		if(i is MeshInstance3D):
			allmeshes.append(i.get_aabb())
			print("size aabb mesh:"+str(i.get_aabb().size))
			print("center aabb mesh:"+str(i.get_aabb().get_center()))
	return allmeshes

func get_all_meshes(mynodes):
	var allmeshes = []
	
	for i in mynodes:
		
		#if i is Node3D:
			#i.scale = Vector3.ONE
		if(i is MeshInstance3D):
			allmeshes.append(i)
			print("size aabb mesh:"+str(i.get_aabb().size))
			print("center aabb mesh:"+str(i.get_aabb().get_center()))
	return allmeshes
	
func find_biggest_bounding_box(mymodel:Node3D):
	var allmeshes = []
	allmeshes =get_all_meshes_aabb(get_all_children(mymodel))
	var size_allmeshes:int = allmeshes.size()	
	for i in range(0,size_allmeshes):
		if(i+1 == size_allmeshes):
			print("size merged:"+str(allmeshes[i].size))
			return allmeshes[i]
		allmeshes[i+1] = allmeshes[i+1].merge(allmeshes[i])
		

#func all_centers(mymodel:Node3D):
#	var allmeshes_aabb = []
#	var all_center = []
#	allmeshes_aabb =get_all_meshes_aabb(get_all_children(mymodel))
#	for i in allmeshes_aabb:
#		all_center.append(i.get_center())
#
#	var sum:Vector3 = Vector3.ZERO	
#	for i in all_center:
#		sum+=i
#	print(sum)
#	print(sum/all_center.size())
#	#print(mymodel.to_global(sum/all_center.size()))
#	return sum/all_center.size()


func all_centers(mymodel:Node3D):
	var allmeshes = []
	var all_center = []
	allmeshes=get_all_meshes(get_all_children(mymodel))
	for i in allmeshes:
		all_center.append(i.global_transform.origin)
		
	var sum:Vector3 = Vector3.ZERO	
	for i in all_center:
		sum+=i
	print(sum)
	print(sum/all_center.size())
	#print(mymodel.to_global(sum/all_center.size()))
	return sum/all_center.size()
	
			
#func Move(whichway:String):
#	if(whichway == "R"):
#		mymesh.global_translate(Vector3(0,1,0))
#	else:
#		mymesh.global_translate(Vector3(0,-1,0))
#		pass



	






func _on_d_area_area_entered(area):
	
	print("area:"+ str(area.get_groups()))
	
	if(area.is_in_group("can_rotation")):
		
		MaxScale = center_pivot.scale[0]
		print("EnteredMyDesk area:" + area.name)
	pass # Replace with function body.


func _on_d_area_area_exited(area):
	#print("ExitedMyDesk area:" + area.name)
	pass # Replace with function body.
