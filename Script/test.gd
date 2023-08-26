extends Node3D
class_name  MyMovement

#@export var Ehsan:Node3d

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_up():
	
	pass




func _on_area_desk_body_entered(body):
	print("entered!!" + body.name)
	pass # Replace with function body.
