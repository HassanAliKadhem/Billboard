extends Node

var billboard: MeshInstance3D;

func change_image(newImage: ImageTexture) -> void:
	print(newImage);
	var new_material: StandardMaterial3D = StandardMaterial3D.new();
	new_material.albedo_texture = newImage;
	billboard = get_tree().get_nodes_in_group("plane")[0];
	print(billboard)
	billboard.set_surface_override_material(0, new_material);
