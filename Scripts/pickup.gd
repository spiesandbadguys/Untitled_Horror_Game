extends RigidBody3D

@export var slot_data: SlotData
@onready var mesh_3d: MeshInstance3D = $mesh

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_3d.mesh = slot_data.item_data.mesh
	var rotation_deg = randi() % 360
	mesh_3d.rotate_y(rotation_deg)

func player_interact():
	if get_node("../Player").inventory_data.pick_up_slot_data(slot_data):
			queue_free()
