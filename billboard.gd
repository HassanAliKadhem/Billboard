extends Node

var billboard: MeshInstance3D;
var flag: MeshInstance3D;

func change_image(newImage: ImageTexture) -> void:
	#print(newImage);
	var new_material: StandardMaterial3D = StandardMaterial3D.new();
	new_material.albedo_texture = newImage;
	if (get_tree().get_nodes_in_group("plane").size() > 0):
		billboard = get_tree().get_nodes_in_group("plane")[0];
		#print(billboard);
		billboard.set_surface_override_material(0, new_material);
	elif (get_tree().get_nodes_in_group("flag").size() > 0):
		flag = get_tree().get_nodes_in_group("flag")[0];
		#print(flag);
		flag.get_active_material(0).set_shader_parameter("texture_albedo", new_material.albedo_texture);
		
		#flag.set_instance_shader_parameter("texture_albedo", new_material)
