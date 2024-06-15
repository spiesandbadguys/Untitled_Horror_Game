extends Resource
class_name ItemData
@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: Texture
@export var mesh: Mesh

func use(target) -> void:
	pass
