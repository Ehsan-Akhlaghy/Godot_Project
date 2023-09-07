#@tool
extends Node
class_name  Input_Model_Manager2



#var Model:Node3D
var Model
#@export
var standard_size:Vector3








var center_pivot:Node3D
var MyScale:Vector3
var MaxScale:float = 100

var myshape
var my_area:Area3D
var my_char_body:CharacterBody3D

var new_node:Node3D


var can_increase_pivot:bool = false
var can_decrese_pivot: bool = true

@export var desk:Node3D

var on_floor:= [false,false,[0]]
var on_wall:= false
var on_wall_r:= [false,false,[0]]
var on_wall_l:= [false,false,[0]]
var on_ceiling:= [false,false,[0]]

#signal Collision_Detection_Object  
#@export var area:Area3D


var myray:RayCast3D
var myshapecast:ShapeCast3D
var is_colided:bool = false

var wall_ceil_floor:String



var offset_collision:float = 0.001
var worldup:Vector3 = Vector3.UP

var can_rotate_y:bool = true
var can_rotate_z:bool = true


var offset_wall:Vector3

var velocity_char:Vector3

var controller:mycontroller


var path_asset_glb:String
var desk_path:String
var asset_pos:Vector3
#@export
var desk_pos:Vector3

#func _init(path_asset_glb:String,desk_path:String,asset_pos:Vector3):
#
#	_path_asset_glb = path_asset_glb
#	_desk_path = desk_path
#	_asset_pos = asset_pos

func myconstructor(_path_asset_glb:String,_desk_path:String,_desk_pos:Vector3,_asset_pos:Vector3,_standard_size:Vector3):
	
	path_asset_glb = _path_asset_glb
	desk_path = _desk_path
	asset_pos = _asset_pos	
	standard_size = _standard_size
	desk_pos = _desk_pos
	

	
# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("create_desk",desk_path)
	MaxScale = 100
	#add_child(Model)
	#create_Marker3d()
	#calib_size()
	#create_controller()
	#call_deferred("create_desk")
	
	
	
	#call_deferred("create_desk","res://3dModel/Desk/deskglb.glb")
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#create_desk()
	
	#*if(is_colided):
		#*center_pivot.global_position+= dir_collision(wall_ceil_floor)
		#print("onfloor_collision:"+str(on_floor[2]))
	
		
	
	
	
	#print("b-a:"+str(b-a))
	#print("b-a:2"+str(a.direction_to(b)))
	#print("slide:"+str(b.slide(Vector3(1,1,0))))
	
	
	#calib_pos()
	#if(my_char_body!=null):
		
		#if(my_char_body.move_and_slide()):
			
		#	print("colided upate loop!!")
			#center_pivot.global_position += Vector3(0,0.1,0)
	
	
	#if(my_char_body!=null):
	
#			var mybase = center_pivot.global_transform.basis
#			print("forward:"+str(-mybase.z))
#			print("backward"+str(mybase.z))
#			print("right"+str(mybase.x))
#			print("left"+str(mybase.x))
#			print("up"+str(mybase.y))
#			print("bottom"+str(-mybase.x))
#
#			my_char_body.move_and_slide()
#			print("last motion: "+str(my_char_body.get_last_motion()))
#			print("Delta position: "+str(my_char_body.get_position_delta()))
#			print("collision"+str(my_char_body.get_slide_collision_count()))
#			if(my_char_body.is_on_floor()):
#				print("on floor")
#				print("floor normal: "+str(my_char_body.get_floor_normal()))
#			if(my_char_body.is_on_ceiling()):
#				print("on ceiling")
#
#				#zprint("floor normal: "+str(my_char_body.get))
#			if(my_char_body.is_on_wall()):
#				print("on wall")
#				print("wall normal: "+str(my_char_body.get_wall_normal()))
	
	#increase_pivot()
		
	pass

func _physics_process(delta):
	if(my_char_body!=null):
		#my_char_body.velocity += velocity_char *delta
		#my_char_body.move_and_slide()
		check_collision_side(delta)

#formulation (feature_unit/current_unit) * current_size = Desired_size 
func calib_size():
	
	Init_Model()
	
	#***var biggest_bounding_box:AABB = find_biggest_bounding_box(Model)
	
	#***var new_node:Node3D = Node3D.new()
	
	new_node  = Node3D.new()
	
	#*center_pivot.get_child(0).get_child(0).add_child(new_node)
	my_char_body.get_child(0).add_child(new_node)
	
	#change_pivot(new_node,find_center_3dObj(biggest_bounding_box.get_center()))
	var center = all_centers(Model)
	
	change_pivot(new_node,center)
	MyReparent(Model,new_node)
	

	
	#new_node.scale = find_desired_size(biggest_bounding_box)
	
	new_node.scale = find_desired_size_2(Model)
	
	
	#***change_pivot(center_pivot,center)
	
	#center_pivot.global_position = Vector3.ZERO
	
	#center_pivot.global_position = offset_desk.global_position
	
	change_pivot(my_char_body,center)
	
	my_char_body.global_position = Vector3.ZERO
	
	my_char_body.global_position = asset_pos
	
	
	
	
	#change_pivot(center_pivot,find_center_3dObj(biggest_bounding_box.get_center()))
	#change_pivot(center_pivot,find_center_3dObj(all_centers(Model)))
	
	#****MyReparent(Model,center_pivot.get_child(0).get_child(0))
	
	
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
	
	#print("before changing cordinate:"+str(Mymesh))
	#print("afer changing cordinate:"+str(center))
	
	
	return center
	#return Mymesh.get_center()
	pass
