extends Node


func _ready():

	
	
	var a = Input_Model_Manager.new("res://3dModel/detailed_monkey/scene.gltf","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(4,4,4))
	add_child(a)
	
	#a.myconstructor("res://3dModel/detailed_monkey/scene.gltf","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(4,4,4))
	#a.myconstructor("res://3dModel/blue-house/source/blue house.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3(0,5.3,-3),Vector3(3,3,3))
	
