extends Node

var b
# Called when the node enters the scene tree for the first time.
func _ready():

	
	var a = preload("res://Prefab/input_model_manager.tscn").instantiate()
	var modelmanager=a.myconstructor("res://MyFiles/monitor.glb","res://3dModel/Desk/deskglb.glb",Vector3(-1,-1,-1),Vector3.ZERO,Vector3(3,3,3))
	
	call_deferred("add_node",a)
	
	#var b =preload("res://Prefab/file_manager.tscn").instantiate()
	#call_deferred("add_node",b)
	#b.my_model_manager = modelmanager
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#var a = Input_Model_Manager.new("as","res://3dModel/Desk/deskglb.glb",Vector3.ZERO)
	#const script = preload("res://Script/Input_Model_Calib.gd")
	#var b = Node3D.new()
	#b.set_script(script)
	#add_child(b)


	
	
	#ehsan(b)
	pass
func add_node(mynode:Node3D):
	get_parent().add_child(mynode)
	pass
