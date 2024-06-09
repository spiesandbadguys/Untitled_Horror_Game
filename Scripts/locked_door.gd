extends Node3D

var isIn : bool = false
var isOpen : bool = false
var isUnlocked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isIn and Input.is_action_just_pressed("interact") and not isOpen and %Player.getKeyCount() > 0 and not isUnlocked:
		$AnimationPlayer.play("Open_Door")
		isOpen = true
		isUnlocked = true
		%Player.takeKey()
	elif isIn and Input.is_action_just_pressed("interact") and not isOpen and isUnlocked:
		$AnimationPlayer.play("Open_Door")
		isOpen = true
	elif isIn and Input.is_action_just_pressed("interact") and isOpen:
		$AnimationPlayer.play("Close_Door")
		isOpen = false

func _on_interact_area_body_entered(body):
	if body.is_in_group("Player"):
		isIn = true
		# print("door true")

func _on_interact_area_body_exited(body):
	if body.is_in_group("Player"):
		isIn = false
		# print("door false")
