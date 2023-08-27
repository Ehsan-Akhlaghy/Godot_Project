extends Node


var myfiles


var MyModel:Node3D

@export var my_model_manager:Input_Model_Manager

@export var myfiledialog:FileDialog 


# Called when the node enters the scene tree for the first time.
func _ready():
	#call_deferred("Myload()")
	#LoadFromFolder() 
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func LoadFromFolder():
	
	#myfiles = ResourceLoader.load("res://MyFiles")
	#var mydir: =DirAccess.open("res://MyFiles")
	
	#var myfiles =DirAccess.get_files_at("res://MyFiles")
	
	#for i in myfiles:
		#print("Name of files:"+ i)
		
		#var file:FileAccess =FileAccess.open("res://MyFiles/"+i,FileAccess.READ)
		#var content:PackedByteArray = file.get_buffer(file.get_length())
		
		#mygltf.append_from_buffer(content,"",gltf_state)
		
		#var Mynode:Node3D = mygltf.generate_scene(gltf_state)
		
		#add_child(Mynode)
		
		#print("file:"+content)
		
		#var myresource:PackedScene = load("res://MyFiles/" +i)
		
		#var mymesh:MeshInstance3D = MeshInstance3D.new()
		#mymesh.mesh = myresource
		
		#var myresource2:PackedScene =load("res://MyFiles/monitor.glb")
		#print("myresourceName2:"+ myresource2.resource_name)
		#print("myresourceName:"+ myresource.resource_name)
		
		
		#add_child(mymesh)
		#add_child(myresource)
	
func LoadFromFile(path:String):
	#var file:FileAccess =FileAccess.open(path,FileAccess.READ)
	#print(file.get_as_text())
	if(checkformat_file_glb(path)):
		#var content:PackedByteArray = file.get_buffer(file.get_length())
		
		#var content = file.get_file_as_string(path)
		
		#mygltf.append_from_buffer(content,"",gltf_state)
		
		var mygltf:GLTFDocument = GLTFDocument.new()
		var gltf_state:GLTFState = GLTFState.new()
		
		mygltf.append_from_file(path,gltf_state)
		
		remove_pre_model()
		
		my_model_manager.Model= mygltf.generate_scene(gltf_state)
		
		if(my_model_manager.Model!=null):
			my_model_manager.new_file_added()
		
		#add_child(MyModel)	
	else:
		#print("not proper file!")
		myfiledialog.title = "PLEASE SELECT A GLTB FILE!!"
		
		myfiledialog.visible = true
		
		#var a:Button = myfiledialog.get_ok_button()
		#var b:Button =myfiledialog.get_cancel_button()
	
		
		#a.button_down.connect(_myprint)
		#b.pressed.connect(_myprint)
	
# Replace with function body.


func _on_file_dialog_file_selected(path):
	
	call_deferred("LoadFromFile",path)
	
func checkformat_file_glb(Path:String)->bool:
	#print(File.get_as_text().to_lower())
	#=='gltf'
	if(Path.get_extension().contains('glb')|| Path.get_extension().contains('gltf')):
		return true 
	else:
		return false
	
func remove_pre_model():
	if(MyModel!=null):
		remove_child(MyModel)






