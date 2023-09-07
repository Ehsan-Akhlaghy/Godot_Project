extends Node
class_name  MyFileManager




var MyModel:Node3D

@onready var my_model_manager:Input_Model_Manager = get_node("..")
var _path_file:String

#func _init(path:String):
	#my_model_manager = input_manager
	#_path_file = path
	#print(input_manager)
	
func _init():
	#_path_file = my_model_manager.path_asset_glb
	pass

func _ready():
	_path_file = my_model_manager.path_asset_glb
	#LoadFromFile(_path_file)
	call_deferred("LoadFromFile",_path_file)


func LoadFromFile(path:String):
	if(checkformat_file_glb(path)):
		var mygltf:GLTFDocument = GLTFDocument.new()
		var gltf_state:GLTFState = GLTFState.new()
		
		mygltf.append_from_file(path,gltf_state)
		
		#remove_pre_model()
		
		my_model_manager.Model= mygltf.generate_scene(gltf_state)
		
		if(my_model_manager.Model!=null):
			my_model_manager.new_file_added()
			





	
func checkformat_file_glb(Path:String)->bool:
	#print(File.get_as_text().to_lower())
	#=='gltf'
	if(Path.get_extension().contains('glb')|| Path.get_extension().contains('gltf')):
		return true 
	else:
		return false
	
#func remove_pre_model():
#	if(MyModel!=null):
#		remove_child(MyModel)
		






