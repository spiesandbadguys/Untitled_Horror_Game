extends Node3D

var isIn : bool = false
var isOpen : bool = false
var isUnlocked : bool = false

@export var keyType: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isIn and not isOpen and %Player.getKeyCount() > 0 and not isUnlocked:
		$AnimationPlayer.play("Open_Door")
		isOpen = true
		isUnlocked = true
		%Player.takeKey()
	elif isIn and not isOpen and isUnlocked:
		$AnimationPlayer.play("Open_Door")
		isOpen = true
	elif isIn and isOpen:
		$AnimationPlayer.play("Close_Door")
		isOpen = false
	isIn = false

func player_interact():
	isIn = true

func getKeyType():
	return keyType
	
