extends CharacterBody3D
signal toggle_inventory()
@export var inventory_data: InventoryData
@onready var interact_ray = $Pivot/Head/Camera3D/InteractRay

#base function variables
var speed = 0
var keyCount = 0
@export var walkSpeed = 5
@export var runSpeed = 8
@export var gravity = 9.8
@export var jumpVelocity = 5
@export var lookSensitivity = 0.004
@export var crouchSpeed = 3
var isCrouching : bool = false
var isInMenu: bool = false
var isInInventory: bool = false

#headbob variables
@export var bobFreq = 2.4
@export var bobAmp = 0.08
var tBob = 0.0

#fov variables
@export var baseFov = 90
@export var fovChange = 1.2

@onready var pivot = $Pivot
@onready var head = $Pivot/Head
@onready var camera = $Pivot/Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if not isInMenu:
			head.rotate_y(-event.relative.x * lookSensitivity)
			camera.rotate_x(-event.relative.y * lookSensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(60))
	if Input.is_action_just_pressed("inventory") and not isInMenu:
		inventoryControl()
	if Input.is_action_just_pressed("interact"):
		interact()
		
func _physics_process(delta):
	#add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
			
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not isCrouching and not isInMenu and not isInInventory:
		velocity.y = jumpVelocity
		
	#sprint and sprint
	if Input.is_action_pressed("sprint") or Input.is_action_pressed("crouch") and not isInMenu and not isInInventory:
		if Input.is_action_pressed("sprint"):
			speed = runSpeed
		elif Input.is_action_pressed("crouch"):
			if not isCrouching:
				$Pivot.translate(Vector3(0, -0.5, 0))
				$Player_Collision.translate(Vector3(0, -0.5, 0))
				$Player_Collision.scale.y = 0.5
				
				isCrouching = true
			speed = crouchSpeed
	else:
		speed = walkSpeed
	
	if Input.is_action_just_released("crouch") and not isInMenu and not isInInventory:
		$Pivot.translate(Vector3(0, 0.5, 0))
		speed = walkSpeed
		isCrouching = false
		$Player_Collision.scale.y = 1
		$Player_Collision.translate(Vector3(0, 0.5, 0))

	#get input direction for movement
	var inputDir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if is_on_floor() and not isInMenu and not isInInventory:
		if direction:
			#velocity.x = direction.x * speed
			#velocity.z = direction.z * speed
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0) 
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0) 
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)

	#headbob
	tBob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(tBob)
	
	#fov 
	var velocityClamped = clamp(velocity.length(), 0.5, runSpeed * 2)
	var targetFov = baseFov + fovChange * velocityClamped
	camera.fov = lerp(camera.fov, targetFov, delta * 8.0)
	
	move_and_slide()
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bobFreq) * bobAmp
	pos.x = cos(time * bobFreq / 2) * bobAmp
	return pos
	
func _crouch() -> Vector3:
	var pos = Vector3.ZERO
	pos.y = -1 * bobAmp
	pos.x = pos.y
	return pos

func addKey():
	keyCount+=1
	print(keyCount)

func takeKey():
	keyCount-=1
	print(keyCount)

func getKeyCount():
	return keyCount

func getIsInMenu():
	return isInMenu

func setIsInMenu(inMenu:bool):
	velocity = zeroVector3(velocity)
	isInMenu = inMenu

func getIsInInventory():
	return isInInventory

func setIsInInventory(inMenu:bool):
	velocity = zeroVector3(velocity)
	isInInventory = inMenu

func zeroVector3(v):
	v.x = 0
	v.y = 0
	v.z = 0
	return v

func inventoryControl():
	velocity = zeroVector3(velocity)
	toggle_inventory.emit()
	isInInventory = !isInInventory

func interact():
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()
		velocity = zeroVector3(velocity)
		# toggle_inventory.emit()
		isInInventory = !isInInventory
