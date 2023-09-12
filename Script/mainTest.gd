extends Node

#@export var model:Node3D
#@export var mymodel_manager:Input_Model_Manager
# Called when the node enters the scene tree for the first time.
func _ready():

	
	#var a = preload("res://Prefab/input_model_manager.tscn").instantiate()


	#a.myconstructor("res://MyFiles/monitor.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(3,3,3))
	
	
	#a.myconstructor("res://3dModel/blue-house/source/blue house.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(3,3,3))
	#a.myconstructor("res://3dModel/detailed_monkey/scene.gltf","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(2,2,2))
	
	var a = Input_Model_Manager.new()
	#add_child(a)
	call_deferred("adding_child",a)
	a.myconstructor("res://3dModel/detailed_monkey/scene.gltf","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(2,2,2))
	#a.myconstructor("res://3dModel/blue-house/source/blue house.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(3,3,3))
	#a.myconstructor("res://3dModel/nissan/source/r34int.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(3,3,3))
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var a = preload("res://Prefab/input_model_manager.tscn").instantiate()

	#print(model.global_rotation_degrees)
	
	
	#a.myconstructor("res://MyFiles/monitor.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3.ZERO,Vector3(3,3,3))
	#adding_child(a)
	#var a:AABB = find_biggest_bounding_box(model)
	#print(a.size)
	#print("model global rotation:"+str(model.global_rotation_degrees))
	#*print("model size_first_way:"+str(model.get_aabb().size))
	#mymodel_manager.find_size_mesh_per_vertex(model)
	
	#print("model size_vertex_way:"+str(find_size_mesh_per_vertex(model)))
	
	#find_size_mesh_master__per_vertex(model)
	pass
func adding_child(a):
	get_parent().add_child(a)

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

func get_all_meshes_aabb_transfromed(mynodes):
	var allmeshes = []
	
	for i in mynodes:
		
		#if i is Node3D:
			#i.scale = Vector3.ONE
		if(i is MeshInstance3D):
			allmeshes.append(i.global_transform*i.get_aabb())
			#print("size aabb mesh:"+str(i.get_aabb().size))
			#print("center aabb mesh:"+str(i.get_aabb().get_center()))
	return allmeshes



func find_size_mesh_per_vertex(mymesh:MeshInstance3D):
	var _min = mymesh.global_transform.basis* mymesh.get_aabb().position
	var _max = mymesh.global_transform.basis*mymesh.get_aabb().end
	print("size_vertex_approah:"+str(_max-_min))

func find_size_mesh_master__per_vertex(mynode:Node3D):
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
	var mycenter= (max_v+min_v)/2
	print("size meshes:"+str(mysize))
	print("center:"+str(mycenter))
	#print("center rotation:"+str())
	return mysize

	