func change_pivot(mynode:Node3D,center:Vector3):
	
	#print("center before:"+ str(center_pivot.global_position) )
	#mynode.global_position= center
	if(new_node.position.length()!=0):
		new_node.position = Vector3.ZERO
	
	mynode.global_position= center
	
	#mynode.position= center
	
	#print("center after:"+ str(center_pivot.global_position) )
	
	#MyReparent(Model,center_pivot)




	#MyReparent(Model,mynode.get_child(0).get_child(0))
	
	#MyReparent(Model,mynode)
	
	pass

#func MyLoad_prefab():
#	center_pivot = ResourceLoader.load("res://Prefab/center_pivot.tscn")
#	print(center_pivot.resource_name)
	
	
func create_Marker3d():	
	#center_pivot = Node3D.new()
	
	#center_pivot.global_position = Vector3(0,10,0)
	
	#my_area = Area3D.new()
	
	my_char_body = CharacterBody3D.new()
	
	#my_char_body.axis_lock_angular_x = false
	#my_char_body.axis_lock_angular_y = false
	#my_char_body.axis_lock_angular_z = false
	#my_char_body.axis_lock_linear_x = false
	#my_char_body.axis_lock_linear_y = false
	#my_char_body.axis_lock_linear_z = false
	
	
	
	
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
	
	
	#get_parent().add_child(center_pivot)
	get_parent().add_child(my_char_body)
	
	
	#center_pivot.add_child(my_area)
	#my_area.add_child(my_collision)
	
	#center_pivot.add_child(my_rigid)
	#my_rigid.add_child(my_collision)
	
	#center_pivot.add_child(my_char_body)
	my_char_body.add_child(my_collision)
	
	
	
	#Model.add_to_group("can_rotation")
	#for i in center_pivot.get_children():
		#i.add_to_group("can_rotation")
		
	#var callable = Callable(self,"collision_happen")
	
	
	
	#my_area.area_entered.connect(_on_d_area_area_entered)
	#my_area.area_exited.connect(_on_d_area_area_exited)
	
	
	
	#print("connection:"+str(my_area.connect("area_entered",func ehsan():print("fired!"),18)))
	#print("Connection:"+str(my_area.area_entered.get_connections()))
	#my_area.area_entered.emit()
	#print("Connection2:"+str(area.area_entered.get_connections()))
	
func MyRotation(degree:float,axis:String):
	
	if(axis=="y"):
		#center_pivot.rotate_y(degree)
		if(can_rotate_y):
			my_char_body.rotate_object_local(Vector3(0,1,0),degree)
	elif(axis=="z"):
		#center_pivot.rotate_z(degree)
		if(can_rotate_z):
			my_char_body.rotate_object_local(Vector3(0,0,1),degree)
			#my_char_body.rotate_object_local(Vector3(1,1,1),degree)
			
			
		#center_pivot.rotate_object_local(Vector3(1,0,0),degree)
		#center_pivot.rotate_x(degree)
		
		
	#InputModel.rotate_y(degree)
	
	#print("Globalbasisx:"+str(center_pivot.global_transform.basis.x))
	#print("Localbasisx:"+str(center_pivot.transform.basis.x))
	#***new_node.rotate_y(degree)
	
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
	
	#****************
	#var parent:Node3D = Model.get_parent().get_parent().get_parent().get_parent()
	
	var parent:Node3D = Model.get_parent().get_parent().get_parent()
	
	var _Scale:Vector3 =  Vector3(parent.scale.x+my_delta,parent.scale.y+my_delta
				,parent.scale.z+my_delta) 			
	
	#var _Scale:Vector3 =  Vector3(new_node.scale.x+my_delta,new_node.scale.y+my_delta
			#	,new_node.scale.z+my_delta) 	
				
	#=======================
	
	
	#new_node.scale = clamp(_Scale,Vector3(0.1,0.1,0.1),Vector3(MaxScale,MaxScale,MaxScale))
	parent.scale = clamp(_Scale,Vector3(0.1,0.1,0.1),Vector3(MaxScale,MaxScale,MaxScale))
	#decrease_pivot()
	#parent.scale = clamp(_Scale,Vector3(0.1,0.1,0.1),Vector3(MaxScale,MaxScale,MaxScale))
	#============
	#******************
	
	#print("ScaleName:"+str(Model.get_parent().name))
	
