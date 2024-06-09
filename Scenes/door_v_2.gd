extends Node3D

var isIn : bool = false
var isOpen : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isIn and Input.is_action_just_pressed("interact") and not isOpen:
		$AnimationPlayer.play("Open_Door")
		isOpen = true
	
	elif isIn and Input.is_action_just_pressed("interact") and isOpen:
		$AnimationPlayer.play("Close_Door")
		isOpen = false

func _on_interact_area_body_entered(body):
	isIn = true
	print("door true")

func _on_interact_area_body_exited(body):
	isIn = false
	print("door false")
