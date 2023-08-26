extends Node3D
class_name  MyMovement

#const   path="res://3dModel/pen_scaled.glb"
#var myModel = preload(path)

@export var Model:VisualInstance3D

#@export var myVisualInstance:VisualInstance3D
#@export var ModelMesh:Mesh
#var a:VisualInstance3D
#@export var Node_model:Node3D


#@export var my_cam:Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	
#	add_child(myModel)
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("GetSize:"+str(Model.get_aabb().size))
	
	print("Get Center:"+str(Model.get_aabb().get_center()))
	var a:AABB = Model.global_transform*Model.get_aabb()
	print("Get Center space:"+str(a.get_center()))
	#print("Get center visual instance:"+str(myVisualInstance.get_aabb().get_center()))
	print("######")
	
	#print("Model mesh:"+str(ModelMesh.setup_local_to_scene()))
	#print("translate:"+ str(my_cam.translate_object_local(Model.get_aabb().get_center())))
	#print("change value:"+str(Node_model.to_global(Model.get_aabb().get_center())) )
	#print("get position:"+str(Model.get_aabb().position))
	#print("get end:"+str(Model.get_aabb().end))
	#print("origin:"+str(Model.global_transform.origin))
	
	

	
	

	

	pass

func move_up():
	
	pass




func _on_area_desk_body_entered(body):
	print("entered!!" + body.name)
	pass # Replace with function body.
