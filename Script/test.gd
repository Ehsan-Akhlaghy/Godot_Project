extends Node3D
class_name  MyMovement

#const   path="res://3dModel/pen_scaled.glb"
#var myModel = preload(path)

#@export var Model:Node3D

#@export var my_char:CharacterBody3D

#@export var myVisualInstance:VisualInstance3D
#@export var ModelMesh:Mesh
#var a:VisualInstance3D
#@export var Node_model:Node3D

@onready var myray:RayCast3D =  $"../../RayCast3D"

@export var target_pos:Node3D

#@export var my_cam:Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	

	
	
#	add_child(myModel)
	pass # Replace with function body.

#func _physics_process(delta):
#	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if(myray!=null):
		#myray.target_position =Vector3(-0.149,-0.271,30.613)
		
		#if(myray.is_colliding()):
		#	print(myray.get_collider().get_parent().name)
	
	#print("GetSize:"+str(Model.get_aabb().size))
	
	#print("Get Center:"+str(Model.get_aabb().get_center()))
	#var a:AABB = Model.global_transform*Model.get_aabb()
	#print("model global transform:"+str(Model.global_transform))
	#print("model aabb:"+str(Model.get_aabb()))
	#print("Multiply:"+str(a.get_center()))
	#print("size"+str(a.size))
	#print("size basis:"+str( Model.global_transform.basis.get_scale()*Model.get_aabb().size))
	#print("Get center visual instance:"+str(myVisualInstance.get_aabb().get_center()))
	#print("######")
	
	#print("severalMeshes_center" +str(all_centers(Model)))
	
	

	
	

	

	pass



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


func all_centers(mymodel:Node3D):
	var allmeshes = []
	var all_center = []
	allmeshes=get_all_meshes(get_all_children(mymodel))
	for i in allmeshes:
		#print(i)
		all_center.append( i.global_transform*i.get_aabb().get_center() )
		
	
		
	var sum:Vector3 = Vector3.ZERO	
	for i in all_center:
		sum+=i
	#print("sum:"+str(sum))
	#print("all center size:"+str(all_center.size()))
	print("Division:"+str(sum/all_center.size()))
	#print(mymodel.to_global(sum/all_center.size()))
	return sum/all_center.size()




func move_up():
	
	pass


	


func _on_area_desk_body_entered(body):
	print("entered!!" + body.name)
	pass # Replace with function body.