func MyReparent(child:Node3D,parent:Node3D):
	
	child.reparent(parent)

func Init_Model():
	
	
	
	
	#*********Model.global_scale(Vector3.ONE)
	
	
	
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

func find_desired_size_2(node):
	var allmeshes = []
	var all_size = []
	allmeshes=get_all_meshes(get_all_children(node))
	for i in allmeshes:
		all_size.append( i.global_transform.basis.get_scale() *i.get_aabb().size) 
		
	
		
	#**var sum:Vector3 = Vector3.ZERO	
	#**for i in all_size:
		#**sum+=i
	#print(sum)
	
	#**var size = sum/all_size.size()
	#**print("second way center:"+str(sum/all_size.size()))
	
	
	#print(mymodel.to_global(sum/all_center.size()))
	

	
	var biggest_vector:Vector3 =Vector3.ZERO
	
	for i in range(0,all_size.size()):
		if(i+1 ==all_size.size()):
			break
		#print("i:"+str(i))
		#print("array:"+str(all_size))	
		#print("pre:"+str(all_size[i])+"length:"+str(all_size[i].length()))
		#print("current:"+str(all_size[i+1])+"length:"+str(all_size[i+1].length()))
		if(all_size[i].length() >= all_size[i+1].length()):
			all_size[i+1] = all_size[i]
		#all_size[i+1] = max(all_size[i].length(),all_size[i+1].length())
	biggest_vector = all_size[all_size.size()-1]	
	
	var Scale= [float(standard_size.x)/float(biggest_vector.x),
						float(standard_size.y)/float(biggest_vector.y),
						float(standard_size.z)/float(biggest_vector.z)]
	
	
								
	Scale.sort()
	MyScale= Vector3(Scale[0],Scale[0],Scale[0])
	
	#var parent:Node3D = Model.get_parent().get_parent().get_parent()
	
	return MyScale
	
	
	
	return 
	
	
func new_file_added():
	#if(center_pivot!=null):
	if(my_char_body!=null):
		#center_pivot.get_parent().remove_child(center_pivot)
		my_char_body.get_parent().remove_child(my_char_body)
		on_floor[2] = []
		on_floor[1]=false
		on_floor[0]=false
		
		on_ceiling[2] = []
		on_ceiling[1]=false
		on_ceiling[0]=false
		
		on_wall_r[2] = []
		on_wall_r[1]=false
		on_wall_r[0]=false
		
		on_wall_l[2]=[]
		on_wall_l[1]=false
		on_wall_l[0]=false
		
		can_rotate_y = true
		can_rotate_z = true
	if(myray!=null):
		myray.get_parent().remove_child(myray)
		
	#self.get_parent().add_child(Model)
	MaxScale = 100
	add_child(Model)
	create_Marker3d()
	calib_size()
	#create_ray3d()
	#create_shape3d()
	
	
	
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
			#print("size aabb mesh:"+str(i.get_aabb().size))
			#print("center aabb mesh:"+str(i.get_aabb().get_center()))
	return allmeshes

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
	
func find_biggest_bounding_box(mymodel:Node3D):
	var allmeshes = []
	allmeshes =get_all_meshes_aabb(get_all_children(mymodel))
	var size_allmeshes:int = allmeshes.size()	
	for i in range(0,size_allmeshes):
		if(i+1 == size_allmeshes):
			#print("size merged:"+str(allmeshes[i].size))
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
		all_center.append( i.global_transform *i.get_aabb().get_center()) 
		
	
		
	var sum:Vector3 = Vector3.ZERO	
	for i in all_center:
		sum+=i
	#print(sum)
	#print("second way center:"+str(sum/all_center.size()))
	#print(mymodel.to_global(sum/all_center.size()))
	return sum/all_center.size()
	
			
#func Move(whichway:String):
#	if(whichway == "R"):
#		mymesh.global_translate(Vector3(0,1,0))
#	else:
#		mymesh.global_translate(Vector3(0,-1,0))
#		pass



func increase_pivot():
	if(can_increase_pivot):
		#center_pivot.global_position += Vector3(0,0.25,0)
		#if(my_char_body!=null):
		#	my_char_body.move_and_slide()
			pass

func decrease_pivot():
	#if(can_decrese_pivot):
		#center_pivot.global_position -= Vector3(0,1,0)
		#if(my_char_body!=null):
		#	my_char_body.move_and_slide()
	#print("decrease pivot")
	if(!is_colided):
		while(on_ceiling[2]!=0):
			print("decrease pivot ceiling")
			center_pivot.global_position+=Vector3(0,offset_collision,0)
			
			on_ceiling[2]=on_ceiling[2]-1
			
		while (on_floor[2]!=0):
			print("decrease pivot flooring:"+str(on_floor[2]))
			center_pivot.global_position+=Vector3(0,-offset_collision,0)
			on_floor[2] = on_floor[2]-1
			
		while(on_wall_r[2]!=0):
			print("decrease pivot wall r")
			center_pivot.global_position+=Vector3(0,0,-offset_collision)
			on_wall_r[2]= on_wall_r[2]-1
		while(on_wall_l[2]!=0):
			print("decrease pivot wall left")
			center_pivot.global_position+=Vector3(0,0,offset_collision)	
			on_wall_l[2] = on_wall_l[2]-1	
			pass
			
	#my_char_body.move_and_slide()		
			#print("decrease pivot")


