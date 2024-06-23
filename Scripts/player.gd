extends CharacterBody3D
<<<<<<< Updated upstream
signal toggle_inventory()
@export var inventory_data: InventoryData
@export var equip_inventory_data: InventoryDataEquip
@export var weapon_inventory_data: InventoryDataWeapon

@onready var interact_ray = $Pivot/Head/Camera3D/InteractRay
var health: int = 5
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes

#inventory variables
signal toggle_inventory()
@export var inventory_data: InventoryData
@export var equip_inventory_data: InventoryDataEquip
@export var weapon_inventory_data: InventoryDataWeapon

#raycast variable
@onready var interact_ray = $Pivot/Head/Camera3D/InteractRay
var health: int = 5
>>>>>>> Stashed changes

#player state variables
var speed = 0
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
var keyCount = 0
>>>>>>> Stashed changes
@export var walkSpeed = 5
@export var runSpeed = 8
@export var gravity = 9.8
@export var jumpVelocity = 5
@export var lookSensitivity = 0.004
@export var crouchSpeed = 3
var isCrouching : bool = false
<<<<<<< Updated upstream
var isInMenu: bool = false
var isInInventory: bool = false
=======
=======
@export var walkSpeed: int = 3
@export var runSpeed: int = 6
@export var gravity: int = 10
@export var jumpVelocity: int = 5
@export var lookSensitivity: float = 0.004
@export var crouchSpeed: float = 1.5
var isCrouching : bool = false
var isInMenu: bool = false
var isInInventory: bool = false
var light_on: bool
@onready var hand = $Pivot/Head/Camera3D/Hand
@onready var flashlight = $"Pivot/Head/Camera3D/Hand/Flashlight/light container"

#crouching variables for 
var standing_scale: float = 1.0
var target_scale_y: float = 2.0
var crouch_duration: float = 2.0
var elapsed_time: float = 0.0
>>>>>>> Stashed changes
>>>>>>> Stashed changes

#headbob variables
var bobFreq: float = 1
var bobAmp: float = 0.15
var tBob: float = 0.0
var HBOB_FREQ: float = 4

#fov variables
<<<<<<< Updated upstream
@export var baseFov = 90
@export var fovChange = 1.2
=======
@export var baseFov = 75
<<<<<<< Updated upstream
@export var fovChange = 1.5
=======
@export var fovChange = 0
>>>>>>> Stashed changes
>>>>>>> Stashed changes

@onready var pivot = $Pivot
@onready var head = $Pivot/Head
@onready var camera = $Pivot/Head/Camera3D

func _ready():
	PlayerManager.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	light_on = true
	standing_scale = scale.y

func _unhandled_input(event):
	if event is InputEventMouseMotion:
<<<<<<< Updated upstream
		if not isInMenu:
			head.rotate_y(-event.relative.x * lookSensitivity)
			camera.rotate_x(-event.relative.y * lookSensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(60))
=======
<<<<<<< Updated upstream
		head.rotate_y(-event.relative.x * lookSensitivity)
		camera.rotate_x(-event.relative.y * lookSensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-80), deg_to_rad(60))
=======
		if not isInMenu:
			head.rotate_y(-event.relative.x * lookSensitivity)
			camera.rotate_x(-event.relative.y * lookSensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(80))
			
			hand.rotate_y(-event.relative.x * (lookSensitivity * 1.1))
			hand.rotate_x(-event.relative.y * (lookSensitivity * 1.1))
			
			hand.rotation.x = clamp(hand.rotation.x, deg_to_rad(-10), deg_to_rad(10))#up down
			#hand.rotation.z = clamp(hand.rotation.z, deg_to_rad(-200), deg_to_rad(15))#not relevent?
			hand.rotation.y = clamp(hand.rotation.y, deg_to_rad(-20), deg_to_rad(20))#right/left
	
>>>>>>> Stashed changes
	if Input.is_action_just_pressed("inventory") and not isInMenu:
		inventoryControl()
	if Input.is_action_just_pressed("interact"):
		interact()
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
		
	_flashlight_toggle()
>>>>>>> Stashed changes
		
