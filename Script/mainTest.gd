extends Node

var b
# Called when the node enters the scene tree for the first time.
func _ready():

	
	var a = preload("res://Prefab/input_model_manager.tscn").instantiate()


	a.myconstructor("res://MyFiles/monitor.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3.ZERO,Vector3(3,3,3))
	
	#call_deferred("adding_child",a)


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var a = preload("res://Prefab/input_model_manager.tscn").instantiate()


	a.myconstructor("res://MyFiles/monitor.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3.ZERO,Vector3(3,3,3))
	adding_child(a)
	pass
func adding_child(a):
	add_child(a)
