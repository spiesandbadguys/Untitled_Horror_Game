extends RigidBody3D

@export var slot_data: SlotData
@onready var mesh_3d: MeshInstance3D = $mesh
var isIn = false
var collision_body = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isIn and Input.is_action_just_pressed("interact") and not %Player.getIsInMenu():
		# %Player.addKey()
		if collision_body.inventory_data.pick_up_slot_data(slot_data):
			queue_free()


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		isIn = true
		collision_body = body
		print("in")


func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		isIn = false
		print("out")