func decrease_pivot_2():
	#if(can_decrese_pivot):
		#center_pivot.global_position -= Vector3(0,1,0)
		#if(my_char_body!=null):
		#	my_char_body.move_and_slide()
	#print("decrease pivot")
	
		#**for i in range(0,on_ceiling[2][-1]-1):
			#print("decrease pivot ceiling")
			#center_pivot.global_position+=Vector3(0,offset_collision,0)
			
			#on_ceiling[2]=on_ceiling[2]-1
			
		#if (on_floor[2]!=0):
		#while ( on_floor[2][-1]!=0):
		if(on_floor[2][-1]>6):on_floor[2][-1] = 6 * ((on_floor[2][-1]/100)+1)
		for i in range(0,on_floor[2][-1]-1):
			print("decrease pivot flooring:"+str(on_floor[-1]))
			center_pivot.global_position+=Vector3(0,-offset_collision,0)
			on_floor[2][-1] = on_floor[2][-1]-1
			
			if(on_floor[2][-1]==1):
				if(on_floor[2].size()>1):on_floor[2].pop_back()
				
			
		
				
			
#		while(on_wall_r[2][-1]!=0):
#			print("decrease pivot wall r")
#			center_pivot.global_position+=Vector3(0,0,-offset_collision)
#			on_wall_r[2]= on_wall_r[2]-1
#		while(on_wall_l[2][-1]!=0):
#			print("decrease pivot wall left")
#			center_pivot.global_position+=Vector3(0,0,offset_collision)	
#			on_wall_l[2] = on_wall_l[2]-1	
#			pass
			
	#my_char_body.move_and_slide()		
			#print("decrease pivot")






func check_collision_side(mydelta):
	
	my_char_body.velocity += velocity_char *mydelta
	
	#print("velocity:"+str(my_char_body.velocity))
	#my_char_body.move_and_slide()
	
	
	#var is_collision:bool 
	
	#print("move and slide:"+str(is_collision))
	
	
	
	
	
	#if(is_collision):
		
#		print("colided!")
#
#
#		#print("colided!")

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
#			#print("on floor")
#			#var collision:KinematicCollision3D =	my_char_body.get_last_slide_collision()
#			#print("Coll pos:"+str(collision.get_position(0)))
#			#print("Position_inside_object"+str(point_inside_object(collision.get_position(0),find_biggest_bounding_box(desk))))
#			#center_pivot.global_position+=Vector3(0,0.1,0)
#			on_floor[0] = true
#			on_floor[1] = true
#			#on_floor[2] = on_floor[2]+1
#
#			#my_char_body.velocity = Vector3(0,0.1,0)
#
#
#			#center_pivot.global_position+=Vector3(0,0.1,0)
#
#			#my_char_body.move_and_slide()
#
#			while (on_floor[0]):
#				print("on floor")
#				print("center pos:"+str(center_pivot.global_position))
#				center_pivot.global_position+=Vector3(0,0.0005,0)
#				#print("center pos:"+str(center_pivot.global_position))
#				#my_char_body.velocity += Vector3(0,0.1,0)
##
##				#my_char_body.move_and_slide()
#				on_floor[2]=on_floor[2]+1
#
##
#				if(!my_char_body.move_and_slide()):
##					print("not in floor")
#					print("move and slide2:"+str(my_char_body.move_and_slide()))
#					on_floor[0] = false
#
#
#					#Collision_Detection_Object.emit()
#
#
	elif(my_char_body.is_on_ceiling()):
			#print("on celing")
			velocity_char = Vector3(0,-9.8,0)
			
			activation_deactivation_char_body(false)
			
			my_char_body.move_and_slide()
			return
#			print("on ceiling")
#
#			on_ceiling[0] = true
#			on_ceiling[1] = true
#			#on_ceiling[2] = on_ceiling[2]+1
#
#			#var collision:KinematicCollision3D =	my_char_body.get_last_slide_collision()
#			#rint("Coll pos:"+str(collision.get_position(0)))
#			while (on_ceiling[0]):
#				print("on ceiling")
#				print("center pos:"+str(center_pivot.global_position))
#				center_pivot.global_position-=Vector3(0,0.0005,0)
#				on_ceiling[2] = on_ceiling[2]+1
#
#				if(!my_char_body.move_and_slide()):
##					print("not in floor")
#					print("move and slide2:"+str(my_char_body.move_and_slide()))
#					on_ceiling[0] = false
#
#
#
#
	elif(my_char_body.is_on_wall()):
			#print("on wall")
			var collision:KinematicCollision3D =	my_char_body.get_last_slide_collision()
