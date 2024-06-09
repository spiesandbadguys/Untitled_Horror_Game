extends Area3D

var isIn : bool = false
var isOpen : bool = false


@onready var animation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Open")
	animation.play("Close")
	#var animLib = AnimationLibrary.new()
	#var openAnim = $AnimationPlayer.get_animation("Open").duplicate()
	#animLib.add_animation("newOpen", openAnim)
	#$AnimationPlayer.add_animation_library("OpenLib", animLib)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isIn and Input.is_action_just_pressed("interact") and not isOpen:
		#var currentRot = Quaternion($Door2.transform.basis)
		#var targetRot = Quaternion(Vector3(0, -90, 0), 0)
		#var smoothRot = currentRot.slerp(targetRot, 0.5)
		#$Door2.transform.basis = Basis(smoothRot)
		#$Door2.rotation_degrees = lerp($Door2.rotation_degrees, Vector3(0, -90, 0), 0.1)
		animation.play("Open")
		isOpen = true
	elif isIn and Input.is_action_just_pressed("interact") and isOpen:
		#$Door2.rotation_degrees = lerp($Door2.rotation_degrees,Vector3(0, 0, 0), 0.1)
		animation.play("Close")
		isOpen = false

func _on_body_entered(body):
	isIn = true
	
	
func _on_body_exited(body):
	isIn = false
	