func _physics_process(delta):
	#add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
			
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not isCrouching and not isInMenu:
		velocity.y = jumpVelocity
		
	#sprint 
	if Input.is_action_pressed("sprint") or Input.is_action_pressed("crouch") and not isInMenu:
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
	
	if Input.is_action_just_released("crouch") and not isInMenu:
		$Pivot.translate(Vector3(0, 0.5, 0))
		speed = walkSpeed
		isCrouching = false
		$Player_Collision.scale.y = 1
		$Player_Collision.translate(Vector3(0, 0.5, 0))

	#get input direction for movement
	var inputDir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
<<<<<<< Updated upstream
	if is_on_floor() and not isInMenu:
=======
<<<<<<< Updated upstream
	if is_on_floor():
>>>>>>> Stashed changes
		if direction:
			#velocity.x = direction.x * speed
			#velocity.z = direction.z * speed
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0) 
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0) 
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
=======
	var target_velocity = Vector3(direction.x * speed, 0, direction.z * speed)
	
	if is_on_floor() and not isInMenu:
   	 # Apply input direction directly to velocity
		velocity.x = lerp(velocity.x, target_velocity.x, delta * 4)
		velocity.z = lerp(velocity.z, target_velocity.z, delta * 4)
	
	else:
		# Apply input direction with minimal adjustment (for air movement)
		velocity.x = lerp(velocity.x, target_velocity.x, delta * 0.2)
		velocity.z = lerp(velocity.z, target_velocity.z, delta * 0.2)
>>>>>>> Stashed changes

	#headbob
	tBob += (delta * 4) * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(tBob)
	
	# hand bob
	tBob += (delta) * (velocity.length() * 4) * float()
	hand.transform.origin = _item_bob(tBob) 
	
	#fov 
	var velocityClamped = clamp(velocity.length(), 0.5, runSpeed * 2)
	var targetFov = baseFov + fovChange * velocityClamped
	camera.fov = lerp(camera.fov, targetFov, delta * 8.0)
	
	move_and_slide()
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bobFreq) * (bobAmp / 3)
	pos.x = cos(time * bobFreq / 2) * (bobAmp / 3)
	return pos
	
func _crouch() -> Vector3:
	var pos = Vector3.ZERO
	pos.y = -1 * bobAmp
	pos.x = pos.y
	return pos

func takeKey():
	for index in inventory_data.slot_datas.size():
		if inventory_data.slot_datas[index]:
			if inventory_data.slot_datas[index].item_data.name == interact_ray.get_collider().getKeyType():
				inventory_data.slot_datas[index].quantity -= 1
				if inventory_data.slot_datas[index].quantity < 1:
					inventory_data.slot_datas[index] = null
				inventory_data.inventory_updated.emit(inventory_data)
				return

func getKeyCount():
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
	return keyCount
=======
>>>>>>> Stashed changes
	for index in inventory_data.slot_datas.size():
		if inventory_data.slot_datas[index]:
			if inventory_data.slot_datas[index].item_data.name == interact_ray.get_collider().getKeyType():
				return inventory_data.slot_datas[index].quantity
	return 0

func getIsInMenu():
	return isInMenu

func setIsInMenu(inMenu:bool):
	velocity = zeroVector3(velocity)
	isInMenu = inMenu

func getIsInInventory():
	return isInInventory

func setIsInInventory(inInventory:bool):
	isInInventory = inInventory

func zeroVector3(v):
	v.x = 0
	v.y = 0
	v.z = 0
	return v

func inventoryControl():
	toggle_inventory.emit()
	isInInventory = !isInInventory

func interact():
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()
		velocity = zeroVector3(velocity)
		# toggle_inventory.emit()
		if interact_ray.get_collider().is_in_group("external_inventory"):
			isInInventory = !isInInventory

func get_drop_position() -> Vector3:
	var direction = -camera.global_transform.basis.z
	return camera.global_position + direction

func heal(heal_value: int) -> void:
	health+=heal_value
<<<<<<< Updated upstream
=======
	
func _flashlight_toggle():
	if Input.is_action_just_pressed("flashlight toggle") and light_on:
		flashlight.hide()
		light_on = false
	elif Input.is_action_just_pressed("flashlight toggle") and not light_on:
		flashlight.show()
		light_on = true
		
func _item_bob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * 1) * bobAmp * 0.01
	pos.x = cos(time / 2) * bobAmp * 0.01
	pos.z = cos(time) * bobAmp * 0.01

	return pos
>>>>>>> Stashed changes
>>>>>>> Stashed changes