#			#print("Coll pos:"+str(collision.get_position(0)))
#			on_wall = true
#
#			print("position collision: "+str(collision.get_position(0)))
#
			if(wall_Is_right(my_char_body,collision.get_position(0))):
				my_char_body.move_and_slide()
				return
				pass
			else:
				my_char_body.move_and_slide()
				return
#				#center_pivot.global_position+=Vector3(-0.1,0,0)
#				#on_wall_l  = true
#				on_wall_r[0] = true
#				on_wall_r[1] = true
#				#on_wall_r[2] = on_wall_r[2]+1
#
#				while (on_wall_r[0]):
#					print("on wall right")
#					print("center pos:"+str(center_pivot.global_position))
#					center_pivot.global_position+=Vector3(0,0,0.0005)
#				#print("center pos:"+str(center_pivot.global_position))
#				#my_char_body.velocity += Vector3(0,0.1,0)
##
##				#my_char_body.move_and_slide()
#					on_wall_r[2]=on_wall_r[2]+1
#
#	#
#					if(!my_char_body.move_and_slide()):
#	#					print("not in floor")
#						print("move and slide2:"+str(my_char_body.move_and_slide()))
#						on_wall_r[0] = false

			
#
			#else:
				
#				print("wall left")
#				on_wall_l[0] = true
#				on_wall_l[1] = true
#				#on_wall_l[2] = on_wall_l[2] +1 
#				#center_pivot.global_position+=Vector3(0.1,0,0)
#
#				while (on_wall_l[0]):
#					#print("on wall left")
#					#print("center pos:"+str(center_pivot.global_position))
#					center_pivot.global_position+=Vector3(0,0,-0.0005)
#				#print("center pos:"+str(center_pivot.global_position))
#				#my_char_body.velocity += Vector3(0,0.1,0)
##
##				#my_char_body.move_and_slide()
#					on_wall_l[2]=on_wall_l[2]+1
#
##
#					if(!my_char_body.move_and_slide()):
#	#					print("not in floor")
#						#print("move and slide2:"+str(my_char_body.move_and_slide()))
#						on_wall_l[0] = false
#
#
#				print("on wall")
#		my_char_body.position = Vector3(0,0,0)
	
	
	activation_deactivation_char_body(false)
						
	my_char_body.move_and_slide()
	#else:
		#print("nothing happened")

#func point_inside_object(point:Vector3,Model_AABB:AABB)->bool:
		#return Model_AABB.has_point(point)

func calib_pos():
	#print("call calib pos")
	if(on_floor[0]):
		#*print("on floor")
		center_pivot.global_position+=Vector3(0,0.1,0)
		my_char_body.move_and_slide()
		
		on_floor[2]=on_floor[2]+1
		
		
		if(!my_char_body.is_on_floor()):
			on_floor[0] = false
			
			#Collision_Detection_Object.emit()
			
			#print("not in floor")
	elif(on_wall):
		print("on wall")
		my_char_body.move_and_slide()
		if(on_wall_r[0]):
			#center_pivot.global_position+=Vector3(-0.1,0,0)
			
		
			center_pivot.global_position+=Vector3(0,0,0.1)
			print("right")
			
			on_wall_r[2] = on_wall_r[2]+1
			
		elif(on_wall_l[0]):
			print("left")
			#center_pivot.global_position+=Vector3(0.1,0,0)
			center_pivot.global_position+=Vector3(0,0,-0.1)
			
			on_wall_l[2] = on_wall_l[2]+1
			
		if(!my_char_body.is_on_wall()):
			print("not in wall")
			on_wall = false
			on_wall_l[0] = false
			on_wall_r[0] = false
	elif(on_ceiling[0]):
		center_pivot.global_position+=Vector3(0,-0.1,0)
		my_char_body.move_and_slide()
		
		on_ceiling[2] = on_ceiling[2]+1
		if(!my_char_body.is_on_ceiling()):
			on_ceiling[0] = false
			
func calib_pos_v2():
	
	while(on_floor[0]):
		#*print("on floor")
		center_pivot.global_position+=Vector3(0,0.1,0)
		my_char_body.move_and_slide()
		#on_floor[2]=on_floor[2]+1
		
		if(!my_char_body.is_on_floor()):
			on_floor[0] = false
			#Collision_Detection_Object.emit()

