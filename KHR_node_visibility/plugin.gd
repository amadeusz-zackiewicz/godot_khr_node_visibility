@tool
extends EditorPlugin

const EXTENSION_ID := "KHR_node_visibility"
const GLTF_VALUE := "value"
const GD_VALUE := "visible"
const PRIORITY := false
var instance: KHRNodeVisibility

func _enter_tree() -> void:
	instance = KHRNodeVisibility.new()
	GLTFDocument.register_gltf_document_extension(instance, PRIORITY)
	
func _exit_tree() -> void:
	GLTFDocument.unregister_gltf_document_extension(instance)
	instance = null

class KHRNodeVisibility extends GLTFDocumentExtension:
	func _get_supported_extensions() -> PackedStringArray:
		return PackedStringArray([EXTENSION_ID])
	
	func _import_object_model_property(state: GLTFState, split: PackedStringArray, partial_paths: Array[NodePath]) -> GLTFObjectModelProperty:
		if split.size() == 4 and split[3] == GLTF_VALUE:
			var prop := GLTFObjectModelProperty.new()
			prop.append_path_to_property(partial_paths[0], GD_VALUE)
			prop.set_types(TYPE_BOOL, GLTFObjectModelProperty.GLTF_OBJECT_MODEL_TYPE_BOOL)
			return prop
		return null
