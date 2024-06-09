extends Node3D

var isIn = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isIn and Input.is_action_just_pressed("interact"):
		%Player.addKey()
		queue_free()


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		isIn = true
		print("in")


func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		isIn = false
		print("out")