func wall_Is_right(myobject:Node3D,point:Vector3)->bool:
	#print("global position object:"+str(myobject.global_position))
	#print("point:"+str(point.z))
	var diff_vec:Vector3 = point-myobject.global_position
	
	var right:float = rad_to_deg(diff_vec.angle_to(Vector3.RIGHT))
	if(right>90): right = 180 - right
	
	
	var back:float = rad_to_deg(diff_vec.angle_to(Vector3.BACK))
	if(back>90): back = 180 - back
	
	print("Right:"+str(rad_to_deg(diff_vec.angle_to(Vector3.RIGHT))))
	print("back:"+str(rad_to_deg(diff_vec.angle_to(Vector3.BACK))))
	
	if(back>right):
		if(myobject.global_position.x-point.x>0):
			offset_wall =  Vector3(offset_collision,0,0)
			#velocity_char = Vector3(-9.8,0,0)
			return false
		else:
			offset_wall = Vector3(-offset_collision,0,0)
			#velocity_char = Vector3(9.8,0,0)
			return true
		print("right must be increased")
	else:
		if(myobject.global_position.z-point.z>0):
			offset_wall =  Vector3(0,0,offset_collision)
			#velocity_char = Vector3(0,0,-9.8)
			return false
		else:
			offset_wall =  Vector3(0,0,-offset_collision)
			#velocity_char = Vector3(0,0,9.8)
			return true
		print("back must be increased")
		
	
	
	#var zavie:float = rad_to_deg(myobject.global_position.angle_to(diff_vec))
	
	#var new_vector:Vector3 =point.cross(Vector3.UP).sign()
	
	#var new_vector:float =Vector3.RIGHT.dot(diff_vec)
	#var new_vector:Vector3 =(point.y*myobject.global_position.z)
	#print("Zavie:"+str(new_vector))
	
	#if(new_vector>=0):
	#	print("wall left")
	#	return false
	#else:
	#	print("wall right")
		#return true
		
		
#	if(zavie>=90):
#		print("wall right")
#		return true
#	else:
#		print("wall left")
#		return false

	
	print("wall is right or left:"+str())
	
	
	
	
#	if(myobject.global_position.z < point.z):
#		print("object<point")
#		return true
#	else:
#		print("object>point")
#		return false
	
		
		#var a:PhysicsDirectSpaceState3D
		#PhysicsRayQueryParameters3D
		
	#var new_AABB:AABB = AABB(point,Vector3(5,5,5))
	#return Model_AABB.encloses(new_AABB)
	


		
func create_ray3d():
	myray = RayCast3D.new()
	
	
	get_parent().add_child(myray)
	myray.global_position = center_pivot.global_position
	myray.enabled = true
	myray.collide_with_areas = true
	myray.collide_with_bodies = false
	
	

	
		
func create_shape3d():
	myshapecast = ShapeCast3D.new()
	
	
	get_parent().add_child(myray)
	myshapecast.global_position = center_pivot.global_position
	myshapecast.enabled = false
	myshapecast.collide_with_areas = true
	myshapecast.collide_with_bodies = false
	var myshape = BoxShape3D.new()
	myshapecast.shape =myshape
	
func my_shapecast(myshape:ShapeCast3D,myarea:Area3D,distance:float):
	myshape.global_position = center_pivot.global_position
	myshape.enabled = true
	
	
	
	

	myshape.target_position = Vector3(0,distance,0)
	if(myshape.is_colliding()):
		if(myshape.get_collider(0).get_parent().name==myarea.name):
			myshape.enabled = false
			return "up"
	else:
		myshape.target_position = Vector3(0,-distance,0)
		if(myshape.is_colliding()):
			if(myshape.get_collider(0).get_parent().name==myarea.name):
				myshape.enabled = false
				return "down"
		else:
			myshape.target_position = Vector3(0,0,distance)
			if(myshape.is_colliding()):
				if(myshape.get_collider(0).get_parent().name==myarea.name):
					myshape.enabled = false
					return "right"
			else:
				myshape.target_position = Vector3(0,0,-distance)
				if(myshape.is_colliding()):
					if(myshape.get_collider(0).get_parent().name==myarea.name):
						myshape.enabled = false
						return "left"
				else:
					"none of side"
	
func side(mypos:Vector3):
	var newpos:Vector3 =center_pivot.to_local(mypos)
	if(newpos.y >0):
		print("object is up")
	elif (newpos.y<0):
		print("objecy is down")
	
	
