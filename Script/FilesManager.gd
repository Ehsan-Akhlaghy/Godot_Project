extends Resource
class_name  FileManager

var MyModel:Node3D
var my_model_manager:Input_Model_Manager 
var _path_file:String

#load glb file form hard disk drive 
func LoadFromFile(path:String):
	if(checkformat_file_glb(path)):
		var mygltf:GLTFDocument = GLTFDocument.new()
		var gltf_state:GLTFState = GLTFState.new()
		
		mygltf.append_from_file(path,gltf_state)
		var model= mygltf.generate_scene(gltf_state)
		return model


#checking format of file (just glb)
func checkformat_file_glb(Path:String)->bool:

	if(Path.get_extension().contains('glb')|| Path.get_extension().contains('gltf')):
		return true 
	else:
		return false