func my_raycast(myray:RayCast3D,myarea:Area3D):
	myray.global_position = center_pivot.global_position
	#myray.global_position.z+=myz
	myray.enabled = true
	myray.exclude_parent = true
	myray.target_position = myarea.global_position - myray.global_position
	print("inside raycast")
	myray.force_raycast_update()
	if(myray.is_colliding()):
		print(myray.get_collider().name)
		print("my area inside raycast:"+str(myarea.name))
		
		
		
		
		
		if(myray.get_collider().name==myarea.name):
			#myray.enabled = false
			print("colided")
			
			var mynormal = myray.get_collision_normal()
			print(myray.get_collision_normal())
			
			#if(mynormal.is_zero_approx()):
			mynormal = -myray.global_position.direction_to(myray.to_global(myray.target_position))
					
			var is_floor:bool = mynormal.angle_to(worldup) <= PI/4
			var is_ceiling:bool = (-mynormal).angle_to(worldup) <= PI/4
			var is_wall:bool =  not is_floor and not is_ceiling
					
			print("is_floor:"+str(is_floor))
			print("is_ceiling:"+str(is_ceiling))
			print("is_wall:"+str(is_wall))
			
			#var answers = {"floor":is_floor,"ceil":is_ceiling,"wall":is_wall}
			
			var answer:String
			
			if(is_floor):
				on_floor[0]= true
				answer= "floor" 
			elif(is_ceiling):
				on_ceiling[0]= true
				answer= "ceil"
				
			else:
				if(wall_Is_right(center_pivot,myarea.global_position)):
					on_wall_r[0] = true
					answer= "wall_r"
					#offset_wall = find_which_side_collide(center_pivot,mynormal)
					
					
				else:
					on_wall_l[0]=true
					answer= "wall_l"
					#offset_wall = find_which_side_collide(center_pivot,mynormal)
					
			if((on_floor[0]&& on_ceiling[0])||(on_wall_l[0]&&on_wall_r[0])||
				(on_floor[0]&&on_wall_l[0])||(on_floor[0]&&on_wall_r[0])||
				(on_ceiling[0]&&on_wall_l[0])||(on_ceiling[0]&&on_wall_r[0])):
							return"double_collision"
			
			else:		
					
				return answer
			
			
		
			
			#print(myarea.to_local(myray.get_collision_normal()))
			#print(myarea.to_global(myray.get_collision_normal()))
			
			#print("basisx:"+str(myarea.transform.basis.x/myarea.scale.x))
			#print("basisy:"+str(myarea.transform.basis.y/myarea.scale.y))
			#print("basisz:"+str(myarea.transform.basis.z/myarea.scale.z))
			#print("basisx:"+str(myray.transform.basis.x))
			#print("basisy:"+str(myray.transform.basis.y))
			#print("basisz:"+str(myray.transform.basis.z))




#	myray.target_position = Vector3(0,300,0)
#	if(myray.is_colliding()):
#		if(myray.get_collider().get_parent().name==myarea.name):
#			myray.enabled = false
#			print("up")
#			return "up"
#	else:
#		myray.target_position = Vector3(0,-300,0)
#		if(myray.is_colliding()):
#			if(myray.get_collider().get_parent().name==myarea.name):
#				myray.enabled = false
#				print("down")
#				return "down"
#		else:
#			myray.target_position = Vector3(0,0,300)
#			if(myray.is_colliding()):
#				if(myray.get_collider().get_parent().name==myarea.name):
#					myray.enabled = false
#					print("right")
#					return "right"
#			else:
#				myray.target_position = Vector3(0,0,-300)
#				if(myray.is_colliding()):
#					if(myray.get_collider().get_parent().name==myarea.name):
#						myray.enabled = false
#						print("false")
#						return "left"
#				else:
#					"none of side"




func dir_collision(dir:String):
	match dir:
		"floor":
			#var c = []
			#c.front()
			#c.push_back()
			#c= on_floor[2].pop_back()
			#print("c:"+str(c))
			
			on_floor[2][-1] = on_floor[2][-1]+1
			print("inside floor:"+str(on_floor[2]))
			on_floor[1] = true;
			return Vector3(0,offset_collision,0)
			
		"ceil":
			on_ceiling[2] = on_ceiling[2]+1
			return Vector3(0,-offset_collision,0)
			
			print("on ceiling2 collision:"+str(on_ceiling[2]))
		"wall_l":
			on_wall_r[2] = on_wall_r[2]+1
			#return Vector3(0,0,offset_collision)
			#offset_wall
			return offset_wall
		"wall_r":
			on_wall_l[2] = on_wall_l[2]+1
			#return Vector3(0,0,-offset_collision)
			return offset_wall
		"double_collision":
			MaxScale = center_pivot.scale[0]
			
			is_colided = false
			if(on_ceiling[0]&&on_floor[0]):
				can_rotate_z = false
			elif (on_wall_l[0] && on_wall_r[0]):
				can_rotate_y = false
			elif((on_wall_l[0]&&on_floor[0])||
				(on_wall_l[0] && on_ceiling[0])||
				(on_wall_r[0]&&on_floor[0])||
				(on_wall_r[0]&&on_ceiling[0])):
					can_rotate_z = false
			
			return Vector3.ZERO
			
			
	return Vector3.ZERO	


func find_which_side_collide(mynode:Node3D,mynormal:Vector3)->Vector3:
	var basisx = mynode.global_transform.basis.x/mynode.scale.x
	var basisy = mynode.global_transform.basis.y/mynode.scale.y
	var basisz = mynode.global_transform.basis.z/mynode.scale.z
	
	if(abs(mynormal) == abs(basisx)):
		return Vector3(offset_collision,0,0)
	elif (abs(mynormal) == abs(basisy)):
		return Vector3(0,offset_collision,0)
	elif (abs(mynormal) == abs(basisz)):
		return Vector3(0,0,offset_collision)
	else:
		return Vector3(0,0,0)
	
	


func create_desk(path:String):
#	var area_desk:Area3D = Area3D.new()
#
#	get_parent().add_child(area_desk)
#
#	area_desk.global_position = Vector3(0,0,0)
#
#	var collision_desk:CollisionShape3D = CollisionShape3D.new()
#
#	area_desk.add_child(collision_desk)
#
#	var mesh_desk:CSGBox3D = CSGBox3D.new()
#
#	collision_desk.add_child(mesh_desk)
#
#	var box_colision = BoxShape3D.new()
#	collision_desk.shape =  box_colision
	
		var static_desk:StaticBody3D = StaticBody3D.new()
		static_desk.name = "Esi"
		get_parent().add_child(static_desk)
	
		#static_desk.global_position = Vector3(0,0,0)
		
		static_desk.global_position = desk_pos

		#*static_desk.global_position.y = static_desk.global_position.y-4
		#static_desk.global_position.y = static_desk.global_position.y
				
		var collision_desk:CollisionShape3D = CollisionShape3D.new()
	
		static_desk.add_child(collision_desk)
		
		#var mesh_desk:CSGBox3D = CSGBox3D.new()
		#mesh_desk.size = Vector3(20,20,20)
		
		var mygltf:GLTFDocument = GLTFDocument.new()
		var gltf_state:GLTFState = GLTFState.new()
		
		mygltf.append_from_file(path,gltf_state)
		
		var a =mygltf.generate_scene(gltf_state)
	
		collision_desk.add_child(a)
	
		var box_colision = BoxShape3D.new()
		collision_desk.shape =  box_colision
		#box_colision.size =Vector3(20,20,20)
		
		
		var allmeshes = []
		var all_size = []
		allmeshes=get_all_meshes(get_all_children(a))
		for i in allmeshes:
			all_size.append( i.global_transform.basis.get_scale() *i.get_aabb().size)
		
		for i in range(0,all_size.size()):
			if(i+1 ==all_size.size()):
				break
			if(all_size[i].length() >= all_size[i+1].length()):
				all_size[i+1] = all_size[i]
			
		var biggest_vector = all_size[all_size.size()-1]
		
		
		
		#box_colision.size =biggest_vector.global_transform.basis.get_scale()* biggest_vector.get_aabb().size 
		box_colision.size =biggest_vector
		#print(str(mesh_desk.global_transform.basis.get_scale()) +""+  str(mesh_desk.get_aabb().size) )
	
func activation_deactivation_char_body(enable:bool):
	my_char_body.axis_lock_angular_x=enable
	my_char_body.axis_lock_angular_y=enable
	my_char_body.axis_lock_angular_z=enable
	my_char_body.axis_lock_linear_x=enable
	my_char_body.axis_lock_linear_y=enable
	my_char_body.axis_lock_linear_z=enable




func create_controller():
	controller =  mycontroller.new()
	controller.MyModelManager2 = self
	
	

#func _on_d_area_area_entered(area):
#
#	print("areaName entered:"+str(area.name))
#	print("area:"+ str(area.get_groups()))
#	#print("area normal:"+str())
#
#	wall_ceil_floor= my_raycast(myray,area)
#
#	is_colided = true
#
#
#	match(wall_ceil_floor):
#		"floor":
#			on_floor[2].push_back(0)
#		"ceil":
#			on_ceiling[2].push_back(0)
#		"wall_l":
#			on_wall_l[2].push_back(0)
#		"wall_r":
#			on_wall_r[2].push_back(0)
#
#
	
#	if(on_floor[0]&&on_ceiling[0])||(on_wall_l[0]&&on_wall_r[0])||(on_floor[0]&&on_wall_l[0])||(on_floor[0]&&on_wall_r[0])||(on_ceiling[0]&&on_wall_l[0])||(on_ceiling[0]&&on_wall_r[0]):
#		is_colided = false
#	else:
#		is_colided = true
					

	
	
	#if(wall_ceil_floor!=null):
		#	while(is_colided):
			#	center_pivot.global_position+= dir_collision(wall_ceil_floor)

	
	
	#var distance = area.global_position.distance_squared_to(center_pivot.global_position)
	
	#side(area.global_position)
	
	#***while(is_colided):
		#my_raycast(myray,area)
		#center_pivot.global_position+=dir_collision(my_raycast(myray,area))
		#***center_pivot.global_position+=dir_collision(my_shapecast(myshapecast,area,distance))
		
#	if(area.is_in_group("can_rotation")):
#
#		#***MaxScale = center_pivot.scale[0]
#		#center_pivot.global_position += Vector3(0,1,0)
#
#		can_increase_pivot = true
#		can_decrese_pivot = false
#
#		print("EnteredMyDesk area:" + area.name)
#	pass # Replace with function body.


#func _on_d_area_area_exited(area):
#
#	is_colided = false
#
#	on_floor[1]=false
#
#	print("area name exited"+str(area.name))
#
#	if(area.is_in_group("can_rotation")):
#		can_increase_pivot = false
#		can_decrese_pivot = true
#
#
#	#print("ExitedMyDesk area:" + area.name)
#	pass # Replace with function body.



	#print("body exited:"+str(body.name))
	
	
	#can_increase_pivot = false
	#can_decrese_pivot = true
	
	
	# Replace with function body.






